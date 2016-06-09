ovh-DynDNS
=========

Use this script in a cron to update a given A record in your DNS zone, using OVH API.

Initialize
----------

### First initialization

First in order to retrieve needed dependencies and initialize the informations for OVH API requests, run:
```
    make install
```
You will be prompted to configure the OVH API application and the consumer key to use (see https://github.com/denouche/ovh-api-bash-client for more informations)

### Retrieve dependency

To retrieve dependencies only, run:
```
    make
```

Configuration
-------------

Just add a new crontab to run this script using the right subdomain and domain, for example:
```
    * * * * * /home/denouche/crontabs/ovh-dyndns/ovh-dyndns.sh --domain mydomain.com --subdomain home
```

This crontab will check every minute that the following record targets the right IP address :
```
    home.mydomain.com.    60    IN A   1.2.3.4
```

If the target IP address is incorrect, it will update the value, changing the target IP by the current IP (retrieved on http://ipecho.net/)

Informations
------------

If the A record is not found, it will be created.

