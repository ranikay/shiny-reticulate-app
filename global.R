# Python dependencies ----------------------------------------------------------
req_con <- file("requirements.txt")
py_dep <- readLines(req_con, warn = FALSE)
close(req_con)

# Virtual environment setup ----------------------------------------------------
virtualenv_dir = Sys.getenv('VIRTUALENV_NAME')
python_path = Sys.getenv('PYTHON_PATH')

# Create virtual env and install dependencies
reticulate::virtualenv_create(envname = virtualenv_dir,
                              python = python_path)
reticulate::virtualenv_install(virtualenv_dir,
                               packages = py_dep,
                               ignore_installed = TRUE)
reticulate::use_virtualenv(virtualenv_dir,
                           required = TRUE)