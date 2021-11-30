FROM google/cloud-sdk:365.0.1-slim

COPY pipe /
COPY LICENSE.txt pipe.yml README.md /

ENTRYPOINT ["/pipe.sh"]
