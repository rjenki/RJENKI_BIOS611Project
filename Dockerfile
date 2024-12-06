FROM rocker/rstudio

# Set the password for the rstudio user to "workspace"
ARG linux_user_pwd=workspace

# Set the shell to bash
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and set password for rstudio user
RUN apt update && apt install -y \
    software-properties-common \
    sqlite3 \
    lighttpd \
    x11-apps \
    gdebi-core \
    wget \
    && echo "rstudio:$linux_user_pwd" | chpasswd

# Install required R packages
RUN Rscript --no-restore --no-save -e "install.packages(c('ggplot2', 'gridExtra', 'grid', 'dplyr', 'tidyr', 'kableExtra', 'knitr'))"

# Install TinyTeX for LaTeX support in R
RUN Rscript --no-restore --no-save -e "install.packages('tinytex')" \
    && Rscript --no-restore --no-save -e "tinytex::install_tinytex()"

# Clean up package lists and unnecessary files to reduce image size
RUN apt clean && rm -rf /var/lib/apt/lists/*

# Expose ports
EXPOSE 8787

# Set the default working directory
WORKDIR /home/rstudio

# Command to start the container (e.g., for RStudio server or a shell)
CMD ["/bin/bash"]