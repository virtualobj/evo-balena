#!/bin/sh
set -e

echo "Starting eVo Edge Platform..."

# Check if config file already exists
if [ -f "$EVO_DIR/config.toml" ]; then
    echo "Configuration file already exists at $EVO_DIR/config.toml"
else
    # Check if CONFIG_URL is set
    if [ -n "$CONFIG_URL" ] && [ "$CONFIG_URL" != "%%configUrl%%" ]; then
        echo "Fetching configuration from: $CONFIG_URL"
        
        # Create config directory if it doesn't exist
        mkdir -p "$EVO_DIR"
        
        # Fetch configuration file
        if curl -f -o "$EVO_DIR/config.toml" "$CONFIG_URL"; then
            echo "Configuration downloaded successfully to $EVO_DIR/config.toml"
        else
            echo "ERROR: Failed to download configuration from $CONFIG_URL"
            echo "Starting with default configuration..."
        fi
    else
        echo "CONFIG_URL not set or using default value"
        echo "No existing config found - please set CONFIG_URL environment variable in Balena Cloud dashboard"
    fi
fi

# Call the original entrypoint
echo "Calling original entrypoint..."
exec /entrypoint.sh
