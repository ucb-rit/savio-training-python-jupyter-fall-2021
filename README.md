# savio-training-python-jupyter-fall-2021

Materials for "Python & Jupyter Notebooks on Savio" training on November 15, 2021.

This is an intermediate training session on using Python and Jupyter Notebooks on Savio, the UC Berkeley campus Linux high-performance computing cluster. We will give an overview and best practices of Python environment and package management using pip and conda, using and debugging Jupyter Notebooks on Savio via Open On Demand, creating custom Jupyter Notebook kernels, and basic parallelization strategies in Python (ipyparallel, Dask, and Ray), with examples on the command line and using Jupyter Notebooks.

The main document is `slides.html` (or `slides_onepage.html` if you prefer a version that appears in one long HTML page rather than in slide format).

To directly view the HTML, please [click here](https://ucb-rit.github.io/savio-training-python-jupyter-fall-2021/slides.html#1).

If you're not familiar with Git or Github you can download the materials as a [zip file](https://github.com/ucb-rit/savio-training-python-jupyter-fall-2021/archive/main.zip)

This material is also available at [https://tinyurl.com/brc-nov21](https://tinyurl.com/brc-nov21).

Participants not familiar with operating in a UNIX-style command-line shell environment may want to look over one of these tutorials in advance:

- https://swcarpentry.github.io/shell-novice
- https://github.com/berkeley-scf/tutorial-unix-basics

## Making HTML output

The slides use [remark.js](https://remarkjs.com/#1) and are rendered from `slides.md` using `tpage`, part of the [Perl Template Toolkit](http://www.template-toolkit.org/). To render the HTML files, run `make`.
