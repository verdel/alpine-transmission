FROM python:alpine

ENV TRANSMISSION_CONF_DIR /etc/transmission

# Copy init scripts
COPY rootfs /

# Add s6-overlay
ENV S6_OVERLAY_VERSION v2.1.0.2

# Install transmission
RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    apk --update add \
    transmission-daemon@edge \
    tzdata \
    && apk --update add --virtual build-dependencies ca-certificates curl \
    && pip install requests \
    && update-ca-certificates \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz \
    | tar xvfz - -C /  \
    && apk del build-dependencies \
    # Clean up
    && rm -rf \
    /usr/share/man \
    /tmp/* \
    /var/cache/apk/*

# Expose ports
EXPOSE 9091/tcp
EXPOSE 51413/tcp

ENTRYPOINT ["/init"]
CMD []
