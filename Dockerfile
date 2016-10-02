FROM    centos:centos7

# Enable Extra Packages for Enterprise Linux (EPEL) for CentOS
RUN yum install -y epel-release
RUN yum install -y make git curl unzip gcc libffi-devel openssl-devel ruby ruby-devel rubygems python-devel python-pip
RUN	gem install json

# Install Terraform
RUN	curl -O https://releases.hashicorp.com/terraform/0.7.4/terraform_0.7.4_linux_amd64.zip
RUN	unzip terraform_0.7.4_linux_amd64.zip -d /usr/local/bin

# Install KubeCTL
RUN	curl -O https://storage.googleapis.com/kubernetes-release/release/v1.3.8/bin/linux/amd64/kubectl
RUN	chmod +x kubectl
RUN	mv kubectl /usr/local/bin/kubectl

# Install Kubeform
RUN	git clone https://github.com/davemssavage/kubeform.git /home/kubeform
WORKDIR /home/kubeform
RUN     git checkout terraform-7
RUN	pip install -r requirements.txt
WORKDIR /home/kubeform/terraform/aws/public-cloud

RUN	terraform get || true
RUN	for i in $(ls .terraform/modules/*/Makefile); do i=$(dirname $i); make -C $i; done
RUN	terraform get

#ENV TF_VAR_STATE_ROOT=/home/kubeform/terraform/aws/public-cloud

RUN 	pip install --upgrade setuptools
WORKDIR	/home/kubeform
RUN	ansible-galaxy install -r requirements.yml

COPY kubeform-ctl /usr/local/bin
RUN	chmod +x /usr/local/bin/kubeform-ctl

ENTRYPOINT /usr/local/bin/kubeform-ctl
