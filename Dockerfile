FROM jupyter/scipy-notebook

# Use apt to install rsync, ssh, less, tree
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client rsync less tree && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Use conda to install the software stack from the relevant repositories

USER $NB_UID

RUN git clone https://github.com/nthiery/Info111-notebooks && cd Info111-notebooks && conda env update -n base -f environment.yml
#RUN git clone https://github.com/nthiery/Info111-notebooks && cd Info111-notebooks && conda env update -n base -f environment.yml

# Cleanup the copied files for a pristine home directory
RUN rm -rf ${HOME}/Info111-notebooks
