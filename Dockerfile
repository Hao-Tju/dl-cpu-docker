# -*- mode: dockerfile -*-
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# Dockerfile to build MXNet CPU with MKL

FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y wget python-dev gcc && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py

RUN pip3 install mxnet-mkl==1.6.0 gluoncv jupyterlab scipy numpy
RUN jupyter notebook --generate-config && echo "c.NotebookApp.ip='127.0.0.1'" >> /root/.jupyter/jupyter_notebook_config.py && echo "c.NotebookApp.open_browser=False" >> /root/.jupyter/jupyter_notebook_config.py
