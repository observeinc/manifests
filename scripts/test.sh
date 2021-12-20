#!/usr/bin/env bash
set -o errexit
set -o pipefail

DIE() { echo "${R}E! $*${r}" 1>&2; exit 1; }
INFO() { echo "${B}I: $*${r}" 1>&2; }
DEBUG() { test -z "$VERBOSE" || echo "D: $*" 1>&2; }

R="[1;31m"
B="[1;34m"
r="[m"

KUSTOMIZE_DIR="${KUSTOMIZE_DIR:=stack}"
CLUSTER_NAME="${CLUSTER_NAME:=unknown}"
WAIT_TIMEOUT="${WAIT_TIMEOUT:=30s}"

usage() {
    echo "${B}$0 [-hv] <command>${r}"
    echo "  -h     this help"
    echo "  -v     verbose"
    echo
    echo "  ${B}apply${r}       Apply kustomized manifest"
    echo "  ${B}delete${r}      Delete kustomized manifest"
    echo "  ${B}label_check${r} Verify all resources contain correct label"
    echo
    exit 1
}

check_context() {
    if [[ `kubectl config current-context` != kind* ]]; 
    then
        DIE "Context must be created by kind"
    fi;
}

do_apply() {
    check_context

    DEBUG "$(kubectl cluster-info)"

    INFO "Applying kustomized directory"
    RESULT=$(kubectl apply -k ${KUSTOMIZE_DIR})
    DEBUG "$RESULT"

    INFO "Annotating namespace"
    RESULT=$(kubectl annotate namespace observe --overwrite "observeinc.com/cluster-name=${CLUSTER_NAME}")
    DEBUG "$RESULT"

    INFO "Creating secret"
    # this is an arcane way of doing things, but it allows overwriting existing secret without
    # relying on kubectl --dry-run semantics, which is version dependent
    RESULT=$(kubectl apply -f - << EOF
    {
        "kind": "Secret",
        "apiVersion": "v1",
        "metadata": {
            "name": "credentials",
            "namespace": "observe",
            "annotations": {
                "kubectl.kubernetes.io/last-applied-configuration": ""
            }
        },
        "data": {
            "customer": "$(echo -n $OBSERVE_CUSTOMER | base64)",
            "token": "$(echo -n $OBSERVE_TOKEN | base64)"
        }
    }
EOF)
    DEBUG "$RESULT"

    INFO "Waiting on pods to be ready"
    if kubectl wait pods -n observe --for=condition=Ready --all --timeout=${WAIT_TIMEOUT}; then
        INFO "Pods ready"
        return
    else
        diagnostics
        DIE "Pod readiness timed out"
    fi
}

do_label_check() {
    KUSTOMIZED=`find . -name 'kustomization.yaml' -exec dirname {} ';'`
    for DIR in $KUSTOMIZED
    do
        rc=0
        RESULT=$(kubectl apply -k ${DIR} --dry-run=client -o yaml -l \!observeinc.com/component 2>&1) || rc=$?
        if [ "$rc" == 0 ]; then
            DEBUG "$RESULT"
            DIE "Resources missing component label in ${DIR}"
        else
            DEBUG "${DIR} labels check out"
        fi
    done
    return
}

do_delete() {
    check_context

    if kubectl delete -k ${KUSTOMIZE_DIR} --wait --timeout=${WAIT_TIMEOUT}; then
        return
    else
        diagnostics
        DIE "Pod deletion timed out"
    fi
}

diagnostics() {
    kubectl version
    kubectl get pods -n observe
    kubectl describe pods -n observe
}

while getopts 'hv' OPTION; do
    case $OPTION in
        v) VERBOSE=1 ;;
        *) usage ;;
    esac
done
shift $((OPTIND-1)); OPTIND=1
[[ -n "$VERBOSE" ]] && export VERBOSE

if [[ $# -lt 1 ]]; then usage; fi # Requires 1+ arguments
COMMAND="$1"
shift

"do_${COMMAND//-/_}" "$@"
