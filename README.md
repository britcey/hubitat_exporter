# hubitat_exporter

[Prometheus](https://prometheus.io) exporter to expose metrics from the
[Hubitat Maker API](https://docs.hubitat.com/index.php?title=Maker_API)

# Getting up and running

First, retrieve your API token and API path from your Hubitat device. These will look something like;

- URL: `http://<hubitat_hostname>/apps/api/26/devices`
- Token: `f4a20ab3-..-670f559be5a6`

Put these values into `hubitat_exporter.yml`

```
hubitat_url: http://<hubitat_hostname>/apps/api/26/devices
hubitat_token: f4a20ab3-..-670f559be5a6
```

Then just start it:

`./hubitat_exporter hubitat_exporter.yml`

You can test it is working by visiting
[http://localhost:5000/metrics](http://localhost:5000/metrics) in a browser.

### Docker

You can also run via Docker:

```
docker run --rm -p 5000:5000 -v `pwd`/hubitat_exporter.yml:/usr/local/etc/hubitat_exporter.yml britcey/hubitat_exporter
```

## Prometheus

Configuring Prometheus to scrape the metrics is easy.

Add the following to the bottom of your Prometheus Outputs:

```
  - job_name: 'hubitat'
    scrape_interval: 30s
    static_configs:
    - targets: ['my.ip.address.or.hostname']
```

Prometheus will now scrape your web service every 30 seconds to update the metrics in the data store.

# Collected Metrics

hubitat_exporter is capable of collecting any of the metrics that Hubitat exposes via the MakerAPI.

By default it will collect the list below, however adding a new metrics is straight-forward.

The default collections are:

```
  - battery
  - humidity
  - illuminance
  - level # This is used for both Volume AND Lighting Dimmers!
  - switch # We convert from "on/off" to "1/0" so it can be graphed
  - temperature
  - acceleration
  - motion
  - contact # 1 is closed, 0 is open, like a circuit
```

# Acknowledgements

This was forked from
[hubitat2prom](https://github.com/BudgetSmartHome/hubitat2prom) and re-written
quite a bit, to move it from using Flask to just using Python's built-in
webserver, as well as using the prometheus_client module, to ensure valid
metrics.

This follows the standard 'proxy exporter' pattern used by blackbox_exporter,
and the like - in Prometheus tradition, a config file contains any
authentication info.

TODO: update to support multiple Hubitat hubs - with the target provided by the
Prometheus job, with creds specified in the config file as various modules.
