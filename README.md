# Fork of dash-docs.github.io

Plan is to eventually migrate to Hugo and build via Docker. Builds full site,
every time. Keep it simple. Only one language supported (for now, and if we
need then we'll address it later but this current build system inherited from
Bitcoin is complete shit).

## TODO

Clean up / migrate DashDocs to new build system (Hugo)

- [ ] remove en/ dir (only have English)
- [ ] Doxygen
- [ ] move to Hugo

## Build via Docker

You can use the provided Dockerfile to build the site:

```sh
docker build -t dash-docs .
```

... then you can copy the static site out:

```sh
docker create --name temp-docs dash-docs
docker cp temp-docs:/site ./the-site
docker rm temp-docs
```

Now the site has been copied to your local machine in `./the-site`.

To quickly serve the static site via nginx Docker image:

```sh
docker run --rm --name nginx -p 127.0.0.1:80:80 -v $PWD/the-site:/usr/share/nginx/html:ro -v $PWD/nginx-default.conf:/etc/nginx/conf.d/default.conf:ro nginx:alpine
```
