usage:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  install     - install dependencies"
	@echo "  install-dev - install dependencies for development"
	@echo "  clean       - clean up"
	@echo "  deploy      - deploy to AWS"
	@echo "  invoke      - invoke function locally"

install-dev: install
	pipenv install --dev

install: 
	npm install
	mkdir -pv ./.venv
	pipenv install

clean:
	rm -rf ./.venv
	rm -f ./requirements.txt
	rm -f ./requirements-dev.txt
	rm -f ./Pipfile.lock%
	rm -f ./node_modules

deploy:
	SLS_DEBUG=1 serverless deploy --stage local

invoke:
	serverless invoke local --function hello --stage local

invoke-local:
	pipenv run python ./handler.py

.PHONY: install install-dev clean deploy invoke