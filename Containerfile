ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION}

COPY etc/dconf/db/local.d/ /etc/dconf/db/local.d/

RUN rpm-ostree install distrobox && \
    rpm-ostree override remove toolbox && \
    rpm-ostree cleanup -m && \
    ostree remote add  -if-not-exists kernel-xanmod-copr https://copr.fedorainfracloud.org/coprs/rmnscnce/kernel-xanmod/repo/fedora-${FEDORA_MAJOR_VERSION}/rmnscnce-kernel-xanmod-fedora-${FEDORA_MAJOR_VERSION}.repo && \
    rpm-ostree install kernel-xanmod-lts kernel-xanmod-lts-devel kernel-xanmod-lts-headers && \
    ostree container commit
