
hetzner-k3s create -c single-node.yaml

path=$(pwd)
export KUBECONFIG="$path"/kubeconfig

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl rollout status deploy/argocd-server --timeout=5m
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
sleep 15

export argo_host=localhost:8080
argocd admin initial-password -n argocd
argocd login "$argo_host"
argocd cluster add single-node

kubectl config set-context --current --namespace=argocd
argocd app create app-of-apps \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --path argocd \
    --repo https://github.com/vilaca/as-a-service \
    --sync-policy auto
