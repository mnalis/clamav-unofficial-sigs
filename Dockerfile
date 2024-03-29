FROM clamav/clamav:stable
RUN apk upgrade --no-cache
RUN apk add --no-cache bash curl gpg socat rsync bind-tools ncurses logrotate
RUN mkdir -p /etc/clamav-unofficial-sigs/ /var/lib/clamav-unofficial-sigs/pid/ && chown -R clamav /etc/clamav-unofficial-sigs /var/lib/clamav-unofficial-sigs
ADD config/master.conf /etc/clamav-unofficial-sigs/master.conf
ADD config/os/os.alpine.conf /etc/clamav-unofficial-sigs/os.conf
ADD config/user.conf /etc/clamav-unofficial-sigs/user.conf
ADD clamav-unofficial-sigs.sh /etc/clamav-unofficial-sigs/
RUN ["/etc/clamav-unofficial-sigs/clamav-unofficial-sigs.sh", "--install-cron", "--install-logrotate"]
ENTRYPOINT ["/init"]