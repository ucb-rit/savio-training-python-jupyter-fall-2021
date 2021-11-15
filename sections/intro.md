class: center, middle

# Using Python & Jupyter Notebooks on Savio

---

# Announcements

- Research IT is hiring several [graduate student Domain Consultants](https://docs.google.com/document/d/18-ea-CsRsSVSu8hhFqnPFs-i7RvcG1ObGCW_1olUdJg/edit) for flexible, 10% to 25% (4-10 hours/week) appointments. Email your cover letter and CV to: [research-it@berkeley.edu](mailto:research-it@berkeley.edu)

- Our next [Cloud Computing Meetup](https://www.meetup.com/ucberkeley_cloudmeetup/) is on **Thursday, December 9 at 1pm** and focused on **startups using cloud technologies**.

- We are looking for researchers working with **sensitive data**. Get in touch for more information: [research-it@berkeley.edu](mailto:research-it@berkeley.edu)

- If you have any data or compute questions, please visit us at our weekly office hours on **Wednesdays from 1:30-3pm** and **Thursdays from 9:30-11am**. See https://research-it.berkeley.edu/consulting for Zoom link.

---

# Outline

- Python package management on the cluster

  - Pros and cons of pip and conda
  - Best practices when using virtual environments

--

- Using Jupyter notebooks via Open OnDemand on Savio
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

# Introduction

We'll do this mostly as a demonstration. We encourage you to login to your account and try out the various examples yourself as we go through them.

Much of this material is based on the extensive Savio documention we have prepared and continue to prepare, available at [https://docs-research-it.berkeley.edu/services/high-performance-computing/](https://docs-research-it.berkeley.edu/services/high-performance-computing/).

The materials for this tutorial are available using git at the short URL ([tinyurl.com/brc-nov21](https://tinyurl.com/brc-nov21)), the  GitHub URL ([https://github.com/ucb-rit/savio-training-python-jupyter-fall-2021](https://github.com/ucb-rit/savio-training-python-jupyter-fall-2021)), or simply as a [zip file](https://github.com/ucb-rit/savio-training-python-jupyter-fall-2021/archive/main.zip).

---
