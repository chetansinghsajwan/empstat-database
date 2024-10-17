FROM postgres:17

# copy init scripts
COPY scripts/* /docker-entrypoint-initdb.d/

# default env config
ENV POSTGRES_USER=root \
    POSTGRES_PASSWORD=postpass \
    POSTGRES_DB=empstat

EXPOSE 5432
