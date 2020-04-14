library(shiny)
library(DT)
library(RColorBrewer)

plot_cols <- brewer.pal(11, 'Spectral')

shinyServer(function(input, output) {
  
  if (Sys.info()[['sysname']] != 'Darwin'){
    
    # When running on Linux, create a virtualenv 
    reticulate::virtualenv_create(envname = '/tmp/python3_env', 
                                  python = '/usr/bin/python3')
    reticulate::virtualenv_install('/tmp/python3_env', 
                                   packages = c('numpy'))
    reticulate::use_virtualenv('/tmp/python3_env', required = T)
  } else{
    
    # Running locally, use the already created virtualenv
    reticulate::use_virtualenv('python35_env', required = T)
  }
  
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
    return(datatable(df, rownames = F, selection = 'none',
                     style = 'bootstrap', filter = 'none', options = list(dom = 't')))
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