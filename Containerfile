ARG FEDORA_MAJOR_VERSION=37
FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION}


# switch sudo to doas
RUN rpm-ostree install doas
RUN rpm-ostree override remove \
  sudo \
  sudo-python-plugin
COPY etc/doas.conf /etc/doas.conf

# switch toolbox to distrobox
RUN rpm-ostree install distrobox
#RUN rpm-ostree override remove toolbox
RUN rpm-ostree cleanup -m
RUN mkdir -p /etc/distrobox
RUN echo "container_image_default=\"registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora)\"" >> /etc/distrobox/distrobox.conf
COPY etc/dconf/db/local.d/ /etc/dconf/db/local.d/

# install xanmod kernel
RUN ostree remote add  --if-not-exists kernel-xanmod-copr https://copr.fedorainfracloud.org/coprs/rmnscnce/kernel-xanmod/repo/fedora-${FEDORA_MAJOR_VERSION}/rmnscnce-kernel-xanmod-fedora-${FEDORA_MAJOR_VERSION}.repo
RUN rpm-ostree update
RUN rpm-ostree install kernel-xanmod-lts kernel-xanmod-lts-devel kernel-xanmod-lts-headers

# finsh up
RUN rpm-ostree cleanup -m
RUN ostree container commit
