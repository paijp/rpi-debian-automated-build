FROM qemu-user-static-execmyself AS build

RUN set -x &&\
	debootstrap --arch=armhf --foreign jessie /armroot/
#	debootstrap --arch=armhf --foreign wheezy /armroot/
#	debootstrap --arch=armhf --keyring=/usr/share/keyrings/raspbian-archive-keyring.gpg --foreign jessie /armroot/ http://archive.raspbian.org/raspbian

#COPY debootstrap_nomount.patch /armroot/debootstrap/

RUN set -x &&\
	cd /armroot/bin &&\
	mv dash dash-arm &&\
	cp dash-x86 dash &&\
	cd /armroot/debootstrap &&\
	patch functions debootstrap_nomount.patch

FROM scratch

COPY --from=build /armroot/* /

RUN set -x &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/rm /bin/dash &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/cp /bin/dash-arm /bin/dash &&\
	/usr/local/bin/qemu-user-static-execmyself debootstrap/debootstrap --second-stage &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/rm /bin/dash &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/cp /bin/dash-x86 /bin/dash

