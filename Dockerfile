FROM bitnami/minideb-extras-base:stretch-r377
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV BITNAMI_PKG_CHMOD="-R g+rwX" \
    HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-9" \
    OS_NAME="linux"

# Install required system packages and dependencies
RUN install_packages libc6 libgcc1 zlib1g
RUN . ./libcomponent.sh && component_unpack "java" "1.8.222-1" --checksum 373c9f3d2943b9ff653fc0e7c69b1d54a75807726691a09190648808500b8253
RUN . ./libcomponent.sh && component_unpack "zookeeper" "3.5.5-6" --checksum d9bf2738bc9d33801cd828ba1d7df2799352fe9083e165278fd83c22ebe540fa

COPY rootfs /
RUN chmod 775 postunpack.sh
RUN chmod 775 entrypoint.sh
RUN chmod 775 run.sh
RUN chmod 775 setup.sh

RUN /postunpack.sh
ENV BITNAMI_APP_NAME="zookeeper" \
    ALLOW_ANONYMOUS_LOGIN="yes" \
    BITNAMI_IMAGE_VERSION="3.5.5-debian-9-r130" \
    NAMI_PREFIX="/.nami" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/zookeeper/bin:$PATH"

EXPOSE 2181 2888 3888 8080

USER 1001
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/run.sh" ]
