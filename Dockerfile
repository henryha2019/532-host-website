# Use the official Rocker Shiny image with a specific R version
FROM rocker/shiny:4.1.2

# Install any additional system libraries if required
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev

# Install required R packages (if not already in the image)
RUN R -e "install.packages(c('shiny', 'dplyr', 'ggplot2', 'tidyverse', 'plotly', 'DT'), repos='http://cran.rstudio.com/')"

# Copy the app code into the image
COPY src/app.R /srv/shiny-server/index.R
COPY data/raw/fifa_countries_audience.csv /srv/shiny-server/data/raw/

# Remove the default Shiny example apps
RUN rm -rf /srv/shiny-server/sample-apps

# Expose the Shiny Server port (default is 3838)
EXPOSE 3838

# Run Shiny Server
CMD ["/usr/bin/shiny-server"]