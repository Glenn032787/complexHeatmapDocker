FROM rocker/r-ver:4.0.0-ubuntu18.04

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN apt-get update && \
    apt-get install -y build-essential libglpk40 libcairo2-dev libxt-dev tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN install2.r --error --skipinstalled \
    circlize RColorBrewer tidyverse reshape2 Cairo && \
    rm -rf /tmp/downloaded_packages

RUN install2.r --error --skipinstalled BiocManager && \
    R -e 'BiocManager::install(ask = FALSE)' && \
    R -e 'BiocManager::install(c("ComplexHeatmap"), ask = FALSE)'

WORKDIR /workspace

ENTRYPOINT ["Rscript"]
