## Run Script

### Backup Mongo

#### Create PVC

```shell
kubectl create tools
kubectl --namespace tools create -f backup-pvc.yaml

```

#### Create CronJob

```shell
kubectl --namespace tools apply -f cron-mongodump-backup.yaml
kubectl get job -n tools
```

#### Logs

```shell
kubectl -n tools logs mongodump-backup
```
