CLUSTER_NAME?=chart-testing

cluster:
	@kind create cluster --name $(CLUSTER_NAME)

delete-cluster:
	@kind delete cluster --name $(CLUSTER_NAME)

apply:
	@scripts/test.sh -v apply

label_check:
	@scripts/test.sh -v label_check

delete:
	@scripts/test.sh -v delete
