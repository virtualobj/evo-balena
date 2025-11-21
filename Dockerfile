#FROM evo-balena-local:latest
FROM --platform=linux/arm64 virtualobj/evo:b894f08

# Install curl for config fetching
RUN apk add --no-cache curl

# Copy startup script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Set the startup script as entrypoint
ENTRYPOINT ["/usr/local/bin/start.sh"]
