FROM jupyter/scipy-notebook

# Install sshfs
RUN apt-get update && \
    apt-get install -y --no-install-recommends sshfs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jovyan

COPY . ${HOME}

RUN conda env update -n base -f environment.yml
