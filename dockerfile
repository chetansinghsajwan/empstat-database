FROM postgres:17

# copy init scripts
COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
