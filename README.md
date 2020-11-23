# Trajectory Data Structures and Algorithms

This repository contains code and other information relating to my PhD Thesis. I study problems in the field of Computational Geometry, and specifically research new and novel solutions in the sub-field of Computational Movemement Analysis. In a nutshell, I focus on researching new data structures and algorithms that solve problems on movement data, i.e. data that contains trajectory information on moving objects. The work includes both theoretical and experimental results. Trajectory data sets are diverse and examples include: foraging flying bats, people commuting within a city, house cats on the prowl in their neighborhood, roaming buffalo, shipping vessel paths, pen-tip (handwriting) movement, human skeletal sign language joint movement, hurricane tracking, and cement truck routes.

The algorithms and data structures are designed to have smaller pre-processing and query computational complexity, as well as a smaller size complexity.  Our work can answer questions such as:
1) Given an input set containing many trajectories and a query trajectory, provide exact or approximate nearest-neighbor, k-nearest-neighbor, or range (all trajectories within a distance threshold) results that are closest to the query, under the continuous Frechet similarity measure.
2) Given a training set containing sign language skeletal movement with labels, classify a test (query) sign.
3) Given a large trajectory input and a query trajectory, find the exact or approximate sub-trajectory segments within the large trajectory input for nearest-neighbor, k-nearest-neighbor, or range queries.

There are three main projects, each with their own associated paper:
1) Trajectory Proximity Queries under the Continuous Fréchet Distance
2) Sign Language Recognition from Skeletal Trajectory Data with Interpretable Classifiers
3) Sub-trajectory Proximity Queries under the Discrete and Continuous Fréchet Distances

Other potentially interesting sub-topics that have accompanying code include:
1) Performing trajectory sililarity searches using Hyper Vector computing (Pentti Kanerva, Chris Eliasmith, Tony Plate, et al.).

For detailed information on each of the projects, including how to access the various data sets and how to install and run experiments, please click on the Wiki page.

I acknowledge and thank my PhD supervisor, Dr. Joachim Gudmundsson, and auxilliary supervisor, Dr. Martin P. Seybold, for helping to contribute and guide me throughout the programme. 
