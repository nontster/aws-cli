# aws-cli
aws-cli container image with notation-aws-signer-plugin, jq, zip, and tar

I make this container image to use with Bitbucket pipeline 
the original aws-cli lacks of notation-aws-signer-plugin, jq, zip, and tar bundled which used in the pipeline

Building container image for amd64
```
docker buildx build --platform linux/amd64  -t your_docker_account/aws-cli:latest --push .
```
