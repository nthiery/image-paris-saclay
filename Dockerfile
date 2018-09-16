FROM jupyter/scipy-notebook

RUN conda env update -f environment.yml
