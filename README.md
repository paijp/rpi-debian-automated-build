# rpi-debian-automated-build
Docker automated build raspberry-pi image sample using qemu-user-static-execmyself.

## important (You have to type `cp /bin/dash-arm /bin/dash` first in Raspberry Pi)
- `/bin/dash`(symbolic-linked from /bin/sh) is a x86-binary because RUN command in Dockerfile uses the fixed path `/bin/sh`.
- But another all binaries (except `/bin/dash-x86` and `/usr/local/bin/qemu-user-static-execmyself`) is a arm-binary.
- Then, the command `docker run -it --rm paijp/rpi-debian-automated-build bash` in ARM architecture will be successed, because `/bin/bash` is a arm-binary.
- But if you type `sh` in above bash, it will cause a error like ``.
- Then you have to type `cp /bin/dash-arm /bin/dash` first.
