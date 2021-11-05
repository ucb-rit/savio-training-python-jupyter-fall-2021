# Using ipyparallel in a Jupyter notebook

We have some [directions](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/ood/jupyter-parallelization/) on parallelization within a notebook. 

This uses the `ipyparallel` package that we explored from within a simple Python command line session. 

Once we've done the one-time setup, we can go to the 'IPython Clusters' tab and choose the number of workers. These workers will start on the single node our notebook is running on. 

So the number of workers would generally match the number of cores you requested (e.g., on `savio2_htc`) or (ideally) the number of cores on the machine (for partitions allocated on a per node basis).

**Caution**: on the standalone OOD node (for debugging/exploration), the amount of memory is limited. Reading in a large file may cause the kernel to die without any warnings/error messages. For example this occurs for a 260 MB CSV file, even though in principle the notebook can use up to 2 GB memory...

# Within the notebook

We need to connect to the running cluster. 'c' gives us a "handle" object.

```
import ipyparallel as ipp
c = ipp.Client(profile='default', cluster_id='')
c.ids # this should show the number of workers equal to the number you requeste
```

Now we can run our random forest cross-validation. See `randomForest_cv.py`.

# Multiple nodes

This may be possible. Feel free to ask us and we can explore it further. 