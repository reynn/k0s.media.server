# CronJob: Porkbun DNS Updater

Updates the DNS records on Porkbun using their [API](https://porkbun.com/api/json/v3/documentation).

## Setup

```shell
# Create a secret containing our Porkbun API Key, Secret API Key and Domain
$ kubectl create secret generic \
    --from-literal dns=k0s.media.net \
    --from-literal api.key=pk1_.... \
    --from-literal secret.key=sk1_.... \
    --namespace default \
    porkbun-dns
```
