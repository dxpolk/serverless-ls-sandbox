usage:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install-dev		Install development dependencies"
	@echo "  install		Install dependencies"
	@echo "  clean			Remove dependencies"
	@echo "  deploy			Deploy to AWS"
	@echo "  invoke			Invoke function locally"
	@echo "  run-local		Run function locally"

install-dev: install
	pipenv install --dev
	pipenv requirements --dev > requirements-dev.txt

install: 
	npm install
	mkdir -pv ./.venv
	pipenv install
	pipenv requirements > requirements.txt

clean:
	rm -rf ./.venv
	rm -f ./requirements.txt
	rm -f ./requirements-dev.txt
	rm -f ./Pipfile.lock%
	rm -rf ./node_modules

deploy:
	SLS_DEBUG=1 serverless deploy --stage local

invoke:
	serverless invoke local --function hello --stage local

run-local:
	pipenv run python ./handler.py

.PHONY: usage install-dev install clean deploy invoke run-local