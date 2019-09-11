FROM jupyter/scipy-notebook

# Use apt to install rsync, ssh, less, tree
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client rsync unison less tree curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Use conda to install the software stack from the relevant repositories

USER $NB_UID

RUN for REPO in                                                \
        https://github.com/nthiery/Info111-notebooks           \
        https://gitlab.u-psud.fr/Info122/Info122.git           \
        https://github.com/madclam/info113/                    \
        https://gitlab.u-psud.fr/MethNum/scripts.git           \
        https://github.com/nthiery/M1-ISD-AlgorithmiqueAvancee \
        ; do                                                   \
        echo =================================================;\
        echo Installing software stack for:                   ;\
        echo   $REPO                                          ;\
        echo =================================================;\
        git clone $REPO repo                        &&         \
        cd repo                                     &&         \
        conda env update -n base -f environment.yml &&         \
        cd ..                                       &&         \
        rm -rf repo                                 ||         \
        break 0;                                               \
    done
