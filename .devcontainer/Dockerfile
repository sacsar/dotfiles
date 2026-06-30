FROM mcr.microsoft.com/openjdk/jdk:21-mariner-cm2

# Annoyingly, we need awk to start a dev container
RUN tdnf install -y awk tar
# Shim microdnf -> tdnf, stripping unsupported flags like --nodocs
RUN printf '#!/bin/sh\nf=\nfor a in "$@"; do [ "$a" != "--nodocs" ] && f="$f $a"; done\nexec /usr/bin/tdnf $f\n' > /usr/bin/microdnf && chmod +x /usr/bin/microdnf