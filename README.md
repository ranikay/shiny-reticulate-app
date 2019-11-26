## Tutorial: using Shiny + reticulate to create apps with R and Python 3

Live version deployed to shinyapps.io and using Python 3 can be seen [here](https://elasticlabs.shinyapps.io/shiny-reticulate-app/)!

### Demo Shiny app using the `reticulate` package

The `reticulate` package from RStudio allows you to incorporate Python functions and scripts into your R code. This demo app is intended to demonstrate how to use `reticulate` in an app that can be deployed to shinyapps.io. This example uses Python 3 but can be modified for Python 2, if desired.


**Requirements:**

- Python >= 3.5

  - [virtualenv](https://virtualenv.pypa.io/en/stable/) >= 16.7.5
  
  - [numpy](https://numpy.org/) >= 1.8.0

- R >= 3.6

  - [RStudio](https://rstudio.com/products/rstudio/) >= 1.2.1335
  
  - [reticulate](https://rstudio.github.io/reticulate/) >= 1.13.0-9004  (**Note**: this version is currently under development. To install it, run `remotes::install_github("rstudio/reticulate", force = T, ref = '967a9a750e2f2e8ca61a9fe9fc3616bc63f97399')` in the R console)
  
  - [shiny](https://cran.r-project.org/web/packages/shiny/index.html) >= 1.3.2
  
  - [DT](https://cran.r-project.org/web/packages/DT/index.html) >= 0.9
  
  - [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/) >= 1.1-2
  

**Set up:**

- In a terminal, clone this project:

  ```
  $ git clone https://github.com/ranikay/shiny-reticulate-app.git <DESTINATION/PATH>
  ```

- Now we'll move into R. Open RStudio by double-clicking the included project file (`shiny-reticulate-app.Rproj`).

- Create a Python 3 virtualenv and install `numpy` into it. In the console:

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
  
- In RStudio, open the file server.R and click Run App to view your app!

<img src="https://cdn.brandfolder.io/TLCWDQBL/as/q1jwwt-3fnhuw-5qoay7/shiny-reticulate-app_screenshot_run_app.png" width="400">

