#!/bin/bash

# ANSI Color Codes
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m" # No Color

echo -e "\nKubernetes Cluster Workload Health Check\n"

# Get workloads status
kubectl get pods --all-namespaces -o wide | awk -v GREEN="$GREEN" -v YELLOW="$YELLOW" -v RED="$RED" -v NC="$NC" '
BEGIN {
    printf "%-20s %-30s %-15s %-10s %-10s %s\n", "NAMESPACE", "POD NAME", "STATUS", "RESTARTS", "NODE", "IP"
    printf "-----------------------------------------------------------------------------------------------\n"
}
NR>1 {
    namespace=$1
    pod=$2
    status=$4
    restarts=$5
    node=$8
    ip=$7

    color=NC
    if (status ~ /Running/) color=GREEN
    else if (status ~ /Pending/) color=YELLOW
    else if (status ~ /CrashLoopBackOff|Error|Failed|ImagePullBackOff/) color=RED

    printf "%-20s %-30s ", namespace, pod
    printf "%s%-15s%s ", color, status, NC
    printf "%-10s %-10s %s\n", restarts, node, ip
}
'

