# Basic parallelization using ipyparallel

We'll start by using the IPython parallel package (`ipyparallel`), which allows one to parallelize on a single machine (discussed here) or across multiple machines (see the tutorial on distributed memory parallelization). 

`ipyparallel` allows one to easily split up tasks that can be computed independently and send those tasks out to Python worker processes to run in parallel. The results are then collected back on the main Python process.

Since the workers are separate Python processes, we need to start up those processes, either from within Python (possible as of version 7 of ipyparallel) or from the command line.

# Starting workers on one node

```
## In newer versions of ipyparallel (v. 7 and later)
import ipyparallel as ipp
cluster = ipp.Cluster(n=4)
cluster.start_cluster_sync()
```

```
c = cluster.connect_client_sync()
## Check that we have the number of workers expected:
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

# Testing our cluster

Let's just verify that things seem set up ok and we can interact with all our workers:

```
dview = c[:]
dview.block = True
dview.apply(lambda : "Hello, World")
```

`dview` stands for a 'direct view', which is an interface to our cluster that allows us to "manually" send tasks to the workers.

# Parallelized machine learning example

Now let's see an example of how we can use our workers to run code in parallel. 

We'll carry out a statistics/machine learning prediction method (random forest regression) with leave-one-out cross-validation, parallelizing over different held out data.

First let's set up packages, data and our main function on the workers:

```
dview.execute('from sklearn.ensemble import RandomForestRegressor as rfr')
dview.execute('import numpy as np')

def looFit(index, Ylocal, Xlocal):
    rf = rfr(n_estimators=100)
    fitted = rf.fit(np.delete(Xlocal, index, axis = 0), np.delete(Ylocal, index))
    pred = rf.predict(np.array([Xlocal[index, :]]))
    return(pred[0])

import numpy as np
np.random.seed(0)
n = 500
p = 50
X = np.random.normal(0, 1, size = (n, p))
Y = X[: , 0] + pow(abs(X[:,1] * X[:,2]), 0.5) + X[:,1] - X[:,2] + np.random.normal(0, 1, n)

mydict = dict(X = X, Y = Y, looFit = looFit)
dview.push(mydict)
```

# Parallelized machine learning example (2)

Now let's set up a "load-balanced view". With this type of interface, one submits the tasks and the controller decides how to divide up the tasks, ideally achieving good load balancing. A load-balanced computation is one that keeps all the workers busy throughout the computation

```
lview = c.load_balanced_view()
lview.block = True

# We'll leave out only 50 observations, for the sake of time
nSub = 50

# need a wrapper function because map() only operates on one argument
def wrapper(i):
    return(looFit(i, Y, X))

# Now run the fitting, predicting on each held-out observation:

import time
time.time()
pred = lview.map(wrapper, range(nSub))
time.time()

pred
```


# Using multiple nodes

When using multiple nodes, we will generally start up a controller process on the first node that Slurm gives us and then use `srun` (within our running `srun` or `sbatch` session) to start up workers on the nodes.

First we'll start our Slurm job using `sbatch` or `srun`.

Then once the job starts (if using `srun`) or within our submission script (if using `sbatch`):

```
ipcontroller --ip='*' &
sleep 30

## The next line starts one worker per SLURM task 
## (which should equal the number of cores)

srun ipengine &
sleep 45  # wait until all engines have successfully started
```

At this point you should be able to connect to the running cluster using the syntax seen for single-node usage.
