install-dev: install
	pipenv install --dev

install: 
	mkdir -pv ./.venv
	pipenv install

clean:
	rm -rf ./.venv
	rm -f ./requirements.txt
	rm -f ./requirements-dev.txt
	rm -f ./Pipfile.lock%

deploy:
	SLS_DEBUG=1 serverless deploy --stage local
