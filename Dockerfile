FROM jupyter/scipy-notebook

# Use apt to install rsync, ssh, less, tree
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client rsync less tree && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Use conda to install the software stack from the relevant repositories

USER $NB_UID

RUN git clone https://github.com/nthiery/Info111-notebooks repo && cd repo && conda env update -n base -f environment.yml && cd .. && rm -rf repo
RUN git clone https://gitlab.u-psud.fr/MethNum/scripts.git repo && cd repo && conda env update -n base -f environment.yml && cd .. && rm -rf repo
