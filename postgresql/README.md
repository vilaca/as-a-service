

```
helm install postgresql oci://registry-1.docker.io/bitnamicharts/postgresql \
     --set global.postgresql.auth.username=lemmy \
     --set global.postgresql.auth.password=lemmy \
     --set global.postgresql.auth.database=lemmy

```
