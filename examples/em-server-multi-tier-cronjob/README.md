This is an example of a multi-tier setup, with the webapp, analysis and
database tiers separated. The analysis tier is autoconfigured with a cronjob.
Having said that, there are multiple config options that need to be set before
this container is run. These are:

- you need to create `conf` directories in both `webapp` and `analysis` with
  the appropriate config files.
- you should look through all the `CHANGEME` locations and fill them out

```
$ grep -r CHANGEME .
```

Some of these are required; others are optional.
