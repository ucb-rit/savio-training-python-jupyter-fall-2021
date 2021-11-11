# Overview Open OnDemand

OOD allows various interactive applications to access the full Savio infrastructure, including:

- Jupyter Notebooks (our focus)
- RStudio
- Matlab
- VS Code

.center[![Open On Demand on Savio](images/ood.png)]

---
# Jupyter Notebooks overview

Jupyter Notebooks provide an interactive environment for writing and executing
Python code, visualizing results, and creating documentation.

A Jupyter Notebook can serve as a reproducible record for your analysis.

Let's take a quick look at Jupyter on OOD now: https://ood.brc.berkeley.edu

---
# Jupyter kernels

Every Jupyter Notebook uses a kernel, which provides programming language
support. In particular, the default IPython kernel allows Jupyter Notebooks to
run Python.

On Savio we have a number of Jupyter kernels available by default:

- Python 2.7, 3.6, 3.7
- TensorFlow kernels
- pyspark

See here for a list of kernels for other programming languages that may work on
Savio: https://github.com/jupyter/jupyter/wiki/Jupyter-kernels

---
# Making your own Jupyter kernel

If the default kernels don't meet your needs, you can create your own. There are
various methods, but a straightforward one is to use an environment. We could
use conda to create an environment which we then convert to an ipykernel:

```sh
module load python
conda create -n py39 python=3.9 ipykernel
source activate py39
python -m ipykernel install --user --name=py39 --display-name="Python 3.9"
source deactivate
```

.blue[NOTE]: If you don't need a different version of Python from what the system provides, then using a `virtualenv` may take less space on disk than a conda environment.

---
## Modifying your kernels to use system modules

Say we want to create an kernel that uses the `ml/tensorflow/2.5.0-py37` module.

```sh
module load ml/tensorflow/2.5.0-py37
python -m ipykernel install --user --name=tf25 --display-name="Python3.7 TF2.5.0"
```
This creates `~/.local/jupyter/kernels/tf25/kernel.json`:

```json
{
 "argv": [
  "/global/software/sl-7.x86_64/modules/langs/python/3.7/bin/python",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "Python3.7 TF-2.5.0",
 "language": "python"
}
```
We'll need to edit this file so that the kernel has access to module and its dependencies.

---
We'll add a dictionary called `"env"` with environmental variables to set when starting up the kernel. To know what to add in this case, take a look at your environmental variables after you run `module load ml/tensorflow/2.5.0-py37`:

```sh
echo $PATH
echo $LD_LIBRARY_PATH
echo $PYTHONPATH
```
In my case, the final `kernel.json` looks like this:
```json
{
    "argv": [
        "/global/software/sl-7.x86_64/modules/langs/python/3.7/bin/python",
        "-m",
        "ipykernel_launcher",
        "-f",
        "{connection_file}"
    ],
    "display_name": "Python3.7 TF-2.5.0",
    "language": "python",
    "env": {
        "PATH": "/global/software/sl-7.x86_64/modules/apps/ml/tensorflow/2.5.0-py37/bin:/global/software/sl-7.x86_64/modules/langs/cuda/11.2/bin:/global/software/sl-7.x86_64/modules/langs/python/3.7/bin:/global/software/sl-7.x86_64/modules/langs/python/3.7/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/global/home/groups/allhands/bin:/global/home/users/jpduncan/bin",
        "LD_LIBRARY_PATH": "/global/software/sl-7.x86_64/modules/cuda/11.2/cudnn/8.1.1/lib64:/global/software/sl-7.x86_64/modules/langs/cuda/11.2/lib64/stubs:/global/software/sl-7.x86_64/modules/langs/cuda/11.2/lib64",
        "PYTHONPATH" : "/global/software/sl-7.x86_64/modules/apps/ml/tensorflow/2.5.0-py37/lib/python3.7/site-packages"
    }
}
```
---

Now I can use my new TensorFlow kernel on a GPU node.
 
.center[![Jupyter with TensorFlow kernel](images/jupyter-tf.png)]

---
