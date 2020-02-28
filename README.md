# AWS SDK for Python image
![](https://github.com/devtestlabs-xyz/aws-boto3-container/workflows/Build%20and%20Publish%20Docker/badge.svg)
This project manages the assets required to build a lightweight AWS SDK for Python (Boto3) OCI compliant image that can be used with Docker and Podman.

The image is based on the [Official Python Docker image](https://hub.docker.com/_/python). [AWS SDK for Python - Boto3](https://aws.amazon.com/sdk-for-python/) and [Jinja2 Python templating engine](https://palletsprojects.com/p/jinja/) installed. The resulting image weighs in at about 169MB!

The OCI image is currently published to https://hub.docker.com/u/devtestlabs/aws-sdk-py.

# Getting Started
## Get the image from DockerHub
```
docker pull devtestlabs/aws-sdk-py
```

## Run the container
If your goal is to execute python scripts that fetch meta-data from your AWS tenant you'll need to bind mount your AWS `credentials` and optional `config` files.

*.example .aws/credentials file*
```
[default]
aws_access_key_id=XXXXXXXXXXXXXXXXXXXX
aws_secret_access_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

```

*.example .aws/credentials file*
```
[default]
region=us-west-2
```

*See [Boto3 Quickstart](https://github.com/boto/boto3#quick-start) for more information.*

```
docker run \
  -it --rm \
  -v /host/path/to/python/scripts:/src
  -v /super/secret/host/path/to/.aws/dir:~/.aws
  devtestlabs/aws-sdk-py {{ SOME_PYTHON_SCRIPT }}
```

*NOTE: Volume bind mount host path where your Python scripts live. The `/src` path on container side is the working directory and by default the `python` command is executed. So all you have to do is specify which Python script you want to execute.*

# Build the image locally
```
docker build -t aws-sdk-py .
```

# External References
* https://hub.docker.com/_/python

* https://aws.amazon.com/sdk-for-python/

* https://github.com/boto/boto3#quick-start

* https://palletsprojects.com/p/jinja/

* https://hub.docker.com/u/devtestlabs/aws-sdk-py