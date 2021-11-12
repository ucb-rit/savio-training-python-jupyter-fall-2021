# Using ipyparallel in a Jupyter notebook

As of our recent upgrade to version 7 of the ipyparallel package, you can start the ipyparallel workers from within Python and therefore from within your notebook. This is the same as we just saw in our basic Python session.

Previously, one needed to either start the workers via the "IPython Clusters" tab of the Jupyter interface or start the workers using `ipcluster start` from a terminal session and then connecting to them from the notebook.

As before, the number of workers should generally match the number of cores you requested (e.g., on `savio2_htc`) or (ideally) the number of cores on the machine (for partitions allocated on a per node basis).

If you've started the workers outside of Python, you need to connect to the running cluster. As before with the ipyparallel examples, 'c' gives us a 'handle' object.

```
import ipyparallel as ipp
c = ipp.Client(profile='default', cluster_id='')
c.ids # this should show the number of workers equal to the number you requeste
```

# Multiple nodes

This may be possible. Feel free to ask us and we can explore it further. 

---
