
```
helm install postgresql oci://registry-1.docker.io/bitnamicharts/postgresql \
     --set global.postgresql.auth.username=lemmy \
     --set global.postgresql.auth.password=lemmy \
     --set global.postgresql.auth.database=lemmy
```
reference: https://github.com/bitnami/charts/tree/main/bitnami/postgresql/#installing-the-chart


```
    kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 -d
```
