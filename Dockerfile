# Official Python image
FROM python:3.8.2-alpine3.11

COPY entrypoint.sh /usr/local/bin
RUN ln -s /usr/local/bin/entrypoint.sh / # backwards compat

ENV APK_PACKAGES \
  bash \
  jq

RUN set -x && \
    \
    env && \
    echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
    \
    echo "==> Installing APKs..."  && \
    apk add --no-cache ${APK_PACKAGES} && \
    \
    echo "===> Installing AWS Boto3, jinja2..."  && \
    pip install --no-cache-dir boto3 jinja2 && \
    \
    echo "===> Cleaning up..."  && \
    unset http_proxy https_proxy && \
    chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /src

VOLUME [ "/src" ]

ENTRYPOINT ["entrypoint.sh"]
CMD ["python"]

# http://label-schema.org/rc1/ namespace labels
LABEL org.label-schema.schema-version="1.0"
#LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="aws-sdk-py"
LABEL org.label-schema.description="AWS SDK for Python"
#LABEL org.label-schema.url=$ORG_WEB_URL
#LABEL org.label-schema.vcs-url=$VCS_URL
#LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="devtestlabs.xyz"
#LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd='docker run --rm -it -v $(pwd):/src aws-sdk-py {{ PYTHON_SCRIPT }}'
