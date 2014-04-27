LIBS_FOLDER = "./libs"

dependencies:
	curl -Ls -o $(LIBS_FOLDER)/JSON.sh --create-dirs https://github.com/dominictarr/JSON.sh/raw/master/JSON.sh
	curl -Ls -o $(LIBS_FOLDER)/ovh-api-bash-client.sh --create-dirs https://github.com/denouche/ovh-api-bash-client/raw/master/ovh-api-bash-client.sh
	chmod +x $(LIBS_FOLDER)/*

install: dependencies
	$(LIBS_FOLDER)/ovh-api-bash-client.sh --initApp


