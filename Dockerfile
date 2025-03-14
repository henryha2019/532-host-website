# Use the official Rocker Shiny image with a specific R version
FROM rocker/shiny:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install required R packages
RUN R -e "install.packages(c('shiny', 'dplyr', 'ggplot2', 'tidyverse', 'plotly', 'DT'), repos='http://cran.rstudio.com/')"

# Copy your project files into the container
# This assumes your app.R is in the src/ folder.
COPY src/ /srv/shiny-server/
COPY data/raw/ /data/raw/
COPY LICENSE.md /LICENSE.md
COPY README.md /README.md
COPY img/demo.mp4 /img/demo.mp4

# Expose the port that Render will use (it sets the PORT env variable automatically)
EXPOSE 3838

# Run the Shiny app.
# This command ensures that the app listens on 0.0.0.0 and uses the port provided by the PORT environment variable.
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app.R', host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')))" ]
