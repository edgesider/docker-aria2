FROM alpine
ENV PACKAGES "aria2 bash curl sudo"

COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add $PACKAGES && \
    chmod +x /entrypoint.sh

EXPOSE 6800

CMD /entrypoint.sh
