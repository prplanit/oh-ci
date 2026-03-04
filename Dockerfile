# ---- Build krabby from source (glibc release won't run on Alpine) ----
FROM docker.io/library/rust:1.87-alpine3.23 AS krabby-builder
RUN apk add --no-cache musl-dev
RUN cargo install krabby --version 0.3.0 --root /out

# ---- Runtime image ----
FROM docker.io/library/alpine:3.23.3

LABEL maintainer="SoFMeRight <sofmeright@gmail.com>" \
      org.opencontainers.image.title="oh-ci" \
      org.opencontainers.image.description="Minimal CI/automation image with core shell tools." \
      org.opencontainers.image.source="https://gitlab.prplanit.com/precisionplanit/oh-ci" \
      org.opencontainers.image.licenses="GPL-3.0"

RUN apk add --no-cache \
      bash \
      coreutils \
      curl \
      gettext \
      git \
      jq \
      rsync \
      tree \
      yq

COPY --from=krabby-builder /out/bin/krabby /usr/local/bin/krabby

CMD ["/bin/sh"]
