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

install: 
	npm install
	mkdir -pv ./.venv
	pipenv install
	pipenv run pip freeze > requirements.txt

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

run-local:
	pipenv run python ./handler.py

.PHONY: usage install-dev install clean deploy invoke run-local