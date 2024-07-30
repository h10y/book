# Bookdown folder
> Hosting Shiny Book

Setup (you need to have R and LaTeX/pdflatex installed), see <https://bookdown.org/yihui/bookdown/get-started.html>

```bash
cd bookdown
R -e "install.packages('deps');deps::install(ask=FALSE)"
```

How to build the book:

```bash
# HTML output into the ./docs folder (uses settings in _output.yml)
R -q -e "bookdown::clean_book(TRUE); bookdown::render_book('index.Rmd')"
# open the HTML output
R -q -e "browseURL('docs/index.html')"

# create PDF of the book and all TeX files for CRC Press
Rscript pdf_build_from_tex.R
```

See <https://github.com/ThinkR-open/engineering-shiny-book/blob/master/makefile>

Using Docker:

```bash
docker run -it --rm --platform linux/amd64 \
  -v $PWD/bookdown:/home/root/bookdown \
  -w /home/root ghcr.io/analythium/hosting-shiny-book-dev:v1 \
  /bin/bash /home/root/bookdown/_build.sh
```

## Overview of Parts & Chapters

- **Part I**: Getting Started
  - Background (DEvOps, Shiny hosting cycle)
  - Hosting Concepts
  - The Tools of the Trade (local setup: why?)
- **Part II**: Shiny Apps
  - Developing Shiny Apps
    - ...
  - Containerizing Shiny Apps
    - Docker Concepts
      - ...
      - Alternatives to Docker
    - Working with Existing Images
      - Docker Login
      - Docker Images
      - Pulling Images
      - Running Images
    - Building a New Image
      - The Dockerfile
      - Base and Parent Images
        - Rocker, r-lib, rstudio (posit???)
        - layers & caching vs size
        - image is zip layers + metadata with hashes
      - Architecture (AMD/ARM), buildkit
    - Sharing Images
      - Pushing Images
      - Docker Registries
    - Shiny Apps With Dependencies (use bananas)
      - system libraries
        - RSPM, BSPM, r2u, python?
      - R dependencies
        - explicit dependencies
        - DESCRIPTION file, remotes & pak
        - renv
        - deps
      - Python requirements
        - pip
        - pipreqs
        - poetry
        - Conda?
        - ??? for python
    - Best Practices
      - Minimize dependencies
      - Use caching
      - Order layers
      - Switch user
      - Other considerations
        - Use a linter
        - Use labels
        - Docker Security Scanning https://github.com/analythium/hosting-shiny-book-dev/tree/main/blog-posts/2023-02-04_insiders-digest-53
    - Summary

WE ARE HERE

- **Part III**: Hosting Shiny Apps
  - A Review of Shiny Hosting Options
    - Cost & complexity
    - 2x2 setup options
    - Deployment considerations
  - PaaS
    - Shinyapps (not container based)
    - DOAP
      - Static content
      - Containerized apps
    - Heroku
    - Fly.io (& other firecracker based ones)
    - Fargate-like offerings, Elastic Beanstalk, ...
    - Multiple apps using containerized Shiny Server
  - Virtual Private Servers (https://cloud.google.com/learn/what-is-a-virtual-private-server)
    - Setup
      - DO droplet & ssh login
      - Navigation & commands
      - Reverse proxy / Caddy (mention Apache & Nginx)
      - Custom domain & TLS
      - Firewall
    - Static hosting on file server
    - Reverse proxy setup with Caddy
      - systemd
      - Posit Connect
      - Shiny Server
        - multiple apps / linux users
    - Containerized setups
      - ShinyProxy
        - Setup
      - Docker compose
        - Basic setup
        - File server & dynamic apps example
        - Containerized ShinyProxy
  - Hybrid setups
    - Embedding onto your website (Iframes): Shinyapps does not provide HTTPS for custom domains, but uses HTTPS for their own subdomains --> how to serve; or Heroku you can set up costom domain but not a path redirect; or embed in a blog (WP or Ghost), explain iframe and maybe CSS based spinner
  - Considerations for Production
    - Security
      - security groups
      - secret management
    - Snapshots & backups
    - Reserved IP
    - Configuration
    - Access control
      - In-app auth (explain that the app needs to be running, so prob better to catch unwanted visitors before auth) maybe use this with PaaS
      - Password protected server (basic auth with Caddy per route) use this on VM
      - OIDC OAuth (ShinyProxy)
    - CI/CD: 
      - Docker GitHub actions (steps, auto tagging)
      - cron job polling
      - webhooks
    - Scaling: explain single instance multiple sessions vs each session is an instance (ShinyProxy)
      - Vertical & horizontal scaling
      - Shinyapps & Connect
      - Heroku
      - Load balancing with Docker compose
- **Part IV**: What is next?
  - Reevaluating your hosting needs
    - Licensing considerations
  - Advanced topics
    - Kubernetes
      - Shiny apps vanilla
      - ShinyProxy operator
    - OIDC/SSO
    - IaC: terraform, packer
- Part V: Appendices

Notes on system package management and R base images:

- https://hub.docker.com/_/r-base
- https://github.com/r-lib/rig
- focus on pak instead of remotes? https://pak.r-lib.org/reference/features.html
- https://github.com/r-hub/r-minimal
- https://solutions.posit.co/envs-pkgs/environments/docker/
- https://hub.docker.com/r/rstudio/r-base
- https://github.com/rstudio/r-docker
- https://rocker-project.org/images/
- https://github.com/rocker-org/rocker
- https://eddelbuettel.github.io/r2u/

Python:

- https://jfrog.com/devops-tools/article/how-to-choose-a-docker-base-image-for-python/
- https://pythonspeed.com/articles/base-image-python-docker-images/
- https://hub.docker.com/_/python
- https://snyk.io/blog/best-practices-containerizing-python-docker/

Useful for both:

- https://docs.docker.com/build/building/best-practices/
- https://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile
- https://docs.docker.com/glossary/
- valid image tags https://docs.docker.com/reference/cli/docker/image/tag/
- https://github.com/opencontainers/distribution-spec
- CLI reference: https://docs.docker.com/reference/cli/docker/

Need to talk about 

- the `:latest` tag and catches
- image name vs tag (tagging an image, applies `name:tag`)
- base vs parent image
- `docker manifest inspect --verbose golang:1.17.1` etc
- name vs hash https://hackernoon.com/docker-images-name-vs-tag-vs-digest
- https://medium.com/@mccode/the-misunderstood-docker-tag-latest-af3babfd6375

Posit:

- https://solutions.posit.co/architecting/docker/
- https://solutions.posit.co/envs-pkgs/environments/docker/


This repository is used in shinyapps.io to install those dependencies:
- https://github.com/rstudio/shinyapps-package-dependencies

A curated list of awesome R and Python packages:
- https://github.com/nanxstats/awesome-shiny-extensions

Code formatting: https://github.com/r-lib/styler

https://mickael.canouil.fr/posts/2023-05-07-quarto-docker/

```R
library(styler)
# styler::style_dir("book-files/01-shiny-apps")
styler::style_dir("book-files/01-shiny-apps/bananas")
```

## Links

For links, we can abbreviate them and set up `s3y.ca` as URL shortener. When we get there:

- set up gh pages
- scan draft for links
- include csv with original and shortened url's
- write script to replace the urls (if not already the short domain)
- write script that adds the redirect pages to the shortener repo

## References

Shiny in general

- https://unleash-shiny.rinterface.com/
- https://book.javascript-for-r.com/
- https://mastering-shiny.org/

Deployment (not really hosting)

- https://mastering-shiny.org/
- https://engineering-shiny.org/

Devops, docker, etc.

- https://do4ds.com/
- https://raps-with-r.dev/

## For each chapter

- start with an overview of what the chapter is about and how it is structured at a high level
- end with a Summary section and list a few key references where readers can go to learn more

## Using knitr for floating environments

Reference it in text like:

Now consider Fig. \@ref(fig:part1-hosting-cycle), which shows the cycle.

Use the R code chunk like this:

        ```{r part1-hosting-cycle, eval=TRUE, echo=FALSE, fig.cap="Shiny hosting cycle."}
        include_graphics("images/part-01/hosting-cycle.png")
        ```

Important: do not use _ in ref names because it is special in Latex. See <https://bookdown.org/yihui/bookdown/figures.html>.

When adding code chunks, use tripletick and the language name, otherwise there will be no code chunk background in the PDF.

## Index

<https://bookdown.org/yihui/bookdown/latex-index.html>

This \index{Preface}Preface is indexed.

## Cross references

<https://bookdown.org/yihui/bookdown/cross-references.html>

You can also reference sections using the same syntax `\@ref(label)` where label is the slugified title used as the anchor, where label is the section ID or use `[Section header text]`.

Need to test this in HTML & PDF.

## Calling for help

Use PETER and KALVIN as a placeholder if you want something to be filled in by the other co-author.

FIXME: use it to flag parts that we have to revisit (update a link etc.)

## Line breaks

Use 70 char width in latex code (we can fit 80 chars but then inline code height becomes too small)

## Figure placements

<https://bookdown.org/yihui/rmarkdown-cookbook/figure-placement.html>

It is set to `H` which right where it is mentioned.
We can probably use `fig.pos = "btp"` to override this as needed.

## More notes on container life cycle and orchestration

Container life cycle:

- <https://docs.docker.com/reference/cli/docker/container/ls/#status>
- <https://medium.com/@maheshwar.ramkrushna/understanding-the-docker-container-lifecycle-states-and-transitions-28dd0bcbf753>
- <https://www.baeldung.com/ops/docker-container-states>
- <https://dev.to/docker/docker-architecture-life-cycle-of-docker-containers-and-data-management-1a9c>
- <https://medium.com/@BeNitinAgarwal/lifecycle-of-docker-container-d2da9f85959>
- <http://docker-saigon.github.io/post/Docker-Internals/>

`docker inspect -f '{{.State.Status}}' mycontainer`

Status	Description
created	A container that has never been started.
running	A running container, started by either docker start or docker run.
paused	A paused container. See docker pause.
restarting	A container which is starting due to the designated restart policy for that container.
exited	A container which is no longer running. For example, the process inside the container completed or the container was stopped using the docker stop command.
removing	A container which is in the process of being removed. See docker rm.
dead	A "defunct" container; for example, a container that was only partially removed because resources were kept busy by an external process. dead containers cannot be (re)started, only removed.



Healthcheck:

- https://stackoverflow.com/questions/42737957/how-to-view-docker-compose-healthcheck-logs
- https://testdriven.io/blog/docker-best-practices/#include-a-healthcheck-instruction
- https://docs.docker.com/reference/dockerfile/#healthcheck

```
# Add health check
#HEALTHCHECK --start-period=30s \
#    CMD curl --fail http://localhost:3838 || exit 1
# HEALTHCHECK --interval=5s CMD curl --fail http://localhost:3838 || exit 1
# HEALTHCHECK --interval=5s CMD bash -c ':> /dev/tcp/127.0.0.1/3838' || exit 1
HEALTHCHECK --interval=5s CMD bash -c ':> /dev/tcp/127.0.0.1/3839' || exit 1
```

```
export NAME=test
docker run --rm -p 8080:3838 --name $NAME $TAG
docker inspect --format "{{json .State.Health }}" $NAME | jq
```

`docker container stats` Display a live stream of container(s) resource usage statistics



Mention swarm mode:

- need to disambiguate docker swarm and swarm mode of the docker engine
- this belongs to advanced / what is next besides Kubernetes
- <https://stackoverflow.com/questions/40039031/what-is-the-difference-between-docker-swarm-and-swarm-mode>
