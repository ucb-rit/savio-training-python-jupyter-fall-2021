# Overview of Ray
Ray provides many tools for parallel computation, including remote functions (tasks) and remote classes (actors).

To start Ray on a single node:

```py
import ray

ray.init() # this use all available cores

ray.init(num_cpus=4, num_gpus=2) # or tell Ray exactly what you want to use
```

Ray **Tasks** allow you to parallelize your functions via decorators:

```py
@ray.remote()
def my_function(x):
    return x * x
```

To call a remote function, use `fun_name.remote()`:
```py
futures = [my_function.remote(i) for i in range(4)]
print(ray.get(futures)) # [0, 1, 4, 9]
```

---
# Parallel classes

Ray **Actors** let you parallelize all the methods of a Python class:
```py
@ray.remote
class Counter(object):
    def __init__(self, init_val=0):
        self.n = init_val

    def increment(self, multiplier = 1):
        self.n += 1 * muliplier

    def read(self):
        return self.n
```

Use `my_obj = ClassName.remote()` to initialize a new instance and `my_obj.method_name.remote()` to call
```py
# initialize
counters = [Counter.remote(i) for i in range(4)]
# call a mutating method
[c.increment.remote(2) for c in counters]
# call an accessor method
futures = [c.read.remote() for c in counters]
# get the value
print(ray.get(futures)) # [2, 3, 4, 5]
```
---
# Ray object store

.center[![Ray object store](images/ray-vs-dask.png)]

Compared to Dask, Ray has the advantage of a **shared-memory object store**, which allows workers on the same node to reuse memory.

.blue[NOTE]: Ray Data (in beta as of Ray 1.8) allows for interop with Dask collections (such as distributed DataFrames and Bags) by providing a Ray scheduler for Dask (`dask_on_ray`).

.footnote[Source: https://www.anyscale.com/blog/analyzing-memory-management-and-performance-in-dask-on-ray]

---
# Multi-node Ray

It's also possible to run Ray across nodes using Slurm.

The Ray docs provide examples and helper utilities to create `sbatch` scripts that will set up a multinode Ray cluster via Slurm. See here: https://docs.ray.io/en/latest/cluster/slurm.html

---
# Other Ray projects

There are additional Ray libraries in various stages of development that could be worth checking out:

- [Datasets](https://docs.ray.io/en/latest/data/dataset.html): support for many data input formats and distributed DataFrame and basic distributed data transformations (e.g., map, filter, and repartition).

- [Tune](https://docs.ray.io/en/latest/tune/index.html): distributed hyperparameter tuning for ML frameworks

- [RLlib](https://docs.ray.io/en/latest/rllib.html): scalable reinforcement learning and unified API for different frameworks (e.g. TensorFlow and PyTorch).

- [Workflows](https://docs.ray.io/en/latest/workflows/concepts.html): Adds durability to Ray dynamic task graphs, appropriate for large-scale ML pipelines or long-running applications.

---
