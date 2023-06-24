
hetzner-k3s create -c single-node.yaml

path=$(pwd)
export KUBECONFIG="$path"/kubeconfig

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

argocd cluster add single-node

kubectl port-forward svc/argocd-server -n argocd 8080:443&>2 &
export argo_host=localhost:8080
argocd admin initial-password -n argocd
argocd login "$argo_host"

kubectl create ns monitoring
kubectl create ns dashboard
kubectl config set-context --current --namespace=argocd

argocd app create apps \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo https://github.com/vilaca/as-a-service \
    --path argocd
argocd app sync apps  
