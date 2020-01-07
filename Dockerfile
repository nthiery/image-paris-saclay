FROM jupyter/scipy-notebook

# Use apt to install rsync, ssh, less, tree
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client rsync unison less tree curl gdb imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo 'export PS1=`echo $JUPYTERHUB_USER| sed s/-at-u-psud.fr//`"@jupyterhub \w \$ "' > /root/.bash_profile

# Use conda to install the software stack from the relevant repositories

USER $NB_UID

RUN conda update  -n base -c conda-forge conda
RUN conda install -n base -c conda-forge mamba

RUN for REPO in                                                \
        https://gitlab.u-psud.fr/Info111/outbound.git          \
        https://gitlab.u-psud.fr/Info122/Info122.git           \
        https://github.com/madclam/info113/                    \
        https://gitlab.u-psud.fr/MethNum/scripts.git           \
        https://github.com/nthiery/M1-ISD-AlgorithmiqueAvancee \
        https://gitlab.u-psud.fr/nicolas.thiery/ter-jupyter    \
        ; do                                                   \
        echo =================================================;\
        echo Installing software stack for:                   ;\
        echo   $REPO                                          ;\
        echo =================================================;\
        git clone $REPO repo                        &&         \
        (cd repo; test -d binder && cd binder; mamba env update -n base -f environment.yml) &&         \
        rm -rf repo                                 ||         \
        break 0;                                               \
    done

# R: potential users at STAPS
# FactoMineR package: used by Albane Saintenoy and students for PCA / clustering
# in the course "Traitement de données hydrologiques" of M2 HSS
RUN mamba install -c conda-forge r r-essentials r-factominer
