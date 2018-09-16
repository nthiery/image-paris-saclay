FROM jupyter/scipy-notebook

RUN conda env update --quiet --yes -f environment.yml
