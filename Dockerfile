FROM jupyter/scipy-notebook

# Use apt to install rsync, ssh, less, tree
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client rsync less tree && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Use conda to install the software specified in environment.yml

USER $NB_UID

# Temporarily copy the files from the repo since most of them are used
# by conda install; why ${NB_UID}:${NB_GID} does not work?
COPY --chown=jovyan . ${HOME}

RUN conda env update -n base -f environment.yml

# Cleanup the copied files for a pristine home directory
RUN rm -rf ${HOME}/*
