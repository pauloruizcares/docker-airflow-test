# pull base image
FROM puckel/docker-airflow:latest

USER root 

RUN \ 
  apt-get update \
  && apt-get install gnupg \
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get install msodbcsql17 \
  && ACCEPT_EULA=Y apt-get install mssql-tools \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ${AIRFLOW_HOME}/.bash_profile \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ${AIRFLOW_HOME}/.bashrc \
  && source ~/.bashrc \
  && apt-get install unixodbc-dev
  
