ovhDynDNS
=========

Use this script in a cron to update a given A record in your DNS zone, using OVH API

Initialize
----------

### Retrieve dependency

First in order to retrieve needed dependency, run:
```
    make
```
You will be prompted to configure the OVH API application and the consumer key to use (see https://github.com/Denouche/ovhApiBashClient for more informations)


Configuration
-------------

Just add a new crontab to run this script using the right subdomain and domain, for example:
```
    * * * * * /home/denouche/crontabs/ovhDynDNS/ovhDyndns.sh --domain mydomain.com --subdomain home
```

This crontab will check every minute that the following record targets the right IP address :
```
    home.mydomain.com.    60    IN A   1.2.3.4
```

If the target IP address is incorrect, it will update the value, changing the target IP by the current IP (retrieved on http://ipecho.net/)

