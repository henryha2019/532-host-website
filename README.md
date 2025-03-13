# FIFA Audience Analysis Dashboard

## Motivation
This dashboard is designed for sports marketing analysts, broadcasters, and decision-makers who need to understand global viewership patterns during the FIFA World Cup. By exploring the relationship between population share and TV audience share, users can identify trends, outliers, and opportunities for targeted marketing and broadcasting strategies.

## App Description
The app is built using Shiny in R and provides interactive tools to explore the FIFA audience dataset. Users can:
- Filter the data by confederation (e.g., UEFA, CONMEBOL, CAF) or select "All" to include all confederations.
- Adjust the population share and TV audience share ranges to focus on specific countries.
- Explore the relationship between population share and TV audience share in an interactive scatter plot.
- View the filtered data in an interactive table and access summary statistics.

📽 **Watch a short demo video of the app in action:**  
[Demo Video](img/demo.mp4)

## Installation Instructions

### 1. Clone the Repository
Open your terminal and run the following commands:
```bash
git clone git@github.ubc.ca:mds-2024-25/DSCI_532_individual-assignment_muha01.git
cd DSCI_532_individual-assignment_muha01
```
### 2. Set Up the Environment

Ensure you have Conda installed. Then, create the environment with:

```bash
conda env create -f environment.yml
conda activate fifa_dashboard
```
Alternatively, if you prefer using R directly, install the required R packages manually:

```R
install.packages(c("shiny", "ggplot2", "dplyr", "plotly", "DT"))
```
### 3. Run the Shiny App
Open R or RStudio, set the working directory to the project root, and run:

```R
shiny::runApp("src/app.R")
```
The app will launch in your default web browser.