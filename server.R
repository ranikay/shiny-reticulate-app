# Import R packages needed for the app here:
library(shiny)
library(DT)
library(RColorBrewer)

# Define any Python packages needed for the app here:
PYTHON_DEPENDENCIES = c('numpy')

# Begin app server
shinyServer(function(input, output) {
  
  # ------------------ App virtualenv setup (Do not edit) ------------------- #
  
  virtualenv_dir = Sys.getenv('VIRTUALENV_NAME')
  
  # Create virtual env and install dependencies
  tryCatch(
    reticulate::install_miniconda(),
    error = function(e) message("Miniconda is already installed. Continuing ...")
  )

  tryCatch(
    expr = reticulate::conda_python(envname = virtualenv_dir),
    error = function(e) { reticulate::conda_create(envname = virtualenv_dir) }
  )

  reticulate::conda_install(virtualenv_dir, packages = PYTHON_DEPENDENCIES, ignore_installed=TRUE)
  reticulate::use_miniconda(virtualenv_dir, required = T)
  
  # ------------------ App server logic (Edit anything below) --------------- #
  
  plot_cols <- brewer.pal(11, 'Spectral')
  
  # Import python functions to R
  reticulate::source_python('python_functions.py')
  
  # Generate the requested distribution
  d <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    
    return(dist(input$n))
  })
  
  # Generate a plot of the data
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    
    return(hist(d(),
                main = paste0('Distribution plot: ', dist, '(n = ', n, ')'),
                xlab = '',
                col = plot_cols))
  })
  
  # Test that the Python functions have been imported
  output$message <- renderText({
    return(test_string_function(input$str))
  })
  
  # Test that numpy function can be used
  output$xy <- renderText({
    z = test_numpy_function(input$x, input$y)
    return(paste0('x + y = ', z))
  })
  
  # Display info about the system running the code
  output$sysinfo <- DT::renderDataTable({
    s = Sys.info()
    df = data.frame(Info_Field = names(s),
                    Current_System_Setting = as.character(s))
    return(datatable(df, rownames = F, selection = 'none',
                     style = 'bootstrap', filter = 'none', options = list(dom = 't')))
  })
  
  # Display system path to python
  output$which_python <- renderText({
    paste0('which python: ', reticulate::conda_python(envname = virtualenv_dir))
  })
  
  # Display Python version
  output$python_version <- renderText({
    rr = reticulate::py_discover_config(use_environment = virtualenv_dir)
    paste0('Python version: ', rr$version)
  })
  
  # Display RETICULATE_PYTHON
  output$ret_env_var <- renderText({
    paste0('RETICULATE_PYTHON: ', Sys.getenv('RETICULATE_PYTHON'))
  })
  
  # Display virtualenv root
  output$venv_root <- renderText({
    paste0('condaenv root: ', reticulate::miniconda_path(), "/", virtualenv_dir)
  })
  
})
