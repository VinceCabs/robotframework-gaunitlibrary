.DEFAULT_GOAL := help
SRC_FILES = ./GAUnitLibrary ./tests ./samples setup.py
MAIN_SRC = GAUnitLibrary
PACKAGE = robotframework-gaunitlibrary

##### Dev

pip-comp: ## Compile requirements files (all layers)
	pip-compile requirements/base.in
	pip-compile requirements/samples.in
	pip-compile requirements/dev.in

pip-up: ## Update requirements files (all layers)
	pip-compile --upgrade requirements/base.in
	pip-compile --upgrade requirements/samples.in
	pip-compile --upgrade requirements/dev.in

install-samples: ## Install samples requirements
	pip install -e .
	pip install -r requirements/samples.txt

install-dev: ## * Install dev requirements
	pip install -e .
	pip install -r requirements/dev.txt

clean-logs:  ## Remove all log & RF report files
	rm *.log log.html output.xml report.html || true

tests : install-dev test-robot test-lint test-format test-package ## Run all tests

test-format: ## Run code formatting tests
	black --check --diff $(SRC_FILES)

test-lint: ## Run code linting tests
	pylint --errors-only ${SRC_FILES}

test-robot:  ## Run RobotFramework library
	robot tests/test_gaunitlibrary.robot

test-package: build-package ## Test that package can be uploaded to pypi
	twine check dist/${PACKAGE}-$(shell make version).tar.gz

format: ## * Format code
	black $(SRC_FILES)

##### Use & Deploy

install-minimal: ## Install minimal usage requirements
	pip install .
	pip install -r requirements/base.txt

build-package:   ## Build a python package ready to upload to pypi
	python setup.py sdist bdist_wheel

push-package: build-package test-package ## * Push python packages to pypi
	python -m twine upload --skip-existing dist/${PACKAGE}-*.tar.gz

release: tests ## * Test, create a release tag and push it to repos (origin and public)
	$(MAKE) retag release-public TAG=v$(shell make version)

retag:
	@echo "=== Creating tag $(TAG)"
	git tag -d $(TAG) || true
	git tag $(TAG)

release-public:
	@echo "=== Pushing tag $(TAG) to public"
	git push public
	git push public :$(TAG) || true
	git push public $(TAG)

###### Additional commands

version: ## Print the current tutor version
	@python -c 'import io, os; about = {}; exec(io.open(os.path.join("${MAIN_SRC}", "__about__.py"), "rt", encoding="utf-8").read(), about); print(about["__version__"])'

ESCAPE = 
help: ## Print this help
	@grep -E '^([a-zA-Z_-]+:.*?## .*|######* .+)$$' Makefile \
		| sed 's/######* \(.*\)/\n               $(ESCAPE)[1;31m\1$(ESCAPE)[0m/g' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-30s\033[0m %s\n", $$1, $$2}'