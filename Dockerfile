FROM rocker/rstudio

# Set the password for the rstudio user to "workspace"
ARG linux_user_pwd=workspace

# Set the shell to bash
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install system dependencies (non-interactive mode to avoid prompts)
RUN apt update \
    && apt install -y software-properties-common \
    && DEBIAN_FRONTEND=noninteractive apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y sqlite3 lighttpd x11-apps \
    && echo "rstudio:$linux_user_pwd" | chpasswd

# Install required R packages
RUN Rscript --no-restore --no-save -e "install.packages(c('ggplot2', 'gridExtra', 'grid', 'dplyr', 'tidyr', 'kableExtra', 'knitr'))"

# Optional: Install TinyTeX for LaTeX support in R
RUN Rscript --no-restore --no-save -e "install.packages('tinytex')"
RUN Rscript --no-restore --no-save -e "tinytex::install_tinytex()"

# Optional: Install RStudio Server (if needed)
RUN apt install -y gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1106-amd64.deb \
    && gdebi --non-interactive rstudio-server-1.4.1106-amd64.deb \
    && rm rstudio-server-1.4.1106-amd64.deb

# Expose ports
EXPOSE 8787

# Set the default working directory
WORKDIR /home/rstudio

# Command to start the container (e.g., for RStudio server or a shell)
CMD ["/bin/bash"]