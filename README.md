# Spatial-genetic-heterogeneity
Statistical Mechanical theory for spatio-temporal evolution of Intra-tumor
heterogeneity in cancers: Analysis of Multiregion sequencing data

![Simulation Preview](images/snapshot.png)

## 📌 Overview
This repository contains the **MATLAB**, **C++** code and **data analysis scripts** used in our paper:

> **"Statistical Mechanical theory for spatio-temporal evolution of Intra-tumor
heterogeneity in cancers: Analysis of Multiregion sequencing data"**  
> **Authors:** Sumit Sinha, Xin Li, and D. Thirumalai  
> **Published in:** *arXiv:2202.10595*  

This repository contains the MATLAB/C++ code, data analysis scripts used to develop and validate a statistical mechanical model for intra-tumor heterogeneity (ITH). The model predicts spatial and temporal genetic variations within a single tumor and is validated against multi-region sequencing (M-Seq) data for skin, lung, and kidney cancers..

---

## 📂 Repository Structure
```text
/Glass-to-Fluid-Solid-tumors
│── code/         # MATLAB & Python scripts for simulations
│   ├── matlab/   # MATLAB-specific scripts
│── data_analysis_scripts/         # Processed simulation data
│── results/      # Figures, plots, and animations
│── videos/       # Embedded simulation movies
│── README.md     # Project documentation
│── LICENSE       # Licensing information
```


---

## 🚀 Getting Started
### 1️⃣ Clone the Repository
To download the code, use:
```sh
git clone https://github.com/sumit-sinha-seas/Spatial-genetic-heterogeneity.git
cd Spatial-genetic-heterogeneity
```

### 2️⃣ Running the Simulations
#### **MATLAB**
To run the MATLAB simulation, open MATLAB and execute:
``` matlab
run('code/tumor.m')
```



## 🔬 Key Findings
- The model captures **tumor invasion** by simulating **cell growth, adhesion, and migration**.
- Model shows spatially heterogeneous dynamics of cells in a growing spheroid.
**Cells at the periphery** move faster, **undergoing superdiffusive dynamics**, while **interior cells undergo sub-diffusive dynamics**.
- Shows **one to one comparsion with experiments**.

## 🎥 Simulation Videos
🔹 Click below to watch each simulation:

- [▶️ Watch Video 1](https://drive.google.com/file/d/1cDcTIq8nfolsKBTewVua1kj49Q_gUthZ/view?usp=sharing)
- [▶️ Watch Video 2](https://drive.google.com/file/d/1gEM12Pp7qkOX0vMOkjsdiYf-Xlr2jPQZ/view?usp=sharing)
- [▶️ Watch Video 3](https://drive.google.com/file/d/1VnwTGeGLc0rPAIivUYFVcQqMaR71drEa/view?usp=sharing)



## 📜 Citation
If you use this code in your research, please cite our paper:
```bibtex
@article{sinha2020spatially,
  title={Spatially heterogeneous dynamics of cells in a growing tumor spheroid: Comparison between theory and experiments},
  author={Sinha, Sumit and Malmi-Kakkada, Abdul N and Li, Xin and Samanta, Himadri S and Thirumalai, D},
  journal={Soft matter},
  volume={16},
  number={22},
  pages={5294--5304},
  year={2020},
  publisher={Royal Society of Chemistry}
}
```
