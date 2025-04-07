ARG version="3.6-alpine"
FROM python
LABEL maintainer="DevZenzya34"


WORKDIR /opt

RUN apt-get update \
    && apt-get install --no-install-recommends -y git \
    && pip3 install flask

COPY . /opt/

#RUN rm -r Readme.md *.pdf

ENV ODOO_URL="https://www.odoo.com"
ENV PGADMIN_URL="https://www.pgadmin.org"

EXPOSE 8080

ENTRYPOINT [ "python", "app.py" ]
