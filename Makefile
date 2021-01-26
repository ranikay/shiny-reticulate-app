ifdef R_HOME
RSCRIPT_PATH = $(R_HOME)/bin/Rscript
else
RSCRIPT_PATH = $(shell which Rscript)
endif

all: manifest.json
	@echo Rebuilt all.

clean:
	@echo Deleting manifest...
	rm -f manifest.json

manifest.json: server.R ui.R requirements.txt python_functions.py
	@echo Creating manifest...
	@echo $(shell $(RSCRIPT_PATH) --version)
	$(RSCRIPT_PATH) -e 'rsconnect::writeManifest(appFiles = c("server.R", "ui.R", "requirements.txt", "python_functions.py"), python = "/opt/python/3.6.5/bin/python")'
