# pull base image
FROM puckel/docker-airflow:latest

USER root 

RUN \ 
  apt-get update \
  && apt-get install -y gnupg apt-transport-https \
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get -y --no-install-recommends install msodbcsql17 \
  && ACCEPT_EULA=Y apt-get -y --no-install-recommends install mssql-tools \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ${AIRFLOW_HOME}/.bash_profile \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ${AIRFLOW_HOME}/.bashrc \
  && apt-get -y --no-install-recommends install unixodbc-dev \
  # some other necessary Python packages
  && pip install sqlalchemy  \
  && pip install pandas \
  && pip install pyodbc 