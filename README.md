
<div align="center">

# 🎓 Face Recognition Attendance System

### An intelligent, automated attendance management system built with MATLAB
### using PCA-based face recognition and a full-featured reporting dashboard

![MATLAB](https://img.shields.io/badge/MATLAB-R2025b-orange?style=for-the-badge&logo=mathworks&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Windows-informational?style=for-the-badge&logo=windows)

</div>

---

## 📌 Overview

The **Face Recognition Attendance System** is a MATLAB-based automated solution that uses **Principal Component Analysis (PCA) / Eigenface** technique to recognize students via webcam and automatically mark their attendance. It features a complete CLI dashboard with reports, graphs, and alerts.

> ✅ No manual entry. No proxies. Just face it — literally.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🎥 **Live Face Detection** | Captures face via webcam using Viola-Jones detector |
| 🧠 **PCA Recognition** | Recognizes identity using eigenface distance matching |
| 🖼️ **Face Preprocessing** | Converts to grayscale, resizes & normalizes for accuracy |
| 📋 **Mark Attendance** | Auto-marks with duplicate prevention (one entry/day) |
| 📊 **Monthly Report** | Attendance % per student for selected month |
| 📈 **Overall Attendance** | Cumulative days present per student |
| 🏆 **Topper Feature** | Highlights student with highest attendance |
| ⚠️ **Warning List** | Flags students below 75% attendance threshold |
| 📅 **Today Summary** | Real-time present/absent breakdown |
| ❌ **Absent List** | Lists all students absent on current day |
| 📉 **Graph View** | Bar chart of attendance summary across students |
| 🖥️ **Dashboard** | Full tabular view: name, days present, percentage |

---

## 🖼️ Output Screenshots

### 1. 📷 Face Captured with Detection Box
> Webcam image with a green bounding box drawn around the detected face.

![Captured Image](C:\Users\pc\Pictures\Screenshots\Screenshot(179))

---

### 2. ✅ Recognition Result
> The system identifies the student and displays their name in a yellow label over the detected region.

![Recognition Result](screenshots/recognition_result.png)

---

### 3. 🔬 Original vs Preprocessed Face
> Left: cropped original face. Right: grayscale + resized preprocessed version used for PCA matching.

![Preprocessing](screenshots/preprocessed_face.png)

---

### 4. 🖥️ MATLAB Command Window — Attendance Marked
> Recognition output: MinDist, Gap, Threshold, recognized name, and duplicate-prevention warning.

```
MinDist: 16.1239
Gap: 1.6065
Threshold: 17.2957
Recognized: Cherishma
⚠ cherishma already marked today
```

---

### 5. 📊 Attendance Dashboard (Tabular View)

```
ATTENDANCE DASHBOARD
Name          DaysPresent    Percentage
"cherishma"       3            10
"bhavani"         1            3.3333
"manaswini"       0            0
"satwika"         0            0
"sheijadi"        1            3.3333
```

---

### 6. 📈 Attendance Summary Graph
> Bar chart showing days present per student — generated from the Graph menu option.

![Attendance Graph](screenshots/attendance_graph.png)

---

### 7. ❌ Absent Students Today

```
ABSENT STUDENTS TODAY
AbsentStudents
──────────────
"bhavani"
"manaswini"
"satwika"
"sheijadi"
```

---

### 8. 🏆 Topper

```
🏆 Topper: cherishma (4 days)
```

---

### 9. ⚠️ Warning List — Students Below 75%

```
⚠ STUDENTS BELOW 75%
Name          DaysPresent    Percentage
"cherishma"       3            10
"bhavani"         1            3.3333
"manaswini"       0            0
"satwika"         0            0
"sheijadi"        1            3.3333
```

---

### 10. 📅 Today Summary

```
TODAY SUMMARY
──────────────────────
Total Students : 5
Present        : 1
Absent         : 4

✅ PRESENT STUDENTS
"cherishma"

❌ ABSENT STUDENTS
"bhavani"  "manaswini"  "satwika"  "sheijadi"
```

---

## 📁 Project Structure

```
AttendanceSystem/
│
├── main.m                  # Entry point — launches menu
├── menu.m                  # CLI menu handler
├── preprocessFace.m        # Face preprocessing pipeline
├── trainModel.m            # PCA model training
├── recognizeFace.m         # Face recognition engine
├── markAttendance.m        # Attendance logging
├── monthlyAttendance.m     # Monthly report generator
├── overallAttendance.m     # Overall stats generator
├── dashboard.m             # Tabular dashboard
├── attendanceGraph.m       # Bar chart visualization
├── absentList.m            # Today's absent list
├── topper.m                # Top attendance student
├── todaySummary.m          # Present/absent summary
├── trainedModel.mat        # Saved PCA model
├── absentList.m            # Absent tracker
│
├── dataset/                # Training face images
│   └── <StudentName>/      # One folder per student
│       └── *.jpg
│
└── CapturedImages/         # Webcam snapshots
    └── <Name>_<timestamp>.jpg
```

---

## ⚙️ Setup & Installation

### Prerequisites

- MATLAB R2021a or later (tested on **R2025b**)
- **Image Processing Toolbox**
- **Computer Vision Toolbox**
- Webcam connected and accessible

### Steps

```matlab
% Step 1: Clone or download the repository
% Step 2: Open MATLAB and navigate to the project folder

cd 'C:\Users\<YourName>\Documents\MATLAB\AttendanceSystem'

% Step 3: Add student images to dataset/ folder
% (One subfolder per student, named after the student)

% Step 4: Train the PCA model
trainModel

% Step 5: Run the main system
main
```

---

## 🧠 How It Works

```
Webcam Capture
      ↓
Face Detection (Viola-Jones)
      ↓
Crop & Preprocess (grayscale → resize → normalize)
      ↓
PCA Projection (project onto eigenface space)
      ↓
Distance Matching (find nearest training sample)
      ↓
Threshold Check (MinDist < Threshold?)
      ↓
Mark Attendance (with duplicate check)
      ↓
Update CSV Records
```

---

## 📋 Menu Options

```
-------- FACE ATTENDANCE SYSTEM --------
 1. Mark Attendance
 2. Monthly Report
 3. Overall Attendance
 4. Dashboard
 5. Graph
 6. Absent List
 7. Topper
 8. Warning List
 9. Today Summary
10. Exit
-----------------------------------------
```

---

## 🗂️ Attendance Data Format

Attendance is stored in timestamped CSV files per student:

```
Cherishma_20260410_17512.csv
Cherishma_20260410_18002.csv
Cherishma_20260411_05102.csv
```

Each file logs: **Student Name | Date | Time | Status**

---

## 📌 Key Parameters (in `recognizeFace.m`)

| Parameter | Default | Description |
|---|---|---|
| `threshold` | ~17.3 | Max PCA distance for valid recognition |
| `imageSize` | 100×100 | Face resize dimensions |
| `numComponents` | auto | PCA components from training set |

---

## 👥 Students in Demo

| Student | Days Present | Attendance % |
|---|---|---|
| Cherishma | 3 | 10% |
| Bhavani | 1 | 3.33% |
| Manaswini | 0 | 0% |
| Satwika | 0 | 0% |
| Sheijadi | 1 | 3.33% |

> ⚠️ All students are below the 75% threshold in this demo (early-stage data).

---

## 🛠️ Technologies Used

- **MATLAB R2025b** — Core development environment
- **PCA (Eigenfaces)** — Face recognition algorithm
- **Viola-Jones Algorithm** — Real-time face detection
- **Image Processing Toolbox** — Face preprocessing
- **Computer Vision Toolbox** — Webcam & detection support
- **CSV File I/O** — Attendance data persistence

---

## 🚀 Future Improvements

- [ ] GUI using MATLAB App Designer
- [ ] Export reports to PDF/Excel
- [ ] Multi-face detection in one frame
- [ ] Email alerts for low-attendance students
- [ ] Deep learning (CNN) based recognition for higher accuracy
- [ ] Web dashboard integration

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 🙋‍♀️ Author

> Developed as part of a final year / mini project on intelligent attendance systems using computer vision in MATLAB.

---

<div align="center">

⭐ **If you found this project useful, please give it a star!** ⭐

</div>
