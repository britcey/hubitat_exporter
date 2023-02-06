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

Hubitat2Prom is capable of collecting any of the metrics that Hubitat exposes via the MakerAPI.

By default it will collect the list below, however adding a new metric is as simple as checking the output of the MakerAPI and adding the attribute name to your configuration, and then restarting the service.

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
  - contact
```

