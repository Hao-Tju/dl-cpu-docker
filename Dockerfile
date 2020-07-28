FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh -O  https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install conda-build && \
     /opt/conda/bin/conda create -y --name pytorch-py37 python=3.7 numpy pyyaml scipy ipython mkl&& \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/envs/pytorch-py37/bin:/opt/conda/bin:$PATH
#RUN conda install --name pytorch-py37 -c soumith magma-cuda80 && /opt/conda/bin/conda clean -ya
RUN conda install --name pytorch-py37 pytorch torchvision cpuonly -c pytorch
RUN conda install jupyterlab matplotlib -c conda-forge
RUN conda clean -ya

WORKDIR /workspace
RUN chmod -R a+w /workspace
RUN jupyter notebook --generate-config && echo "c.NotebookApp.ip='127.0.0.1'" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser=True" >> /root/.jupyter/jupyter_notebook_config.py
