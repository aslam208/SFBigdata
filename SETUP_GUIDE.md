# Spark Zeppelin Notebook Setup Guide

## ✅ What's Been Installed

### 1. **Java Runtime (OpenJDK 17)**
   - **Location**: `/opt/homebrew/opt/openjdk@17`
   - **Status**: ✅ Installed and verified
   - **Version**: OpenJDK 17.0.19
   ```bash
   java -version
   ```

### 2. **Apache Spark**
   - **Location**: `/opt/homebrew/opt/apache-spark`
   - **Status**: ✅ Installed
   - **Version**: Check with `spark-shell --version`

### 3. **Apache Zeppelin**
   - **Location**: `/opt/homebrew/opt/zeppelin`
   - **Status**: ✅ Installed
   - **Version**: 0.10.1

### 4. **Data Directory**
   - **Location**: `~/data` (Home directory)
   - **Status**: ✅ Created

---

## 📋 Next Steps Required

### Step 1: Prepare Data Files
The notebook expects CSV/TSV files. You need to place them in `~/data/`:

**Files needed:**
- `fire.csv` - Fire department calls data
- `grades.csv` - Grades data (optional for this notebook)
- `ssn-address.tsv` - SSN/Address mapping (optional for this notebook)

```bash
# Copy your data files to ~/data/
# Example:
cp /path/to/fire.csv ~/data/
cp /path/to/grades.csv ~/data/
cp /path/to/ssn-address.tsv ~/data/
```

### Step 2: Update Notebook File Paths
The current notebook uses paths like `file:///data/fire.csv`. You need to change these to:
```
file:///Users/aslam/data/fire.csv
```

Or update your `~/.zprofile` to include:
```bash
export FILE_PATH=~/data
```

### Step 3: Start Zeppelin
```bash
# Start Zeppelin server
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh start

# Or use alias (add to ~/.zprofile):
alias zeppelin-start="/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh start"
alias zeppelin-stop="/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh stop"
```

### Step 4: Access Zeppelin Web UI
Once started, open in your browser:
```
http://localhost:8080
```

### Step 5: Import Notebook
1. Click **"Notebook"** → **"Import note"**
2. Select this file: `sfdata.zpln`
3. Click **"Import"**
4. Open the notebook and run cells sequentially

---

## 🔧 Environment Variables (Already Configured)

Add these to `~/.zprofile` if not already added:

```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@17
export SPARK_HOME=$(brew --prefix apache-spark)/libexec
export ZEPPELIN_HOME=/opt/homebrew/opt/zeppelin
export PATH=$SPARK_HOME/bin:$ZEPPELIN_HOME/bin:$PATH
```

To apply changes immediately:
```bash
source ~/.zprofile
```

---

## 📝 Notebook Structure

The `sfdata.zpln` file contains PySpark cells that:

1. **Load fire.csv** - Uses Spark RDD to read CSV
2. **Parse data** - Splits CSV lines into structured data
3. **Create DataFrame** - Converts to Spark DataFrame with schema
4. **Type conversion** - Converts string dates to Date/Timestamp types
5. **Display results** - Shows sample data

### Cell Dependencies
⚠️ **Important**: Run cells in order as they depend on previous cells' variables.

---

## 🐛 Troubleshooting

### Issue: "Unable to locate Java Runtime"
```bash
# Fix: Set JAVA_HOME explicitly
export JAVA_HOME=/opt/homebrew/opt/openjdk@17
java -version
```

### Issue: "File not found: /data/fire.csv"
```bash
# Fix: Copy files to correct location
cp /path/to/fire.csv ~/data/

# Update notebook path from:
file:///data/fire.csv
# To:
file:///Users/aslam/data/fire.csv
```

### Issue: Zeppelin won't start
```bash
# Check if port 8080 is in use
lsof -i :8080

# Check Zeppelin logs
tail -f /opt/homebrew/opt/zeppelin/logs/zeppelin-zeppelin-localhost.log
```

### Issue: Spark memory errors
Add to Zeppelin interpreter settings:
```
export SPARK_EXECUTOR_MEMORY=4g
export SPARK_DRIVER_MEMORY=2g
```

---

## 🚀 Quick Start Commands

```bash
# Verify everything is installed
java -version
spark-shell --version

# Start Zeppelin
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh start

# Check if running
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh status

# View Zeppelin
open http://localhost:8080

# Stop Zeppelin
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh stop

# Check Zeppelin logs
tail -100f /opt/homebrew/opt/zeppelin/logs/*.log
```

---

## 📚 Required Dependencies Summary

| Component | Version | Status | Path |
|-----------|---------|--------|------|
| Java (OpenJDK) | 17.0.19 | ✅ | `/opt/homebrew/opt/openjdk@17` |
| Apache Spark | Latest | ✅ | `/opt/homebrew/opt/apache-spark` |
| Apache Zeppelin | 0.10.1 | ✅ | `/opt/homebrew/opt/zeppelin` |
| Python/PySpark | 3.x | ✅ | (via Spark) |
| Data Directory | - | ✅ | `~/data` |

---

## 🎯 What's Left to Do

1. ✅ Install Java (OpenJDK 17)
2. ✅ Install Spark
3. ✅ Install Zeppelin
4. ⏳ **Place data files in `~/data/`** ← YOU ARE HERE
5. ⏳ Update notebook file paths (or use ~/data)
6. ⏳ Start Zeppelin and import notebook
7. ⏳ Run notebook cells

---

## 📖 Resources

- [Apache Zeppelin Documentation](https://zeppelin.apache.org/docs/latest/)
- [PySpark SQL Documentation](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/index.html)
- [Spark CSV Reader](https://spark.apache.org/docs/latest/sql-data-sources-csv.html)

