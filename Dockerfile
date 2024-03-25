# --- Installer Stage ---
FROM public.ecr.aws/amazonlinux/amazonlinux:2023 as installer

ARG AWSCLI_LINK="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
ARG AWSCLI_FILE="awscli-exe-linux-x86_64.zip"
ARG SIGNER_BINARY_LINK="https://d2hvyiie56hcat.cloudfront.net/linux/amd64/installer/rpm/latest/aws-signer-notation-cli_amd64.rpm"
ARG SIGNER_BINARY_FILE="aws-signer-notation-cli_amd64.rpm"

RUN yum update -y && \ 
    yum install -y unzip less groff jq tar && \
    curl -LO $AWSCLI_LINK && \
    curl -LO $SIGNER_BINARY_LINK && \
    unzip $AWSCLI_FILE && \
    ./aws/install --bin-dir /aws-cli-bin/ && \
    yum install -y $SIGNER_BINARY_FILE && \
    yum clean all 

# --- Final Stage ---
FROM public.ecr.aws/amazonlinux/amazonlinux:2023

COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/ 
COPY --from=installer /aws-cli-bin/ /usr/local/bin/
COPY --from=installer /usr/local/bin/notation /usr/local/bin/notation
COPY --from=installer /root/.config /root/.config

WORKDIR /aws
ENTRYPOINT ["/usr/local/bin/aws"] 
