# 🚀 Spark Zeppelin Notebook - Quick Start

## ✅ What's Installed

| Component | Status | Command |
|-----------|--------|---------|
| **Java (OpenJDK 17)** | ✅ Ready | `java -version` |
| **Apache Spark** | ✅ Ready | `spark-shell --version` |
| **Apache Zeppelin 0.10.1** | ✅ Ready | `/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh` |
| **Data Directory** | ✅ Ready | `~/data` |

---

## 🎯 Quick Start (3 Steps)

### Step 1: Prepare Your Data
Place your CSV files in the data directory:
```bash
# Your data files should go here:
~/data/fire.csv          # Main fire department data
~/data/grades.csv        # (optional)
~/data/ssn-address.tsv   # (optional)
```

### Step 2: Update Notebook Path (if needed)
The notebook currently references `file:///data/fire.csv`. Since we use `~/data/`:

**Option A: Copy notebook file path to your data location**
```bash
# If files are elsewhere, copy to ~/data/
cp /path/to/your/fire.csv ~/data/
```

**Option B: Edit notebook to use correct path**
- In Zeppelin, change `file:///data/` to `file://$HOME/data/`
- Or directly use: `file:///Users/aslam/data/fire.csv`

### Step 3: Start Zeppelin & Run Notebook
```bash
# From project directory
cd /Users/aslam/bigdata/git_repo/SFBigdata

# Start Zeppelin
./start-zeppelin.sh

# Wait ~10 seconds, then open:
# http://localhost:8080
```

---

## 📝 Notebook Features

The `sfdata.zpln` notebook performs:

1. **Load CSV** → Spark RDD text file
2. **Parse** → Split CSV lines
3. **Structure** → Convert to DataFrame  
4. **Type Cast** → Strings → Date/Timestamp/Integer
5. **Display** → Show sample data

All cells run PySpark code (`%pyspark` magic).

---

## 🔧 Useful Commands

```bash
# Start Zeppelin
./start-zeppelin.sh

# Or manually:
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh start

# Stop Zeppelin
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh stop

# Check status
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh status

# View logs
tail -f /opt/homebrew/opt/zeppelin/logs/*.log

# Open in browser
open http://localhost:8080

# Verify setup
./verify-setup.sh
```

---

## 📋 Import Notebook to Zeppelin

1. **Start Zeppelin** → `./start-zeppelin.sh`
2. **Open browser** → `http://localhost:8080`
3. Click **"+ Notebook"** → **"Import note"**
4. Select file: `sfdata.zpln`
5. Click **"Import"**
6. **Run cells in order** (they depend on each other!)

---

## ⚠️ Important Notes

- **Run cells sequentially** - Each cell uses variables from previous cells
- **Use correct data path** - Ensure CSV files are accessible
- **Port 8080** - Zeppelin uses this port. If in use, check `lsof -i :8080`
- **Memory** - For large datasets, may need to increase Spark memory

---

## 🐛 Troubleshooting

### Zeppelin won't start?
```bash
# Check Java
java -version

# Check if port 8080 is in use
lsof -i :8080

# View detailed logs
tail -50f /opt/homebrew/opt/zeppelin/logs/zeppelin-zeppelin-localhost.log
```

### File not found error?
```bash
# Ensure data files exist
ls -la ~/data/

# Update notebook file path from:
file:///data/fire.csv

# To:
file:///Users/aslam/data/fire.csv
```

### Python/PySpark errors?
- Zeppelin includes PySpark automatically
- Make sure Java and Spark are properly installed
- Check Zeppelin interpreter settings

---

## 📚 Files in This Directory

| File | Purpose |
|------|---------|
| `sfdata.zpln` | Main Zeppelin notebook (PySpark) |
| `SETUP_GUIDE.md` | Detailed setup documentation |
| `start-zeppelin.sh` | Script to start Zeppelin |
| `verify-setup.sh` | Script to verify installation |
| `README.md` | This file |

---

## 🎓 Example: Fixing File Path in Notebook

If you see error: `File does not exist: /data/fire.csv`

**In Zeppelin cell, change:**
```python
# OLD (won't work)
file_loc="file:///data/fire.csv"

# NEW (will work)
file_loc="file:///Users/aslam/data/fire.csv"
```

Or use home directory variable:
```python
import os
home = os.path.expanduser("~")
file_loc = f"file://{home}/data/fire.csv"
```

---

## 📞 Need Help?

1. **Check logs**: `tail -f /opt/homebrew/opt/zeppelin/logs/*.log`
2. **Run verification**: `./verify-setup.sh`
3. **Read detailed guide**: `SETUP_GUIDE.md`
4. **Zeppelin docs**: https://zeppelin.apache.org/docs/
5. **PySpark docs**: https://spark.apache.org/docs/latest/api/python/

---

**Ready? Start here:**
```bash
cd /Users/aslam/bigdata/git_repo/SFBigdata
./start-zeppelin.sh
# Then open: http://localhost:8080
```
