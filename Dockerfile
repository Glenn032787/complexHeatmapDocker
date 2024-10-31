# Use the official R base image
FROM rocker/r-ver:4.0.0-ubuntu18.04

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

# Install required R packages
RUN apt-get update && \
	apt-get install -y build-essential libglpk40 libcairo2-dev libxt-dev && \
	install2.r --error --skipinstalled \
	circlize RColorBrewer tidyverse reshape2 Cairo && \
	rm -rf /tmp/downloaded_packages

RUN apt install tzdata

# Install bioconductor packages
RUN install2.r --error --skipinstalled BiocManager && \
	R -e 'BiocManager::install(ask = F)' && \
	R -e 'BiocManager::install(c("ComplexHeatmap", ask = F))'
# Set the working directory (optional)
WORKDIR /workspace

# Set the default command to start an R session (can be overridden in Snakemake)
CMD ["R"]
