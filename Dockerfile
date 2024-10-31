# Use the official R base image
FROM rocker/r-ver:4.0.0-ubuntu18.04

# Install system dependencies needed for some R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install required R packages
RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org')" && \
    R -e "BiocManager::install(c('ComplexHeatmap'))" && \
    R -e "install.packages(c('tidyverse','RColorBrewer','circlize'), repos='https://cloud.r-project.org')"


# Set the working directory (optional)
WORKDIR /workspace

# Set the default command to start an R session (can be overridden in Snakemake)
CMD ["R"]
