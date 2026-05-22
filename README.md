# Traveling Waves and Pattern Encoding

This repository contains a MATLAB simulation of two working-memory storage mechanisms: one based on static activity patterns and one based on traveling activity patterns. The model tests how each mechanism interacts with synaptic plasticity, and whether traveling activity is more robust against interference from previously learned weights.

The main entry point is `startingFunction.m`. It initializes binary activity grids, evolves them over time, updates synaptic weights, and compares the resulting activity against the expected activity (i.e., if there were no interference from synaptic connections). At time step 100, part of the stored memory content is replaced with new random items, allowing the simulation to test how well each storage mechanism maintains updated information.

## Overview

The simulation compares two activity regimes:

- **Static activity**: active units remain in the same spatial columns unless changed by learned weights
- **Traveling activity**: activity shifts by one spatial column at each time step and wraps around at the boundary.

Both regimes use the same weight-update rule. Active units strengthen connections between neighboring columns, while existing weights decay over time. The model is run across multiple random iterations and two learning-rate settings.

Performance is measured by normalized Hamming distance, which captures how far the maintained pattern has drifted from the expected pattern.

## Requirements

- MATLAB
- Statistics and Machine Learning Toolbox

## How To Run

Open MATLAB in this repository and run:

```matlab
startingFunction
```

The simulation uses a fixed random seed for reproducibility and opens figure windows with the resulting activity, distance, and weight summaries.

## Main Parameters

The key parameters are defined near the top of `startingFunction.m`:

- `nNodesX = 10`: number of neural units per spatial column
- `nNodesY = 15`: number of spatial columns
- `nTimeSteps = 200`: number of simulated time steps
- `epsilon = 0.1`: scale of the initial random synaptic weights
- `deltaIncrease = [0.05 0.1]`: low and high learning-rate conditions
- `sparsityThreshold = 0.25`: controls the sparsity of the initial binary activity pattern
- `numberOfNewItem = 8`: number of columns modified at time = 100

