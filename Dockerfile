FROM andrewosh/binder-base

MAINTAINER Ben J. Ward <ward9250@gmail.com>

USER root

# Add the dependencies for julia.
RUN apt-get update
RUN apt-get install -y wget libzmq3-dev cmake libmpich-dev mpich && apt-get clean

USER main

RUN pip install -I --upgrade setuptools
RUN pip install --upgrade ipywidgets
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Install julia.
RUN wget https://julialang.s3.amazonaws.com/bin/linux/x64/0.5/julia-0.5.0-linux-x86_64.tar.gz
RUN mkdir $HOME/julia
RUN tar xf julia-0.5.0-linux-x86_64.tar.gz -C $HOME/julia --strip-components=1
ENV PATH $PATH:$HOME/julia/bin

# Install julia packages.
RUN julia -e 'Pkg.init();Pkg.update();Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("Reactive");Pkg.add("Interact");Pkg.add("Gadfly")'
