FROM httpd:2.4

MAINTAINER LinShare <linshare@linagora.com>

ARG VERSION="2.0.0-SNAPSHOT"
ARG CHANNEL="snapshots"

ENV LINSHARE_VERSION=$VERSION
ENV LINSHARE_THEME=default

RUN apt-get update && apt-get install curl bzip2 -y && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV URL="https://nexus.linagora.com/service/local/artifact/maven/content?r=linshare-${CHANNEL}&g=org.linagora.linshare&a=linshare-ui-editor-onlyoffice&v=${VERSION}"
RUN curl -k -s "${URL}&p=tar.bz2" -o ui-editor-onlyoffice.tar.bz2 && curl -k -s "${URL}&p=tar.bz2.sha1" -o ui-editor-onlyoffice.tar.bz2.sha1 \
  && sed -i 's#^\(.*\)#\1\tui-editor-onlyoffice.tar.bz2#' ui-editor-onlyoffice.tar.bz2.sha1 \
  && sha1sum -c ui-editor-onlyoffice.tar.bz2.sha1 --quiet && rm -f ui-editor-onlyoffice.tar.bz2.sha1

RUN tar -jxf ui-editor-onlyoffice.tar.bz2 -C /usr/local/apache2/htdocs && \
  chown -R www-data /usr/local/apache2/htdocs/linshare-ui-editor-onlyoffice && \
  rm -f ui-editor-onlyoffice.tar.bz2

COPY ./httpd.extra.conf /usr/local/apache2/conf/extra/httpd.extra.conf
RUN cat /usr/local/apache2/conf/extra/httpd.extra.conf >> /usr/local/apache2/conf/httpd.conf

COPY ./linshare-ui-editor-onlyoffice.conf /usr/local/apache2/conf/extra/linshare-ui-editor-onlyoffice.conf

EXPOSE 80
