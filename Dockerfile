FROM jupyter/scipy-notebook

RUN conda env update --yes -f environment.yml
