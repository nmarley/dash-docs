# Welcome to Dash-docs.github.io.org's Codebase

Current Build Status: ![Build Status](https://travis-ci.org/dash-docs/dash-docs.svg?branch=master)

Live site: [dash-docs.github.io](https://dash-docs.github.io)

Report problems or help improve the site by opening a [new issue](https://github.com/dash-docs/dash-docs/issues/new) or [pull request](https://github.com/dash-docs/dash-docs/compare).

## How to Participate
The following quick guides will help you get started:

<!--
+ [Becoming a Contributor](https://github.com/dash-docs/dash-docs/blob/master/docs/become-a-contributor.md)
-->
+ [Working with GitHub](https://github.com/dash-docs/dash-docs/blob/master/docs/working-with-github.md)
+ [Setting Up Your Environment](https://github.com/dash-docs/dash-docs/blob/master/docs/setting-up-your-environment.md)
+ [Improving Developer Documentation](https://github.com/dash-docs/dash-docs/blob/master/docs/contributing-to-developer-documentation.md)
+ [Miscellaneous / Other](https://github.com/dash-docs/dash-docs/blob/master/docs/miscellaneous.md)
<!--
+ [Assisting with Translations](https://github.com/dash-docs/dash-docs/blob/master/docs/assisting-with-translations.md)
+ [Managing Wallets](https://github.com/dash-docs/dash-docs/blob/master/docs/managing-wallets.md)
+ [Adding Events, Release Notes and Alerts](https://github.com/dash-docs/dash-docs/blob/master/docs/adding-events-release-notes-and-alerts.md)
+ [Adding Blog Posts](https://github.com/dash-docs/dash-docs/blob/master/docs/adding-blog-posts.md)
-->

## Build via Docker

You can use the provided Dockerfile to build the site:

```sh
docker build -t dash-docs .
```

... then you can copy the static site out:

```sh
docker create --name temp-docs dash-docs
docker cp temp-docs:/build/_site ./the-site
docker rm temp-docs
```

Now the site has been copied to your local machine in `./the-site`.

To quickly serve the static site via nginx Docker image:

```sh
docker run --rm --name nginx -p 127.0.0.1:80:80 -v $PWD/the-site:/usr/share/nginx/html:ro -v $PWD/nginx-default.conf:/etc/nginx/conf.d/default.conf:ro nginx:alpine
```
