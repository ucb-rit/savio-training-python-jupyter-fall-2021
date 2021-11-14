# Python on Savio

First step, load in Python:

```sh
# loads latest version on system 3.7
module load python

# or load specific version
module load python/3.6 #
```
--
To see what versions are available on the system:

```sh
[jpduncan@ln002 ~]$ module avail python

-------------------- /global/software/sl-7.x86_64/modfiles/langs ---------------------
python/2.7 python/3.5 python/3.6 python/3.7

----------------- /global/home/groups/consultsw/sl-7.x86_64/modfiles -----------------
python/3.5-consultsw

------------ /clusterfs/vector/home/groups/software/sl-7.x86_64/modfiles -------------
python/2.7.14       python-igraph/0.7.0
```

---

## Don't forget... 

...to `module load python`.

.red[IMPORTANT:] If you forget you will still have a default version available (but no `pip` or `conda`):

```sh
[jpduncan@ln002 ~]$ which python
/usr/bin/python

[jpduncan@ln002 ~]$ python --version
Python 2.7.5

[jpduncan@ln002 ~]$ which {pip,conda}
/usr/bin/which: no pip in (/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/global/home/groups/allhands/bin:/global/home/users/jpduncan/bin)
/usr/bin/which: no conda in (/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/global/home/groups/allhands/bin:/global/home/users/jpduncan/bin)
```

.red[WARNING:] We strongly caution against using Python 2 which is no longer supported by the Python Software Foundation.

---

# System Python Packages

Run `conda list` to see what packages are already available.

```sh
[jpduncan@ln001 ~]$ conda list | head
# packages in environment at /global/software/sl-7.x86_64/modules/langs/python/3.7:
#
# Name                    Version                   Build  Channel
_anaconda_depends         2019.03                  py37_0    anaconda
_ipyw_jlab_nb_ext_conf    0.1.0                    py37_0  
_libgcc_mutex             0.1                        main  
alabaster                 0.7.12                   py37_0  
anaconda                  custom                   py37_1  
anaconda-client           1.7.2                    py37_0  
anaconda-navigator        1.9.7                    py37_0
```

Includes many common packages and their dependencies, such as:
- **Scientific computing**: numpy, scipy
- **Visualization**: bokeh, seaborn, matplotlib
- **Parallelization**: dask, ipyparallel
- **Data ingest/manipulation**: hdf5, pandas
- **Data science**: pyspark, scikit-learn, statsmodels
- many more

---

# More ML packages

A few machine learning packages in the module system:

```sh
[jpduncan@ln002 ~]$ module avail ml

--------------------- /global/software/sl-7.x86_64/modfiles/apps ---------------------
ml/caffe/rc5                  ml/tensorflow/1.12.0-cpu-py36
ml/cntk/2.0.beta15-py27       ml/tensorflow/1.12.0-py36
ml/cntk/2.0.beta15-py35       ml/tensorflow/1.7.0-py27
ml/mxnet/0.9.3-py27           ml/tensorflow/1.7.0-py35
ml/mxnet/0.9.3-py35           ml/tensorflow/1.7.0-py36
ml/mxnet/0.9.3-py36           ml/tensorflow/2.0-py36
ml/mxnet/0.9.3-r-3.2.5        ml/tensorflow/2.1.0-py37
ml/tensorflow/1.0.0-py27      ml/tensorflow/2.3.0-py37
ml/tensorflow/1.0.0-py35      ml/tensorflow/2.5.0-py37
ml/tensorflow/1.0.0-py36      ml/torch/torch7

[jpduncan@ln002 ~]$ module avail pytorch

----------------- /global/home/groups/consultsw/sl-7.x86_64/modfiles -----------------
pytorch/0.3.1-py3.5-cuda9.0 pytorch/0.4.0-py36-cuda9.0  pytorch/1.0.0-py36-cuda9.0
```
---
name: pip

# Installing additional packages with pip

pip stands for "package installer for Python".

You can use it to install packages from:
---
template: pip
- PyPI -- the Python Package Index
```sh
# --user to install in ~/.local
# --upgrade to get newer version of package than already installed
pip install --user --upgrade scikit-learn
```
---
template: pip
count: false
- PyPI -- the Python Package Index

- Version control systems (VCS) such as `git`
```sh
pip install --user git+https://github.com/scikit-learn/scikit-learn
```
---
template: pip
count: false
- PyPI -- the Python Package Index

- Version control systems (VCS) such as `git`

- Local project directories
```sh
# -e is for "editable" installs (can also be used with VS
# if you're familiar with setuptools, this is similar to python setup.py develop
pip install --user -e path/to/your/project
```
---
template: pip
count: false
- PyPI -- the Python Package Index

- Version control systems (VCS) such as `git`

- Local project directories

- Local or remote source archives
```sh
pip install --user https://github.com/scikit-learn/scikit-learn/archive/refs/tags/1.0.1.tar.gz
```
---
template: pip
count: false
- PyPI -- the Python Package Index

- Version control systems (VCS) such as `git`

- Local project directories

- Local or remote source archives

- From a `requirements.txt` file
```
pip install --user -r requirements.txt
```
--

.red[WARNING:] `conda list` won't show the packages installed via the default
version of pip that is available after `module load python`. Use `pip list
--user` instead.

---
# pip default user install directory

By default, using `pip install --user` puts package Python code, library files, and metadata into `~/.local/lib/python3.7/site-packages` (assuming Python 3.7).

```sh
[jpduncan@ln003 ~]$ pip install --user --upgrade scikit-learn
[jpduncan@ln003 ~]$ ls ~/.local/lib/python3.7/site-packages/
__pycache__		      sklearn
scikit_learn-1.0.1.dist-info  threadpoolctl-3.0.0.dist-info
scikit_learn.libs	      threadpoolctl.py
```

To avoid taking up too much room in your home directory, you can move this directory to scratch and create a symlink:
```sh
cp -pr ~/.local /global/scratch/users/$USER/.local
rm -rf ~/.local
ln -s /global/scratch/users/$USER/.local ~/.local
```

Alternatively, you can change this directory for your session using the environmental variable `PYTHONUSERBASE`, or permanently by setting it in `~/.bashrc`.

Alternatively, you can use `--target` with `pip install`, but it's more cumbersome.

---
# Uninstalling packages previously installed with pip

```sh
# uninstall a single package
pip uninstall scikit-learn

# uninstall all user packages
pip freeze --user | xargs pip uninstall -y

# uninstall all user packages with specific prefix
pip freeze --user | grep scikit- | xargs pip uninstall -y
```
Sadly, `pip uninstall` does not remove package dependencies.

See https://pip.pypa.io/en/stable/ for more `pip` tricks.

---
## Managing your Python environment with conda

The second package manager available by default when you `module load python` is `conda`. Unlike `pip`, `conda` is also an environment manager.

Create a conda environment.

```sh
# create an empty conda env called my-env
[jpduncan@ln003 ~]$ conda create --name my-env
```
This creates a directory `~/.conda/envs/my-env`. Activate it:

```sh
[jpduncan@ln003 ~]$ source activate my-env
(my-env) [jpduncan@ln003 ~]$ conda install numpy # also installs Python 3.9
(my-env) [jpduncan@ln003 ~]$ source deactivate
DeprecationWarning: 'source deactivate' is deprecated. Use 'conda deactivate'.
[jpduncan@ln003 ~]$
```

.red[WARNING:] You may be used to using `conda activate` to activate an environment, but this requires you to run `conda init` first which modifies your `.bashrc` in ways that can affect the behavior of your shell more generally on Savio. If you do use `conda init`, be sure to also run `conda config --set auto_activate_base False`.

---
# Installing additional packages with conda

.red[WARNING]: Be sure to activate a conda environment before using `conda install`, otherwise  conda will try to put the packages in a read-only system location.

`conda` is a bit more restrictive than `pip`. There are two main ways to install packages:

- From various conda "channels" such as `default` (https://anaconda.org/), `conda-forge`, `bioconda`, among others.

```sh
conda install scipy # using the default channel

# -c is short for --channel
conda install -c bioconda samtools

# update scipy using the conda-forge channel
conda update scipy --channel conda-forge
```

- Advanced: You can also install from an archive (e.g., .tar.bz2), but doing so won't resolve the package's dependencies.

---
# Using pip within a conda env

.red[WARNING]: This can cause issues because conda doesn't consider pip-installed packages when installing additional packages. Avoid using pip in a conda environment unless you absolutely need to.

If you do choose to use pip with conda, follow these p[best practices](https://www.anaconda.com/blog/using-pip-in-a-conda-environment):

- Use pip only after conda
- If conda changes are needed after using pip, create new environment
- Don't use `--user` when calling `pip install`
- Always run pip with `--upgrade-strategy only-if-needed` (the default)
- Experimental: Use `pip_interop_enabled` setting (see here)[https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/pip-interoperability.html]

<!--
You can use `pip` by installing it in your conda environment.

```sh
(my-env) [jpduncan@ln002 ~]$ which pip
~/.conda/envs/my-env/bin/pip
(my-env) [jpduncan@ln002 ~]$ pip install matplotlib # NOTE: no "--user"
```

When you install packages using pip installed in a conda env, `conda list` shows PyPI as the source:

```sh
(my-env) [jpduncan@ln002 ~]$ conda list
# packages in environment at /global/home/users/jpduncan/.conda/envs/my-env:
#
# Name                    Version                   Build  Channel
# ...
matplotlib                3.4.3                    pypi_0    pypi
# ...
```
-->

---
# Upgrading packages and rolling back conda environment changes

Say you changed your environment (e.g., updated a package) and suddenly your code has errors.

You can roll those changes back as follows:

```sh
conda list --revisions # find the last working revision number
conda install --revision=3 # restore to revision 3
```
.blue[NOTE]: conda doesn't show revisions for changes made by pip, so they can't be rolled back this way.

---
# Changing installation directory with conda

When an environment is active, packages will install in its directory.

You can also install packages to specific environments or paths without activating first:

```sh
# install to the my-env environment
[jpduncan@ln003 ~]$ conda install --name my-env scipy

# create env and install packages at the same time
[jpduncan@ln003 ~]$ conda create --prefix $SCRATCH/conda/envs/scratch-env scipy
# give full path to env to activate
[jpduncan@ln003 ~]$ source activate $SCRATCH/conda/envs/scratch-env
```

Like `~/.local`, you can also consider moving `~/.conda` to scratch and symlinking.

---
# Removing packages, removing conda environments, and cleaning up

To remove a specific package in a specific environment:

```sh
conda remove scipy --name my-env
```

To remove an entire environment (deactivate first):

```sh
conda remove --name my-env --all
```

`conda clean` helps remove unused packages and tarballs:

```sh
conda clean --dry-run --all
```

---

# pip vs conda

## pip

- .green[\+] can use system packages and Python
- .green[\+] new package versions come out on PyPI first
- .green[\+] larger number of Python packages available
- .green[\+] more flexible package installation options
- .green[\+] tends to be a bit faster than conda
- .red[\-] doesn't check for simultaneous compatibility of all dependencies
- .red[\-] limited to Python versions available on system
- .red[\-] no automated dependency cleanup (`pip-autoremove` package may help)
- .red[\-] Python packages only

## conda

- .green[\+] environments self-contained, can use any version of Python
- .green[\+] `conda clean` helps remove unused packages
- .green[\+] if you make a change that didn't go well, roll back
- .green[\+] not just Python packages
- .green[\+] ensures that all dependencies are compatible
- .red[\-] `conda install` tends to be slower than `pip install`
- .red[\-] environments can become quite large on disk and/or cause I/O issues
- .red[\-] more limited number of Python packages available

---
# Best practices for reproducibility

**pip -- use a requirements.txt**

```sh
pip freeze > requirements.txt
```

**conda -- use an environment.yml file**

```sh
conda env export > environment.yml
```

**even better -- use a container**

See our [training on using containers on Savio](https://docs-research-it.berkeley.edu/services/high-performance-computing/getting-help/training-and-tutorials/#savio-introduction-to-containers-on-savio-creating-reproducible-scalable-and-portable-workflows).

- .green[\+] Prevents I/O issues on the system
- .green[\+] Very portable
- .red[\-] more of a learning curve

---
