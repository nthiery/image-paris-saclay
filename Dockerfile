FROM jupyter/scipy-notebook

USER root

# Install rsync ssh
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jovyan

COPY . ${HOME}

RUN conda env update -n base -f environment.yml
