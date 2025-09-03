# 🛍️ Olist E-Commerce Analysis & Customer Segmentation  

![Python](https://img.shields.io/badge/Python-Data%20Analysis-blue?style=for-the-badge&logo=python)  
![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?style=for-the-badge&logo=powerbi)  
![MachineLearning](https://img.shields.io/badge/ML-KNN-green?style=for-the-badge)  
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)  

---

## 📌 Project Overview  
The **Olist dataset** is a large Brazilian e-commerce dataset with order, product, and customer information.  
This project covers a **full analysis pipeline**:  

- 📥 Fetched dataset from Google Drive using **gdown** (too large for GitHub)  
- 📊 Performed **order-level analysis** to understand sales patterns  
- 📑 Compiled insights into a **Sales Analysis Report (PDF)**  
- 📈 Created an **interactive 5-page Power BI dashboard**  
- 👥 Generated **customer-level data** and applied **KNN clustering** for segmentation  
- 🔍 Drew actionable conclusions from the segmentation analysis  

---

## 🔍 Key Insights  

- **Order-Level Analysis**  
  - Distribution of payments, freight values, delivery delays, and cancellations  
  - Trends across product categories and states  
  - Revenue drivers identified  

- **Power BI Dashboard**  
  - Interactive 5-page report covering **orders, payments, cancellations, reviews, and delivery KPIs**  
  - Drill-through, slicers, and visual storytelling for business users  

- **Customer Segmentation**  
  - Built customer-level dataset (RFM-style features)  
  - Applied **KNN clustering** to segment customers into distinct groups  
  - Segmentation revealed groups with high-value, discount-sensitive, and infrequent buyers  

---

## 📂 Repository Structure  

    📦 Olist-Ecommerce-Analysis
     ┣ 📜 Sales Analysis Report.pdf        # PDF report summarizing order-level analysis
     ┣ 📜 customer_data.csv                # Processed customer-level dataset
     ┣ 📜 customer_level_data_creation.ipynb  # Notebook for customer-level dataset creation
     ┣ 📜 customer_segmentation.ipynb      # KNN-based segmentation and analysis
     ┣ 📜 olist_orders_dashboard.pbix      # Power BI 5-page dashboard
     ┣ 📜 olist_powerbi_order.csv          # Exported dataset for Power BI
     ┣ 📜 order level data.csv             # Cleaned order-level dataset
     ┣ 📜 sales_data_analysis.ipynb        # EDA & order-level analysis
     ┣ 📜 sales_data_preparation.ipynb     # Data preprocessing pipeline

---

## 🛠️ Tools & Technologies  
- **Python**: Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn (KNN)  
- **Power BI**: Interactive dashboarding and reporting  
- **gdown**: Dataset import from Google Drive  

---

