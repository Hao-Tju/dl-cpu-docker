FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh

ENV PATH /opt/conda/envs/pytorch-py37/bin:/opt/conda/bin:$PATH
#RUN conda install --name pytorch-py37 -c soumith magma-cuda80 && /opt/conda/bin/conda clean -ya
RUN conda install pytorch torchvision torchaudio cpuonly -c pytorch
RUN conda install jupyterlab matplotlib -c conda-forge
RUN conda install -c simpleitk simpleitk
RUN conda clean -ya

WORKDIR /workspace
RUN chmod -R a+w /workspace
RUN jupyter notebook --generate-config && echo "c.NotebookApp.ip='127.0.0.1'" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser=True" >> /root/.jupyter/jupyter_notebook_config.py
