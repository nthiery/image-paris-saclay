FROM jupyter/scipy-notebook

USER jovyan

COPY . ${HOME}

RUN conda env update -n base -f environment.yml
