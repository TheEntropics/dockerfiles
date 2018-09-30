FROM frolvlad/alpine-glibc
LABEL maintainer="Oanca Ionut Andrei <oanca.ionutandrei@gmail.com"

# Add get-server script
ADD get-server.sh /get-server.sh
RUN /get-server.sh

# Add config files
ADD ./conf/server.cfg /opt/openarena/baseoa/server.cfg
ADD ./conf/maprotation.cfg /opt/openarena/baseoa/maprotation.cfg
ADD ./conf/motd.cfg /opt/openarena/baseoa/motd.cfg

# Add startup script
ADD startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

# Expose ports
EXPOSE 27950/udp
EXPOSE 27960/udp

# Run startup script
CMD /opt/startup.sh
