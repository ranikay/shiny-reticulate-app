## Tutorial: using Shiny + reticulate to create apps with R and Python 3

<br> 

The `reticulate` package from RStudio allows you to incorporate Python functions and scripts into your R code. Inspired by the many questions online around writing and deploying Shiny apps that use the `reticulate` package, I created this app as an end-to-end example.

#### In this tutorial, you will learn:

1. How to configure reticulate virtual environments for use locally and on shinyapps.io. (This example uses Python 3 but can be modified for Python 2, if desired.)

2. How to deploy a Shiny + reticulate app to shinyapps.io

3. How to confirm that your app deployed on shinyapps.io is using the desired version of Python

---

### About the demo app

**See it in action:** A live version deployed to shinyapps.io and using Python 3 can be seen [here](https://elasticlabs.shinyapps.io/shiny-reticulate-app/)!

The demo app example contains two tabs. The first tab demonstrates some R and Python functions being used to make a plot and print some text. The second tab displays a table summarizing the architecture information for the machine running the app.

<br>

<center><img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1swmp-cclfzk-351qtl/Two_tab_video.gif" width="800"></center>

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

  ```
  $ git clone https://github.com/ranikay/shiny-reticulate-app.git>
  $ cd shiny-reticulate-app/
  ```

Install Python and the required packages:

- Python >= 3.5

- Python packages: [virtualenv](https://virtualenv.pypa.io/en/stable/) and [numpy](https://numpy.org/)

  To install Python packages, in a terminal, run:

  ```
  $ pip install virtualenv
  $ pip install numpy
  ```
  
Install R and the required packages:

- R >= 3.6

- [RStudio](https://rstudio.com/products/rstudio/)

- R packages: [shiny](https://cran.r-project.org/web/packages/shiny/index.html), [DT](https://cran.r-project.org/web/packages/DT/index.html), [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/)

  To install the above packages, in the R console, run:

  ```
  > install.packages(shiny)
  > install.packages(DT)
  > install.packages(RColorBrewer)
  ```
  
- The R package [reticulate](https://rstudio.github.io/reticulate/). **Important notes**: the RStudio team has made some changes to `reticulate` recently, including [changes that enable Python 3 virtual environments on shinyapps.io](https://github.com/rstudio/reticulate/issues/399). Therefore, **you must currently use the development version of reticulate in order to deploy an app using Python 3 to shinyapps.io**. To install it, in the R console, run:

  ```
  remotes::install_github("rstudio/reticulate", force = T, ref = '967a9a750e2f2e8ca61a9fe9fc3616bc63f97399')
  ```

- The R package [shinycssloaders](). To install, in the R console, run:

  ```
  devtools::install_github('andrewsali/shinycssloaders')
  ```

<br>

#### Setting up the local virtual environment

- Now we'll move into RStudio. To open the project in RStudio, in the terminal, run: 

  ```
  $ open shiny-reticulate-app.Rproj
  ```

- In RStudio, we'll use the `reticulate` package to create a Python 3 virtualenv and install `numpy` into it. In the R console:

  ```
  > reticulate::virtualenv_create(envname = 'python35_env', 
                                  python= '/usr/bin/python3')
  
  Creating virtual environment 'python35_env' ...
  Using python: python3
  ...[more output]
  
  > reticulate::virtualenv_install('python35_env', 
                                   packages = c('numpy'))  # <- Add other packages here, if needed
                                   
  Using virtual environment 'python35_env' ...
  Collecting numpy
  ...[more output]
  Installing collected packages: numpy
  Successfully installed numpy-1.17.4
  ```
  
That's it for set-up! Now we're ready to run the app locally.

---

### Running and deploying

#### Running the app locally

In RStudio, open the file server.R and click **Run App** to view your app.

<center><img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1jwwt-3fnhuw-5qoay7/shiny-reticulate-app_screenshot_run_app.png" width="600"></center>

<br>

For the Python functionality demonstrated on the first tab of the app, the app is using the virtual environment that we configured in the [Setting up the local virtual environment](#setting-up-the-local-virtual-environment) section. The app knows to use this virtual environment based on line 16 in server.R:  `reticulate::use_virtualenv('python35_env', required = T)`

While running the app, we can click on the **Architecture Info** tab to confirm that the app is using the correct version of Python.

<br>

#### Deploying to shinyapps.io

Deploying your app to shinyapps.io requires the `rsconnect` package and a shinyapps.io account. If you haven't deployed an app to shinyapps.io before, instructions for creating an account and configuring `rsconnect` can be found [here](https://docs.rstudio.com/shinyapps.io/getting-started.html).

Begin by running the app locally. In RStudio, open the file server.R and click **Run App** to view your app.

Click **Publish** in the upper right, confirm that the shinyapps.io account information is correct and name your app. Then click **Publish** in the pop-up window to send your app to the shinyapps.io cloud servers.

<center><img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1sz52-ahuy0o-4mm0t0/Publish.png" width="600"></center>

A successful deploy will produce a deployment log similar to this in the "Deploy" window in RStudio:

<center><img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1szho-9873s-42i0kc/Deploy.png" width="600"></center>

<br>

After deploying, visit the url shown in the deployment log in your browser to view the app running on shinyapps.io. Go to the **Architecture Info** tab to confirm that the desired version of Python is being used. For [this tutorial app deployed to shinyapps.io](https://elasticlabs.shinyapps.io/shiny-reticulate-app/), this is Python 3.5.

--- 

### Troubleshooting

Some common issues and how to solve them:

**My app is deployed to shinyapps.io but shows that it's using Python 2.7**

**TODO Another issue**
