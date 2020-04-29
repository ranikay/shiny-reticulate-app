## Tutorial: using Shiny + reticulate to create apps with R and Python 3

<br> 

The `reticulate` package from RStudio allows you to incorporate Python functions and scripts into your R code. Inspired by the many questions online around writing and deploying Shiny apps that use the `reticulate` package, I created this app as an end-to-end example.

Note that this app does something a little unusual: it sets a few relevant environment variables in the .Rprofile file. The purpose of the is to make this demonstration fully self-contained, allowing this app to be run in 3 different environments (locally, on shinyapps.io, and on RStudio Connect) without any modification. Section 4 below describes managing env variables in RStudio Connect. *However, please remember that an .Rprofile file should not be used for credentials, secrets, API keys, etc! And if you have creds in an .Rprofile or an .Renviron file, don't check them in to git as clear text.*

#### In this tutorial, you will learn:

1. How to configure reticulate virtual environments for use locally and on shinyapps.io. (This example uses Python 3 but can be modified for Python 2, if desired.)

2. How to deploy to shinyapps.io

3. How to confirm that your app deployed on shinyapps.io is using the desired version of Python

4. How to deploy to RStudio Connect

---

### About the demo app

**See it in action:** [A live version deployed to shinyapps.io and using Python 3 can be seen here](https://elasticlabs.shinyapps.io/shiny-reticulate-app/)!

The demo app example contains two tabs. The first tab demonstrates some R and Python functions being used to make a plot and print some text. The second tab displays a table summarizing the architecture information for the machine running the app.

<br>

<p align="center">
<img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1swmp-cclfzk-351qtl/Two_tab_video.gif" width="800">
</p>

---

### Tutorial


##### Table of Contents

- [First-time set-up](#first-time-set-up)
  - [Installing requirements](#installing-requirements)
  - [Setting up the local virtual environment](#setting-up-the-local-virtual-environment)
- [Running and deploying](#running-and-deploying)
  - [Running the app locally](#running-the-app-locally)
  - [Deploying to shinyapps.io](#deploying-to-shinyapps.io)
- [Troubleshooting](#troubleshooting)

 
---

### First-time set-up

#### Installing requirements

To clone this project, in a terminal, run:

  ```bash
  git clone https://github.com/ranikay/shiny-reticulate-app.git
  cd shiny-reticulate-app/
  ```

Install Python and the required packages:

- Python >= 3.5

- Python packages: [virtualenv](https://virtualenv.pypa.io/en/stable/) and [numpy](https://numpy.org/)

  To install Python packages, in a terminal, run:

  ```bash
  pip install virtualenv
  pip install numpy
  ```
  
Install R and the required packages:

- R >= 3.6

- [RStudio](https://rstudio.com/products/rstudio/)

- R packages: [shiny](https://cran.r-project.org/web/packages/shiny/index.html), [DT](https://cran.r-project.org/web/packages/DT/index.html), [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/),
[reticulate](https://rstudio.github.io/reticulate/),
[shinycssloaders](https://github.com/daattali/shinycssloaders)

  To install the above packages, in the R console, run:

  ```R
  install.packages("shiny")
  install.packages("DT")
  install.packages("RColorBrewer")
  install.packages("reticulate")
  ```
  
  **Notes on reticulate**: the RStudio team has made some changes to `reticulate` recently, including [changes that enable Python 3 virtual environments on shinyapps.io](https://github.com/rstudio/reticulate/issues/399), so make sure to use reticulate>=1.14.

---

### Running and deploying

#### Running the app locally

In RStudio, open the file server.R and click **Run App** to view your app.

<p align="center">
<img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1jwwt-3fnhuw-5qoay7/shiny-reticulate-app_screenshot_run_app.png" width="600">
</p>

<br>

For the Python functionality demonstrated on the first tab of the app, the app is using a Python 3 virtual environment named in the .Rprofile file. The app knows to use this virtual environment based on line 20 in server.R.

While running the app, we can click on the **Architecture Info** tab to confirm that the app is using the correct version of Python.

<br>

#### Deploying to shinyapps.io

Deploying your app to shinyapps.io requires the `rsconnect` package and a shinyapps.io account. If you haven't deployed an app to shinyapps.io before, instructions for creating an account and configuring `rsconnect` can be found [here](https://docs.rstudio.com/shinyapps.io/getting-started.html).

Begin by running the app locally. In RStudio, open the file server.R and click **Run App** to view your app.

Click **Publish** in the upper right, confirm that the shinyapps.io account information is correct and name your app. Then click **Publish** in the pop-up window to send your app to the shinyapps.io cloud servers.

<p align="center">
<img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1sz52-ahuy0o-4mm0t0/Publish.png" width="600">
</p>

A successful deploy will produce a deployment log similar to this in the "Deploy" window in RStudio:

<p align="center">
<img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1szho-9873s-42i0kc/Deploy.png" width="600">
</p>

<br>

After deploying, visit the url shown in the deployment log in your browser to view the app running on shinyapps.io. Go to the **Architecture Info** tab to confirm that the desired version of Python is being used. For [this tutorial app deployed to shinyapps.io](https://elasticlabs.shinyapps.io/shiny-reticulate-app/), this is Python 3.5.

<br>

#### Deploying to RStudio Connect

Similar to to shinyapps.io deployment, deploying to RStudio Connect requires the `rsconnect` package and an RStudio Connect account. Once again, you'll begin by running the app locally. In RStudio, open the file server.R and click **Run App** to view your app.

Click **Publish** in the upper right and select the RStudio Connect option:

<p align="center">
<img src="https://cdn.brandfolder.io/TLCWDQBL/as/q9j530-1txh7s-24fdpg/RStudio_Connect_screenshot.png" width="600">
</p>

Then, log in using the URL for your RStudio Connect server and click **Publish** in the pop-up window to deploy!

Unlike shinyapps.io, RStudio Connect allows you to set environment variables through the user interface:

<p align="center">
<img src="https://cdn.brandfolder.io/TLCWDQBL/at/q9j6dp-1i9wa0-466e4p/env_vars_rstudio_connect.png" width="600">
</p>

This is a great option, especially for secrets, credentials, API keys, and other sensitive information.

--- 

### Troubleshooting

If you are having issues deploying your app to shinyapps.io, double check that you have completed all steps in the [first-time set-up](#first-time-set-up). Confirm that the .Rprofile file is included in your project's directory. This file sets the `RETICULATE_PYTHON` environment variable, which tells `reticulate` where to locate the Python virtual environment on the shinyapps.io servers.

If you visit the app url on shinyapps.io and see "Disconnected", log in to shinyapps.io and view the application logs for errors.

Some common issues and how to solve them:

**ERROR: The requested version of Python ('/usr/bin/python3') cannot be used, as another version of Python ('/usr/bin/python') has already been initialized.**

When you run `library(reticulate)`, the `reticulate` package will try to initialize a version of Python, which may not be the version that you intend to use. To avoid this, in a fresh session, run set-up commands *without importing the reticulate library* with the :: syntax like this, for example:

```R
reticulate::virtualenv_create(envname = 'example_env_name', 
                              python= '/usr/bin/python3')
```

Similarly, if you're setting the `RETICULATE_PYTHON` variable, you must do so *before* running `library(reticulate)`.

**My app is deployed to shinyapps.io but shows that it's using Python 2.7**

Confirm that the .Rprofile file is included in your project's directory and double check the name of the virtualenv.

To confirm that the virtual environment created is indeed using Python 3.5, you can use the `py_config()` function in the `reticulate` package:

```R
reticulate::py_config()

  python:         /Users/rani/.virtualenvs/example_env_name/bin/python
  libpython:      /Library/Frameworks/Python.framework/Versions/3.5/lib/python3.5/config-3.5m/libpython3.5.dylib
  pythonhome:     /Library/Frameworks/Python.framework/Versions/3.5:/Library/Frameworks/Python.framework/Versions/3.5
  virtualenv:     /Users/rani/.virtualenvs/example_env_name/bin/activate_this.py
  version:        3.5.0 (v3.5.0:374f501f4567, Sep 12 2015, 11:00:19)  [GCC 4.2.1 (Apple Inc. build 5666) (dot 3)]
  numpy:          /Users/rani/.virtualenvs/example_env_name/lib/python3.5/site-packages/numpy
  numpy_version:  1.17.4
  
  NOTE: Python version was forced by use_python function
```

**On shinyapps.io, I see the warning: using reticulate but python was not specified; will use python at /usr/bin/python Did you forget to set the RETICULATE_PYTHON environment variable in your .Rprofile before publishing?**

Confirm that the .Rprofile file is included in your project's directory and was deployed along with server.R and ui.R to shinyapps.io. This file sets the `RETICULATE_PYTHON` environment variable, which tells `reticulate` where to locate the Python virtual environment on the shinyapps.io servers.

--- 

### Still having issues?

For additional information about `reticulate`, check out these resources:

* The `reticulate` [official documentation](https://rstudio.github.io/reticulate/)

* The `reticulate` [repository on Github](https://github.com/rstudio/reticulate)

If you're running into trouble using this demo app, feel free to open an issue and I'll do my best to help! I'll keep adding to the Troubleshooting section as I'm compiling other common issues.

--- 

### Acknowledgements

Big thank you to the RStudio team who developed the `reticulate` package. It's a powerful tool and I've really enjoyed using it :)

And a warm thank you to [@jjallaire](https://github.com/jjallaire) and [@kevinushey](https://github.com/kevinushey) who made [the recent fixes](https://github.com/rstudio/reticulate/issues/399) to `reticulate` that made it possible to use Python 3 virtual environments on shinyapps.io.

