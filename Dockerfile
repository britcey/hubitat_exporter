FROM python:3.7-slim

RUN pip install requests prometheus_client
WORKDIR /usr/src/app

COPY hubitat_exporter /usr/local/bin/
COPY hubitat_exporter.yml /usr/local/etc/

EXPOSE 9500

ENTRYPOINT ["python", "-u", "/usr/local/bin/hubitat_exporter"]