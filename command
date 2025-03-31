# local
curl -LO "https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

echo 'alias k="kubectl"' >> ~/.bashrc
echo 'alias kns="kubectl config set-context --current --namespace"' >> ~/.bashrc
source ~/.bashrc

aws eks update-kubeconfig --region ap-northeast-2 --name kubernetes

eksctl utils associate-iam-oidc-provider   --region ap-northeast-2   --cluster kubernetes   --approve