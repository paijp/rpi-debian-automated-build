FROM scratch

ADD armroot.tar.gz /

RUN set -x &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/rm /bin/dash &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/cp /bin/dash-arm /bin/dash &&\
	/usr/local/bin/qemu-user-static-execmyself debootstrap/debootstrap --second-stage &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/rm /bin/dash &&\
	/usr/local/bin/qemu-user-static-execmyself /bin/cp /bin/dash-x86 /bin/dash
