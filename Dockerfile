FROM debian:bookworm

# install debian packages
ENV DEBIAN_FRONTEND=noninteractive
RUN set -e -x; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        locales gpg curl ca-certificates supervisor golang-go libcap2-bin

# setup su, locale and env
RUN set -e -x; \
    mkdir /config /runtime /config-template; \
    sed -i '/pam_rootok.so$/aauth sufficient pam_permit.so' /etc/pam.d/su; \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen; locale-gen
ENV LC_ALL=en_US.UTF-8 GOPATH=/go

# Install prometheus
RUN set -e -x; \
    cd /opt/; \
    curl -L https://github.com/prometheus/prometheus/releases/download/v2.48.1/prometheus-2.48.1.linux-amd64.tar.gz | tar -xz; \
    ln -s prometheus-* prometheus

# Install grafana
RUN set -e -x; \
    mkdir -p /etc/apt/keyrings; \
    cd /etc/apt/keyrings; \
    curl -k https://apt.grafana.com/gpg.key | gpg --dearmor > grafana.gpg; \
    echo 'deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main' > /etc/apt/sources.list.d/grafana.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends grafana

# Install smokeping_prober
RUN set -e -x; \
    go install github.com/superq/smokeping_prober@v0.6.1; \
    su -c 'setcap cap_net_raw=+ep ${GOPATH}/bin/smokeping_prober'

COPY config-template /config-template/

COPY entrypoint /
CMD ["/entrypoint"]
