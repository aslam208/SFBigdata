# Environment Setup Complete! ✅

## What Has Been Installed

```
✅ Java (OpenJDK 17.0.19)           → /opt/homebrew/opt/openjdk@17
✅ Apache Spark (Latest)             → /opt/homebrew/opt/apache-spark  
✅ Apache Zeppelin (0.10.1)          → /opt/homebrew/opt/zeppelin
✅ Data Directory                    → ~/data/
✅ Setup Scripts                     → Ready to use
✅ Documentation                     → README.md & SETUP_GUIDE.md
```

---

## What You Need to Do Now

### 1️⃣ **Get Your Data Files**
   
The notebook needs CSV files. Place them in `~/data/`:

```bash
# Required file:
~/data/fire.csv          # Fire department incidents data

# Optional files (referenced in notebook):
~/data/grades.csv        # Grades data
~/data/ssn-address.tsv   # SSN/Address mapping
```

**Where are your data files?**
- ✅ If they're already in your system → copy to `~/data/`
- ❓ If you need to create sample data → see "Sample Data" section below

### 2️⃣ **Start Zeppelin**

```bash
# From the project directory:
cd /Users/aslam/bigdata/git_repo/SFBigdata

# Run the startup script:
./start-zeppelin.sh
```

The script will:
- Set up environment variables
- Start the Zeppelin daemon
- Wait for it to initialize
- Open http://localhost:8080 in your browser

### 3️⃣ **Import the Notebook**

In the Zeppelin web UI:
1. Click **"+ Notebook"** → **"Import note"**
2. Navigate to and select: `sfdata.zpln`
3. Click **"Import"**
4. Open the notebook
5. Run cells in order (top to bottom)

---

## Quick Reference

```bash
# Start Zeppelin
./start-zeppelin.sh

# Stop Zeppelin  
/opt/homebrew/opt/zeppelin/bin/zeppelin-daemon.sh stop

# Verify everything is set up
./verify-setup.sh

# View Zeppelin logs
tail -f /opt/homebrew/opt/zeppelin/logs/*.log

# Open Zeppelin
open http://localhost:8080
```

---

## File Paths Reference

| What | Where |
|------|-------|
| Java (JAVA_HOME) | `/opt/homebrew/opt/openjdk@17` |
| Spark (SPARK_HOME) | `/opt/homebrew/opt/apache-spark/libexec` |
| Zeppelin (ZEPPELIN_HOME) | `/opt/homebrew/opt/zeppelin` |
| Your Data | `~/data/` |
| Notebook | `/Users/aslam/bigdata/git_repo/SFBigdata/sfdata.zpln` |
| Setup Guide | `/Users/aslam/bigdata/git_repo/SFBigdata/SETUP_GUIDE.md` |

---

## About Your Notebook

The `sfdata.zpln` file contains:
- **18 cells** of PySpark code
- **File I/O** operations (CSV reading)
- **Data transformation** (RDD → DataFrame)
- **Type conversion** (String → Date/Timestamp/Integer)
- **Data display** (sample outputs)

**Important:** Cells are interdependent - run them in order!

---

## Common Issues & Solutions

### "Command not found: ./start-zeppelin.sh"
```bash
# Make sure you're in the right directory
cd /Users/aslam/bigdata/git_repo/SFBigdata

# Make scripts executable (if needed)
chmod +x *.sh

# Then run
./start-zeppelin.sh
```

### "File does not exist: /data/fire.csv"
The notebook looks for data in `/data/` but we use `~/data/` instead.

**Solution:** Update notebook file path
```python
# Change this:
file_loc="file:///data/fire.csv"

# To this:
file_loc="file:///Users/aslam/data/fire.csv"
```

### "Unable to connect to localhost:8080"
- Wait 15-20 seconds for Zeppelin to fully start
- Check if Zeppelin is running: `./verify-setup.sh`
- Check port: `lsof -i :8080`

### Zeppelin won't start?
```bash
# Check Java
java -version

# View logs for errors
tail -50f /opt/homebrew/opt/zeppelin/logs/zeppelin-zeppelin-localhost.log
```

---

## Sample Data

If you need to test with sample data, the notebook will create it from the CSV. 

**Fire incidents data should have columns like:**
```
call_number, unit_id, incident_number, call_type, call_date, 
watch_date, received_dttm, entry_dttm, dispatch_dttm, response_dttm,
on_scene_dttm, transport_dttm, hospital_dttm, call_final_disposition,
available_dttm, address, city, zipcode_of_Incident, battalion, 
station_area, box, original_priority, priority, final_priority, 
als_unit, call_type_group, number_of_alarms, unit_type, 
unit_sequence_in_call_dispatch, fire_prevention_district, 
supervisor_district, neighborhooods_analysis_boundaries, row_id, 
case_location, analysis_neighborhoods
```

---

## Next Steps

1. **Get data files** → Place in `~/data/fire.csv`
2. **Start Zeppelin** → `./start-zeppelin.sh`
3. **Open browser** → http://localhost:8080
4. **Import notebook** → Click "Import note" and select `sfdata.zpln`
5. **Run cells** → Execute from top to bottom
6. **Explore data** → View outputs and results

---

## Documentation Files

- 📖 **README.md** - Quick start guide
- 📋 **SETUP_GUIDE.md** - Detailed setup instructions
- 🔧 **start-zeppelin.sh** - Startup script
- ✅ **verify-setup.sh** - Environment verification

---

## Support

- **Zeppelin Web UI:** http://localhost:8080
- **Zeppelin Docs:** https://zeppelin.apache.org/docs/
- **PySpark Docs:** https://spark.apache.org/docs/latest/api/python/
- **Verify setup:** Run `./verify-setup.sh`

---

**You're all set! Ready to run your Spark notebook!** 🎉

Run `./start-zeppelin.sh` and enjoy! 🚀
