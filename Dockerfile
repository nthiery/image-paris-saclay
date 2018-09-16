FROM jupyter/scipy-notebook

USER jovyan

COPY . ${HOME}

RUN conda env update -f environment.yml
