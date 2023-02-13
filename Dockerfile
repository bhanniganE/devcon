## set base image
#

  FROM python


## set working directory in the container
#

  WORKDIR /tmp


## install packages
#

  ARG DEBIAN_FRONTEND=noninteractive

  RUN apt-get update               \
   && apt-get upgrade -y           \
   && apt-get install -y apt-utils \
   && apt-get install -y           \
        vim                        \
        less                       \
		lsb-release                \
		apt-utils                  \
   && apt-get clean                \
   && rm -rf /var/lib/apt/lists/*


## copy dependencies to the working directory
#

  COPY requirements.txt .


## update the dependencies
#

  RUN pip config set global.trusted-hosts "pypi.org pypi.python.org files.pythonhosted.org"
  RUN pip install --upgrade pip
  RUN pip install -r requirements.txt
  RUN rm requirements.txt


## install terraform
#

  RUN wget -qO hashicorp.key https://apt.releases.hashicorp.com/gpg \
   && gpg --dearmor hashicorp.key \
   && mv hashicorp.key.gpg /usr/share/keyrings/hashicorp-archive-keyring.gpg \
   && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list \
   && apt-get update \
   && apt-get install terraform \
   && rm hashicorp.key


## install Azure CLI
#
  RUN curl -sL https://aka.ms/InstallAzureCLIDeb -o /tmp/azure_install.sh \
   && bash /tmp/azure_install.sh \
   && rm /tmp/azure_install.sh


## install AWS CLI
#
  RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
   && unzip /tmp/awscliv2.zip \
   && ./aws/install \
   && rm -rf /tmp/aws /tmp/awscliv2.zip


# copy contents of local src directory to the working directory
# COPY ./src src

