#!/bin/bash

# Zeppelin Startup Script for macOS
# This script starts Apache Zeppelin and opens it in the default browser

set -e

echo "🚀 Starting Apache Zeppelin..."

# Set environment variables
export JAVA_HOME=/opt/homebrew/opt/openjdk@17
export SPARK_HOME=/opt/homebrew/opt/spark-3.4.1
export ZEPPELIN_HOME=/opt/homebrew/opt/zeppelin
export PATH="$JAVA_HOME/bin:$SPARK_HOME/bin:$PATH"

# Verify Java
echo "✓ Checking Java..."
if ! java -version 2>&1 | grep -q "openjdk"; then
    echo "❌ Java not found. Exiting."
    exit 1
fi

# Start Zeppelin
echo "✓ Starting Zeppelin daemon..."
$ZEPPELIN_HOME/bin/zeppelin-daemon.sh start

# Wait for Zeppelin to start
echo "⏳ Waiting for Zeppelin to start (10 seconds)..."
sleep 10

# Check if running
if $ZEPPELIN_HOME/bin/zeppelin-daemon.sh status > /dev/null 2>&1; then
    echo "✅ Zeppelin is running!"
    echo ""
    echo "📊 Open this URL in your browser:"
    echo "   http://localhost:8080"
    echo ""
    echo "📝 To stop Zeppelin, run:"
    echo "   $ZEPPELIN_HOME/bin/zeppelin-daemon.sh stop"
    echo ""
    
    # Try to open in browser
    if command -v open &> /dev/null; then
        echo "🌐 Opening browser..."
        open http://localhost:8080
    fi
else
    echo "❌ Failed to start Zeppelin. Check logs:"
    echo "   tail -f $ZEPPELIN_HOME/logs/*.log"
    exit 1
fi
