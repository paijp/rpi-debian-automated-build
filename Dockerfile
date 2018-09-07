FROM paijp/qemu-user-static-execmyself

RUN set -x &&\
	debootstrap --arch=armhf --foreign jessie /armroot/
#	debootstrap --arch=armhf --foreign wheezy /armroot/
#	debootstrap --arch=armhf --keyring=/usr/share/keyrings/raspbian-archive-keyring.gpg --foreign jessie /armroot/ http://archive.raspbian.org/raspbian

#COPY debootstrap_nomount.patch /armroot/debootstrap/

RUN set -x &&\
	cd /armroot/debootstrap &&\
	patch functions debootstrap_nomount.patch

FROM scratch

COPY --from=0 /armroot /
SHELL ["/bin/dash-x86", "-c"]

RUN set -x &&\
	/usr/local/bin/qemu-user-static-execmyself debootstrap/debootstrap --second-stage

RUN set -x &&\
	/usr/local/bin/qemu-user-static-execmyself /usr/bin/apt-get update
