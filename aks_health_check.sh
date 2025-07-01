#!/bin/bash

# Load Balancer Unhealthy Target Checker
# 모든 Load Balancer를 조회하고 unhealthy target이 있는 LB를 찾는 스크립트

set -e

# 색상 코드 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 로그 함수
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# AWS CLI 설치 확인
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI가 설치되어 있지 않습니다."
        exit 1
    fi

    # AWS 자격 증명 확인
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "AWS 자격 증명이 설정되지 않았습니다."
        exit 1
    fi
}

# 모든 Load Balancer 조회
get_all_load_balancers() {
    log_info "모든 Load Balancer를 조회하는 중..."

    # ALB와 NLB 모두 조회
    aws elbv2 describe-load-balancers \
        --query 'LoadBalancers[*].[LoadBalancerArn,LoadBalancerName,Type,State.Code]' \
        --output text
}

# 특정 Load Balancer의 Target Groups 조회
get_target_groups_for_lb() {
    local lb_arn=$1

    aws elbv2 describe-target-groups \
        --load-balancer-arn "$lb_arn" \
        --query 'TargetGroups[*].[TargetGroupArn,TargetGroupName]' \
        --output text 2>/dev/null || echo ""
}

# Target Group의 unhealthy targets 확인
check_unhealthy_targets() {
    local tg_arn=$1
    local tg_name=$2

    local unhealthy_count=$(aws elbv2 describe-target-health \
        --target-group-arn "$tg_arn" \
        --query 'length(TargetHealthDescriptions[?TargetHealth.State==`unhealthy`])' \
        --output text 2>/dev/null || echo "0")

    if [ "$unhealthy_count" -gt 0 ]; then
        echo "$unhealthy_count"

        # Unhealthy targets의 상세 정보 출력
        echo "    Unhealthy Targets:"
        aws elbv2 describe-target-health \
            --target-group-arn "$tg_arn" \
            --query 'TargetHealthDescriptions[?TargetHealth.State==`unhealthy`].[Target.Id,Target.Port,TargetHealth.Description]' \
            --output text 2>/dev/null | while read -r target_id target_port description; do
            echo "      - Target: $target_id:$target_port, Reason: $description"
        done
    else
        echo "0"
    fi
}

# 메인 함수
main() {
    echo "=========================================="
    echo "Load Balancer Health Check Script"
    echo "=========================================="
    echo ""

    # AWS CLI 확인
    check_aws_cli

    # 현재 AWS 계정 정보 출력
    local account_id=$(aws sts get-caller-identity --query 'Account' --output text)
    local region=$(aws configure get region)
    log_info "AWS Account: $account_id, Region: $region"
    echo ""

    # 모든 Load Balancer 조회
    local lb_list=$(get_all_load_balancers)

    if [ -z "$lb_list" ]; then
        log_warn "Load Balancer가 없습니다."
        exit 0
    fi

    local total_lb_count=$(echo "$lb_list" | wc -l)
    log_info "총 $total_lb_count개의 Load Balancer를 발견했습니다."
    echo ""

    local unhealthy_lb_count=0

    # 각 Load Balancer 검사
    while IFS=$'\t' read -r lb_arn lb_name lb_type lb_state; do
        log_info "검사 중: $lb_name ($lb_type)"

        if [ "$lb_state" != "active" ]; then
            log_warn "  상태: $lb_state (활성화되지 않음)"
            echo ""
            continue
        fi

        # Target Groups 조회
        local tg_list=$(get_target_groups_for_lb "$lb_arn")

        if [ -z "$tg_list" ]; then
            log_warn "  Target Group이 없습니다."
            echo ""
            continue
        fi

        local has_unhealthy=false
        local total_unhealthy=0

        # 각 Target Group 검사
        while IFS=$'\t' read -r tg_arn tg_name; do
            if [ -n "$tg_arn" ]; then
                local unhealthy_result=$(check_unhealthy_targets "$tg_arn" "$tg_name")
                local unhealthy_count=$(echo "$unhealthy_result" | head -n1)

                if [ "$unhealthy_count" -gt 0 ]; then
                    if [ "$has_unhealthy" = false ]; then
                        log_error "  ❌ UNHEALTHY TARGETS FOUND!"
                        has_unhealthy=true
                    fi
                    echo "  Target Group: $tg_name"
                    echo "  Unhealthy Count: $unhealthy_count"
                    echo "$unhealthy_result" | tail -n +2
                    total_unhealthy=$((total_unhealthy + unhealthy_count))
                fi
            fi
        done <<< "$tg_list"

        if [ "$has_unhealthy" = true ]; then
            unhealthy_lb_count=$((unhealthy_lb_count + 1))
            echo "  Total Unhealthy Targets: $total_unhealthy"
        else
            log_success "  ✅ 모든 Target이 정상입니다."
        fi

        echo ""

    done <<< "$lb_list"
    
    # 결과 요약
    echo "=========================================="
    echo "검사 결과 요약"
    echo "=========================================="
    echo "총 Load Balancer 수: $total_lb_count"
    echo "Unhealthy Target이 있는 Load Balancer 수: $unhealthy_lb_count"

    if [ "$unhealthy_lb_count" -gt 0 ]; then
        log_error "⚠️  일부 Load Balancer에 문제가 있습니다!"
        exit 1
    else
        log_success "🎉 모든 Load Balancer가 정상입니다!"
        exit 0
    fi
}

# 스크립트 실행
main "$@"


