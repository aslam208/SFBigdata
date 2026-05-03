#!/bin/bash

# Environment Verification Script
# Checks if all required components for running the Spark Zeppelin notebook are installed

echo "═══════════════════════════════════════════════════════════════"
echo "  Spark Zeppelin Notebook - Environment Verification"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

# Check Java
echo "Checking Java Installation..."
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | grep "openjdk" || java -version 2>&1 | grep "version")
    check_result 0 "Java installed: $JAVA_VERSION"
else
    check_result 1 "Java not found"
fi

if [ -z "$JAVA_HOME" ]; then
    echo -e "${YELLOW}⚠${NC}  JAVA_HOME not set. It should point to /opt/homebrew/opt/openjdk@17"
else
    check_result 0 "JAVA_HOME is set: $JAVA_HOME"
fi

# Check Spark
echo ""
echo "Checking Spark Installation..."
if [ -d "/opt/homebrew/opt/spark-3.4.1" ]; then
    SPARK_VERSION=$(cat /opt/homebrew/opt/spark-3.4.1/RELEASE 2>/dev/null || echo "Spark 3.4.1")
    check_result 0 "Spark installed at /opt/homebrew/opt/spark-3.4.1"
else
    check_result 1 "Spark not found at /opt/homebrew/opt/spark-3.4.1"
fi

# Check Zeppelin
echo ""
echo "Checking Zeppelin Installation..."
if [ -d "/opt/homebrew/opt/zeppelin" ]; then
    check_result 0 "Zeppelin installed at /opt/homebrew/opt/zeppelin"
    
    if [ -f "/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh" ]; then
        check_result 0 "Zeppelin daemon script found"
    else
        check_result 1 "Zeppelin daemon script not found"
    fi
else
    check_result 1 "Zeppelin not found at /opt/homebrew/opt/zeppelin"
fi

# Check PySpark
echo ""
echo "Checking PySpark..."
if python3 -c "import pyspark" 2>/dev/null; then
    check_result 0 "PySpark is available"
else
    echo -e "${YELLOW}⚠${NC}  PySpark may not be in Python path (will be loaded by Zeppelin)"
fi

# Check data directory
echo ""
echo "Checking Data Directory..."
if [ -d "$HOME/data" ]; then
    DATA_FILES=$(ls -1 "$HOME/data" 2>/dev/null | wc -l)
    if [ "$DATA_FILES" -gt 0 ]; then
        check_result 0 "Data directory exists with $DATA_FILES files"
    else
        echo -e "${YELLOW}⚠${NC}  Data directory exists but is empty"
    fi
else
    echo -e "${YELLOW}⚠${NC}  Data directory not found at ~/data (create it: mkdir ~/data)"
fi

# Check environment variables
echo ""
echo "Checking Environment Variables..."
if [ -z "$JAVA_HOME" ]; then
    echo -e "${YELLOW}⚠${NC}  JAVA_HOME not set (add to ~/.zprofile)"
else
    check_result 0 "JAVA_HOME is set: $JAVA_HOME"
fi

if [ -z "$SPARK_HOME" ]; then
    echo -e "${YELLOW}⚠${NC}  SPARK_HOME not set (add to ~/.zprofile)"
else
    check_result 0 "SPARK_HOME is set: $SPARK_HOME"
fi

# Check if Zeppelin is running
echo ""
echo "Checking Zeppelin Status..."
if curl -s http://localhost:8080 > /dev/null 2>&1; then
    check_result 0 "Zeppelin is running at http://localhost:8080"
else
    echo -e "${YELLOW}⚠${NC}  Zeppelin is not running (start with: ./start-zeppelin.sh)"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  Setup Summary"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Place data files in: ~/data/"
echo "  2. Start Zeppelin: ./start-zeppelin.sh"
echo "  3. Open http://localhost:8080"
echo "  4. Import sfdata.zpln notebook"
echo ""
echo "For detailed instructions, see: SETUP_GUIDE.md"
echo ""
