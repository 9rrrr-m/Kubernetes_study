FROM ubuntu:22.04
RUN apt update && apt -y install rig boxes && apt clean
ENV INTERVAL=5
ENV OPTION=stone
ADD genid.sh /bin/genid.sh
RUN chmod +x /bin/genid.sh
ENTRYPOINT ["/bin/genid.sh"]
