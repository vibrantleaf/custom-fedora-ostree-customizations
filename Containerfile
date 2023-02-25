ARG FEDORA_MAJOR_VERSION=37
FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION} AS builder
FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION}

COPY --from=ghcr.io/ublue-os/udev-rules etc/udev/rules.d/* /etc/udev/rules.d/
COPY etc/ /etc/
#COPY usr/ /usr/

#RUN flatpak remote-add flathub-offical https://flathub.org/repo/flathub.flatpakrepo

# nonlocal replace not available yet
# RUN rpm-ostree override replace kernel-xanmod-lts kernel-xanmod-lts-devel kernel-xanmod-lts-headers

RUN rpm-ostree override replace https://download.copr.fedorainfracloud.org/results/rmnscnce/kernel-xanmod/fedora-37-x86_64/05033715-kernel-xanmod-lts/kernel-xanmod-lts-5.15.78-xm1.0.fc37.x86_64.rpm \
  https://download.copr.fedorainfracloud.org/results/rmnscnce/kernel-xanmod/fedora-37-x86_64/05033715-kernel-xanmod-lts/kernel-xanmod-lts-devel-5.15.78-xm1.0.fc37.x86_64.rpm \
  https://download.copr.fedorainfracloud.org/results/rmnscnce/kernel-xanmod/fedora-37-x86_64/05033715-kernel-xanmod-lts/kernel-xanmod-lts-headers-5.15.78-xm1.0.fc37.x86_64.rpm 
  #rpm-ostree install opendoas virt-manager libvirt swtpm edk2-ovmf podman podman-docker distrobox &&\
  #rpm-ostree override remove firefox firefox-langpacks toolbox && \
  #rpm-ostree remove firefox firefox-langpacks toolbox && \
  #rpm ostree uninstall firefox firefox-langpacks toolbox && \
  #rpm-ostree cleanup -m && \
  #rpm-ostree upgrade && \
 # ostree container commit
