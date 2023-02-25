ARG FEDORA_MAJOR_VERSION=37
FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION} AS builder
FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION}

COPY etc/doas.conf /etc/doas.conf
COPY etc/dconf/db/local.d/ /etc/dconf/db/local.d/

RUN flatpak remote-add --if-not-exists flathub-offical https://flathub.org/repo/flathub.flatpakrepo && \
  rpm-ostree install doas \
  virt-manager \
  libvirt \
  swtpm \
  edk2-ovmf \
  podman \
  podman-docker \
  distrobox \
  &&\
  rpm-ostree override remove \
  firefox \
  firefox-langpacks \
  thunderbird \
  toolbox \
  && \
  rpm-ostree cleanup -m \
  & \
  mkdir -p /etc/distrobox ** \
  && \
  echo "container_image_default=\"registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora)\"" >> /etc/distrobox/distrobox.conf \
  &&\
  ostree remote add  --if-not-exists kernel-xanmod-copr https://copr.fedorainfracloud.org/coprs/rmnscnce/kernel-xanmod/repo/fedora-${FEDORA_MAJOR_VERSION}/rmnscnce-kernel-xanmod-fedora-${FEDORA_MAJOR_VERSION}.repo \
  && \
  rpm-ostree cleanup -m \
  && \
  rpm-ostree update \
  && \
  rpm-ostree install &&\
  kernel-xanmod-lts kernel-xanmod-lts-devel kernel-xanmod-lts-headers \
  && \
  rpm-ostree cleanup -m \
  && \
  rpm-ostree update \
  && \
  ostree container commit
