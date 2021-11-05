class: center, middle

# Using Python & Jupyter Notebooks on Savio

---

# Outline

- Python package management on the cluster

  - Pros and cons of pip and conda
  - Best practices when using virtual environments

--

- Using Jupyter notebooks via Open OnDemand
  - Creating your own Jupyter kernels from a conda env
  - Modifying the kernel to use the module system
  - Monitoring and debugging OOD jobs

--

- Basic parallelization strategies in Python
  - ipyparallel
  - Dask
  - Ray
  - Parallel processing in Jupyter notebooks

---

```
@requires_authorization(roles=["ADMIN"])
def somefunc(param1='', param2=0):
    r'''A docstring'''
    if param1 > param2: # interesting
        print 'Gre\'ater'
    return (param2 - param1 + 1 + 0b10l) or None

class SomeClass:
    pass

>>> message = '''interpreter
... prompt'''
```

# Introduction

We'll do this mostly as a demonstration. We encourage you to login to your account and try out the various examples yourself as we go through them.

Much of this material is based on the extensive Savio documention we have prepared and continue to prepare, available at [https://docs-research-it.berkeley.edu/services/high-performance-computing/](https://docs-research-it.berkeley.edu/services/high-performance-computing/).

The materials for this tutorial are available using git at the short URL ([tinyurl.com/brc-oct21](https://tinyurl.com/brc-oct21)), the  GitHub URL ([https://github.com/ucb-rit/savio-training-intro-fall-2021](https://github.com/ucb-rit/savio-training-intro-fall-2021)), or simply as a [zip file](https://github.com/ucb-rit/savio-training-intro-fall-2021/archive/main.zip).

---
