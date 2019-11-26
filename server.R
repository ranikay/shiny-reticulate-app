library(shiny)
library(DT)
library(RColorBrewer)

plot_cols <- brewer.pal(11, 'Spectral')

shinyServer(function(input, output) {
  
  if (!Sys.info()[['sysname']] == 'Darwin'){
    # When running on shinyapps.io, create a virtualenv 
    reticulate::virtualenv_create(envname = 'python35_env', 
                                  python = '/usr/bin/python3')
    reticulate::virtualenv_install('python35_env', 
                                   packages = c('numpy'))  # <- Add other packages here, if needed
  }
  reticulate::use_virtualenv('python35_env', required = TRUE)
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
                col = plot_cols))
  })
  
  # Testing that the Python functions have been imported
  output$message <- renderText({
    return(test_string_function(input$str))
  })
  
  # Testing that numpy function can be used
  output$xy <- renderText({
    z = test_numpy_function(input$x, input$y)
    return(paste0('x + y = ', z))
  })
  
  # Display info about the system running the code
  output$sysinfo <- DT::renderDataTable({
    s = Sys.info()
    df = data.frame(Info_Field = names(s),
                    Current_System_Setting = as.character(s))
  })
  
  # Display system path to python
  output$which_python <- renderText({
    paste0('which python: ', Sys.which('python'))
  })
  
  # Python version
  output$python_version <- renderText({
    rr = reticulate::py_discover_config(use_environment = 'python35_env')
    paste0('Python version: ', rr$version)
  })
  
  # Display RETICULATE_PYTHON
  output$ret_env_var <- renderText({
    paste0('RETICULATE_PYTHON: ', Sys.getenv('RETICULATE_PYTHON'))
  })
  
})