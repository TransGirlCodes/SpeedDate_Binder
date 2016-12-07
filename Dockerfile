FROM andrewosh/binder-base

MAINTAINER Ben J. Ward <ward9250@gmail.com>

USER root

# Add julia and the dependencies.
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN add-apt-repository ppa:staticfloat/julia-deps
RUN apt-get update
RUN apt-get install -y julia libnettle4 && apt-get clean

USER main

# Install IJulia and so on.
RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("Gadfly")' && julia -e 'Pkg.add("RDatasets")'
