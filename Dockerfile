FROM rocker/rstudio

RUN apt update && apt install -y sass && rm -rf /var/lib/apt/lists/*
