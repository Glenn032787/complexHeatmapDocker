# Use the official R base image
FROM rocker/r-ver:4.0.0-ubuntu18.04

# Install required R packages
RUN apt-get update && \
	apt-get install -y build-essential libglpk40 && \
	install2.r --error --skipinstalled \
	circlize RColorBrewer tidyverse && \
	rm -rf /tmp/downloaded_packages

# Install bioconductor packages
RUN install2.r --error --skipinstalled BiocManager && \
	R -e 'BiocManager::install(ask = F)' && \
	R -e 'BiocManager::install(c("ComplexHeatmap", ask = F))'
# Set the working directory (optional)
WORKDIR /workspace

# Set the default command to start an R session (can be overridden in Snakemake)
CMD ["R"]
