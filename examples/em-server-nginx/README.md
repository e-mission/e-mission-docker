# emission production deployment

What will we deploy?

1. mongodb
2. nginx-proxy (automated)
3. nginx-proxy-letsencrypt (automated)
4. emission-server
5. (optional) cloudflare-ddns client

## Prerequisites

1. A domain pointing to your server IP address.
   In this example we will use `emission.mydomain.com`
2. Open port `80` and `443`.
3. `google_auth.json` at project root.
4. `seed_model.json` at project root.
5. `webserver.conf` at project root.

## Configuration

Configuration is done via `.env` file. First you need to create `.env` file.

You can do this by executing:

```bash
touch .env
```

Now let's put our configuration in the file like so:

```bash
EM_DOMAIN=emission.mydomain.com
EM_LETSENCRYPT_EMAIL=your@email.com
```

## Deploying mandatory services

```bash
source .env && docker-compose -f docker-compose.prod.yml up -d
```

## Deploying mandatory services and CloudFlare DDNS Client

To deploy CloudFlare DDNS Client, you need to put additional configuration into `.env` file.

Example configuration:

```bash
EM_CLOUDFLARE_API_KEY=your-cloudflare-api-key
EM_CLOUDFLARE_ROOT_DOMAIN=mydomain.com
EM_CLOUDFLARE_SUBDOMAIN=emission
```

```bash
source .env && docker-compose -f docker-compose.prod.yml -f docker-compose.prod-companion.yml up -d
```
