# Trajectory Data Structures and Algorithms

This repository contains code and other information relating to my PhD Thesis. I study problems in the field of Computational Geometry, and specifically research new and novel solutions within the field of Computational Movemement Analysis. In a nutshell, I focus on researching new data structures and algorithms that answer proximity queries on movement data, i.e., data that contains changing coordinate locations on moving objects, called trajectories. Trajectory data sets are diverse and real-world examples include: foraging flying bats, people commuting within a city, house cats on the prowl in their neighborhood, roaming buffalo, shipping vessel paths, pen-tip (handwriting) movement, human skeletal sign language joint movement, hurricane tracking, and cement truck routes. Although real trajectories exist in 2D or 3D space, theoretically, trajectories can be constructed in higher dimensional space which can be advantageous in solving certain problems.

The algorithms and data structures are designed to have smaller pre-processing and query computational complexity, as well as a smaller size complexity.  Our work includes both theoretical and experimental results, and can answer questions such as:
1) We are given a large trajectory input set S, and the goal is to find trajectories in S that are close to a query 𝑄.  We must support both kNN and Range queries that give either exact or approximate results, under the continuous Fréchet distance.
2) We are given a large input trajectory 𝑃 and small query trajectory 𝑄, and the goal is to find the sub-trajectory 𝑃′ in 𝑃 that is closest to 𝑄
3) We are given a training set containing sign language skeletal movement sequences with labels, and the goal is to correctly classify a test (query) sequence.

My PhD thesis can be downloaded [here](https://cloudstor.aarnet.edu.au/plus/s/c6ylHAahVMqeAbk).

There are three main projects, each with their own associated paper:
1) [Trajectory Proximity Queries](https://github.com/japfeifer/frechet-queries/wiki/Trajectory-Proximity-Queries) under the Continuous Fréchet Distance
2) [Sub-trajectory Proximity Queries](https://github.com/japfeifer/frechet-queries/wiki/Sub-trajectory-Proximity-Queries) under the Continuous Fréchet Distance
3) [Sign Language Recognition](https://github.com/japfeifer/frechet-queries/wiki/Sign-Language-Recognition-Project) from Skeletal Trajectory Data with Interpretable Classifiers

For detailed information on each of the projects, including how to access the various data sets and how to install and run experiments, please click on the following [Wiki page](https://github.com/japfeifer/frechet-queries/wiki).

Other potentially interesting sub-topics that have accompanying code include:
1) Performing trajectory similarity searches using Hyper Vector computing (see [Pentti Kanerva](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=Pentti+Kanerva&btnG=), [Chris Eliasmith](https://scholar.google.com/citations?user=KOBO-6QAAAAJ&hl=en&oi=sra), and [Tony Plate](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=Tony+Plate&btnG=)).

I acknowledge and thank my PhD supervisor, [Dr. Joachim Gudmundsson](https://scholar.google.com/citations?user=uECC9_gAAAAJ&hl=en&oi=sra), and auxilliary supervisor, [Dr. Martin P. Seybold](https://scholar.google.com/citations?user=CwRCo7IAAAAJ&hl=en&oi=ao), for helping to contribute and guide me throughout the programme at the School of Computer Science, University of Sydney, Australia.
