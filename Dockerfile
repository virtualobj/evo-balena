#FROM evo-balena-local:latest
# Force arm64 platform for Raspberry Pi devices
FROM --platform=linux/arm64 virtualobj/evo:c0f4cfc

# Install curl for config fetching
RUN apk add --no-cache curl

# Copy startup script and fix line endings
COPY start.sh /app/start.sh
RUN sed -i 's/\r$//' /app/start.sh && chmod +x /app/start.sh

# Set the startup script as entrypoint - run through sh explicitly
ENTRYPOINT ["/bin/sh", "/app/start.sh"] 