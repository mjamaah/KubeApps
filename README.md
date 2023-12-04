# Github Action for Kubernetes CLI (Kubectl and helm)

This action provides `kubectl v1.28.4` and `helm` for Github Actions.

## Usage (kubectl)

In your workflow, here is an example that deploys your new image and verifies it is successful.

```yaml
on: push
name: Deploy
jobs:
  deploy:
    name: Deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Deploy to cluster
      uses: mjamaah/kubeapps@master
      with:
        kube_config: ${{ secrets.kube_config }}
        command: set image --record deployment/<my-deploy> <my-container>=<my-image>:<new-tag>
        action: kubectl
    - name: Verify deployment
      uses: mjamaah/kubeapps@master
      with:
        kube_config: ${{ secrets.kube_config }}
        command: '"rollout status deployment/<my-deploy>"'
        action: kubectl
```

## Usage (helm)

In your workflow, here is an example that installs a helm release.

```yaml
on: push
name: Deploy
jobs:
  deploy:
    name: Deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Deploy to cluster
      uses: mjamaah/kubeapps@master
      with:
        kube_config: ${{ secrets.kube_config }}
        command: upgrade --install -n <NameSpace> <Release> <Chart>
        action: helm
```


## Kube configuration

Make sure to base64-encode your kubeconfig file and put it in a github secret.  You can get the string by running:

```bash
cat $HOME/.kube/config | base64
```
