FROM python:3.9.16-slim

RUN pip install requests prometheus_client pyyaml
WORKDIR /usr/src/app

COPY hubitat_exporter /usr/local/bin/
COPY hubitat_exporter.yml /usr/local/etc/

EXPOSE 5000

ENTRYPOINT ["python", "-u", "/usr/local/bin/hubitat_exporter", "/usr/local/etc/hubitat_exporter.yml"]