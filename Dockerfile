FROM jupyter/scipy-notebook

USER jovyan
# RUN conda env update -n base -f environment.yml

COPY . ${HOME}
