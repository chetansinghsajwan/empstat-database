FROM postgres:17

# copy init scripts
COPY ./scripts/* /docker-entrypoint-initdb.d/

EXPOSE 5432
