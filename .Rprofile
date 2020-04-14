# -------------------------------- Settings --------------------------------- #
if (!Sys.info()[['sysname']] == 'Darwin'){
  
  # If running on Linux, set the RETICULATE_PYTHON evironment variable to tmp
  Sys.setenv(RETICULATE_PYTHON = '/tmp/python3_env/bin/python3')
  
  # Set local debug to false
  Sys.setenv(DEBUG = FALSE)
  
} else{
  # Running locally,
  options(shiny.port = 7450)
  Sys.setenv(DEBUG = TRUE)
}
