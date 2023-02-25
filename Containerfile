ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/vibrantleaf/base-nvidia:${FEDORA_MAJOR_VERSION}

COPY etc/dconf/db/local.d/ /etc/dconf/db/local.d/

COPY etc/doas.conf /etc/doas.conf

RUN rpm-ostree install distrobox && \
    rpm-ostree override remove toolbox && \
    rpm-ostree cleanup -m && \
    rpm-ostree install ffmpeg gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi steam-devices && \
    mkdir -p /etc/distrobox && \
    echo "container_image_default=\"registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora)\"" >> /etc/distrobox/distrobox.conf && \
    rpm-ostree cleanup -m && \
    ostree container commit && \
    ostree remote add  --if-not-exists kernel-xanmod-copr https://copr.fedorainfracloud.org/coprs/rmnscnce/kernel-xanmod/repo/fedora-${FEDORA_MAJOR_VERSION}/rmnscnce-kernel-xanmod-fedora-${FEDORA_MAJOR_VERSION}.repo && \
    rpm-ostree update && \
    rpm-ostree install kernel-xanmod-lts kernel-xanmod-lts-devel kernel-xanmod-lts-headers && \
    rpm-ostree cleanup -m && \
    ostree container commit
