# Basic parallelization using ipyparallel


# Overview of ipyparallel


# Starting workers on one node

```
## In newer versions of ipyparallel (v. 7 and later?)
import ipyparallel as ipp
cluster = ipp.Cluster(n=4)
cluster.start_cluster_sync()
```

```
c = cluster.connect_client_sync()
c.ids
```

Side note: You can also start the workers from the command line (this was required in older versions of ipyparallel, probably before version 7).

```
# in the shell
ipcluster start -n 4
```

```
# in python
import ipyparallel
c = ipp.Client()
c.ids
```

# Parallelized cross-validation for machine learning


# Using multiple nodes

When using multiple nodes, we will generally start up a controller process on the first node that Slurm gives us and then use `srun` (within our running `srun` or `sbatch` session) to start up workers on the nodes.

```
ipcontroller --ip='*' &
sleep 30

## The next line starts one worker per SLURM task 
## (which should equal the number of cores)

srun ipengine &
sleep 45  # wait until all engines have successfully started
```
