FROM java:8-jre-alpine
RUN apk add --no-cache curl git python3 python3-dev libc-dev gcc nodejs php5 \
&& pip3 install --upgrade pip \
&& pip3 install --upgrade pylint setuptools \
&& apk add --update openssl \
#Installing the shellcheck binary
&& wget "https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz" \
&& tar --xz -xvf shellcheck-stable.linux.x86_64.tar.xz \
&& cp shellcheck-stable/shellcheck /usr/bin/
WORKDIR /root
ARG LATEST
ENV LATEST=sonar-scanner-cli-3.3.0.1492-linux
RUN env \
&& curl --insecure -OL 'https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/'$LATEST.zip \
&& mkdir sonar_scanner \
&& unzip -d sonar_scanner $LATEST.zip \
&& mv sonar_scanner/* sonar_home  \
&& rm -rf sonar_scanner $LATEST.zip \
#   ensure Sonar uses the provided Java for musl instead of a borked glibc one
&& sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /root/sonar_home/bin/sonar-scanner
ENV SONAR_RUNNER_HOME=/root/sonar_home
ENV PATH ${SONAR_RUNNER_HOME}/bin:$PATH

CMD sonar-scanner -Dsonar.projectBaseDir=./src
