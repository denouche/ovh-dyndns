LIBS_FOLDER = "./libs"

install:
	curl -Ls -o $(LIBS_FOLDER)/JSON.sh --create-dirs https://github.com/dominictarr/JSON.sh/raw/master/JSON.sh
	curl -Ls -o $(LIBS_FOLDER)/ovhApiBashClient.sh --create-dirs https://github.com/Denouche/ovhApiBashClient/raw/master/ovhApiBashClient.sh
	chmod +x $(LIBS_FOLDER)/*
	$(LIBS_FOLDER)/ovhApiBashClient.sh --initApp


