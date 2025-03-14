# Use the official Rocker Shiny image with a specific R version
FROM rocker/shiny:4.1.2

# Install any additional system libraries if required
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev

# Install required R packages
RUN R -e "install.packages(c('shiny', 'dplyr', 'ggplot2', 'tidyverse', 'plotly', 'DT'), repos='http://cran.rstudio.com/')"

# Create the app directory
RUN mkdir -p /srv/shiny-server/fifa-dashboard

# Copy the app code into the image
COPY src/app.R /srv/shiny-server/fifa-dashboard/
COPY data/raw/fifa_countries_audience.csv /srv/shiny-server/fifa-dashboard/data/raw/

# Remove the default Shiny welcome page and sample apps
RUN rm -f /srv/shiny-server/index.html && rm -rf /srv/shiny-server/sample-apps

# Expose the Shiny Server port (default is 3838)
EXPOSE 3838

# Set the working directory to the app directory
WORKDIR /srv/shiny-server/fifa-dashboard

# Run Shiny Server
CMD ["/usr/bin/shiny-server"]
