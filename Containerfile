ARG FEDORA_MAJOR_VERSION=37
FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION} AS builder
FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION}

COPY etc/ /etc/

RUN flatpak remote-add --if-not-exists flathub-offical https://flathub.org/repo/flathub.flatpakrepo && \
  rpm-ostree install doas virt-manager libvirt swtpm edk2-ovmf podman podman-docker distrobox &&\
  rpm-ostree override remove firefox firefox-langpacks toolbox && \
  rpm-ostree cleanup -m && \
  rpm-ostree upgrade --refresh && \
  rpm-ostree install &&\
  kernel-xanmod-lts kernel-xanmod-lts-devel kernel-xanmod-lts-headers && \
  rpm-ostree cleanup -m && \
  rpm-ostree upgrade && \
  ostree container commit
