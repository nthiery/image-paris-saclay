FROM jupyter/scipy-notebook

RUN conda env update -n base -f environment.yml
