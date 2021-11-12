# Dask overview

Python's Dask package provides powerful tools for parallelizing computations on a single machine or across multiple machines.

In addition to providing tools that allow you to parallelize independent computations as we did with `ipyparallel`, Dask also allows you to run computations across datasets in parallel using distributed data objects.

There's lots of information about Dask online, including [this tutorial](https://github.com/berkeley-scf/tutorial-dask-future) prepared by Chris Paciorek.

---

# Distributed data in Dask

The idea here is to split up large datasets into chunks (also called 'partitions' or 'shards') and operate in parallel on those chunks. This generally assumes that / works best when the operations can be done independently on the chunks and limited information needs be communicated between chunks.

Some advantages of this are:

 - increasing speed by using multiple cores to process the data.
 - when using multiple nodes, increasing the amount of total memory that can be used by having the data split across the nodes.
 
# Dask's distributed data types

Some of the key types of distributed data objects in Dask are:
 
  - distributed dataframes - each chunk is a Pandas dataframe
  - distributed arrays - each subset of the array is a Numpy array
  - bags - distributed lists, where each chunk contains some of the elements
  
---
  
# Dask's 'schedulers'

Dask can set up the parallel workers in a variety of ways, which are called schedulers. Here are the options:

|Type|Description|Multi-node|Copies of objects made?|
|----|-----------|----------|-----------------------|
|synchronous|not in parallel|no|no|
|threaded|threads within current Python session|no|no|
|processes|background Python sessions|no|yes|
|distributed|Python sessions across multiple nodes|yes or no|yes|

.blue[NOTE:] Because of Python's Global Interpreter Lock (GIL), many computations done in pure Python code won't be parallelized using the 'threaded' scheduler; however computations on numeric data in numpy arrays, Pandas dataframes and other C/C++/Cython-based code will parallelize.

Here's an example of setting the 'processes' scheduler for a computation:

```
import dask.multiprocessing
# spread work across multiple cores, one worker per core
dask.config.set(scheduler='processes', num_workers = 4)  
```

---

# Dask bag example - context

Let's read in a bunch of data from multiple files and put it into a Dask bag.

Here's the format of the input files. They're actually tabular type data (i.e., we can think of rows as observations and columns (space separated here) as fields/variables. But in working with the data using a bag, we'll treat each row as arbitrary observation that is simply a string.

Let's get a sense for the data first:

```
gzip -cd /global/scratch/users/paciorek/wikistats_small/dated/part-00000.gz | head -n 5
```

The data are the number of visits to a given Wikipedia page on a given hour of a given day, in a given language.

---

# Dask bag example - initial processing


```
import dask.bag as db
wiki = db.read_text('/global/scratch/users/paciorek/wikistats_small/dated/part-0000*')
# How many partitions (for zipped files, this will be one per file)
wiki.npartitions
wiki
# dask.bag<bag-from-delayed, npartitions=10>

# Count the number of elements

wiki.count().compute()

import re
def find(line, regex = "Obama", language = "en"):
    vals = line.split(' ')
    if len(vals) < 6:
        return(False)
    tmp = re.search(regex, vals[3])
    if tmp is None or (language != None and vals[2] != language):
        return(False)
    else:
        return(True)
    
# Filter to the pages related to Barack Obama and count them
obama = wiki.filter(find).count().compute()
```

# Lazy execution and pipelines

Note that Dask executes lazily. The call to `read_text` doesn't read the data in and `wiki` is just an abstract placeholder for the actual data.

Only when we run `compute()` (or a few other operations that indicate the user wants output) is the "pipeline" actually run. 

Note that if you call `compute()` twice, the entire dataset will get read in twice. So it's good to combine multiple operations into a single pipeline.
Here's an example:

```
total_cnt =wiki.count()
obama = wiki.filter(find)
obama_cnt = obama.count()
(obama, obama_cnt, total_cnt) = db.compute(obama, obama_cnt, total_cnt)
total_cnt
obama[0:5]
```

---

# Extending the example

Here's a pipeline where we read the data in, extract the Obama-related entries, and aggregate it to count the number of Obama-related visit for each day-hour combination.

To do this, we convert the Dask bag to a Dask dataframe and then using dataframe aggregation operations (the same syntax as in Pandas).

```
def make_tuple(line):
    return(tuple(line.split(' ')))

dtypes = {'date': 'object', 'time': 'object', 'language': 'object',
          'webpage': 'object', 'hits': 'float64', 'size': 'float64'}

# df is a Dask dataframe
df = obama.map(make_tuple).to_dataframe(dtypes)
stats = df.groupby(['date','time']).hits.sum().compute()

# stats is a Pandas object
stats.to_csv('obama_stats.csv')
```

---
