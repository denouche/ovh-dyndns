LIBS_FOLDER = "./libs"

dependencies:
	curl -Ls -o $(LIBS_FOLDER)/JSON.sh --create-dirs https://github.com/dominictarr/JSON.sh/raw/master/JSON.sh
	chmod +x $(LIBS_FOLDER)/JSON.sh
	curl -Ls -o ovh-api-bash-client.sh https://github.com/denouche/ovh-api-bash-client/raw/master/ovh-api-bash-client.sh
	chmod +x ovh-api-bash-client.sh

install: dependencies
	./ovh-api-bash-client.sh --initApp


