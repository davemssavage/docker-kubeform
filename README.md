Build and run via Docker

```bash
docker build -t davemssavage/kubeform-ctl .
```

To deploy kubernetes using terraform to aws

```bash
docker -run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY davemssavage/kubeform-ctl create
```

To deploy kubernetes using ansible to aws

```bash
docker -run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY davemssavage/kubeform-ctl apply
```

To destroy kubernetes using terraform from aws

```bash
docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY davemssavage/kubeform-ctl destroy
```
