
### 官方文档：https://www.kubernetes.org.cn/doc-11
### 官方文档：http://docs.kubernetes.org.cn/227.html

**1.k8s安装：**
    
    1.安装docker
    2.docker安装完成之后开始安装 kubeadm，kubelet和kubectl三个组件，由于官方提供的谷歌镜像我们无法访问，我们使用阿里云镜像仓库解决这个问题
      添加yum源配置:
      cat <<EOF > /etc/yum.repos.d/kubernetes.repo
      [kubernetes]
      name=Kubernetes
      baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
      enabled=1
      gpgcheck=0
      repo_gpgcheck=0
      gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
      EOF
    3.yum源配置完成，开始安装kubelet，kubeadm和kubectl，出现图中complete表示安装完成
      yum -y install kubelet kubeadm kubectl
    4.
