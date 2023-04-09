SHELL = /bin/bash
PHP_COVERAGE_MODE = -d zend_extension=xdebug.so -d xdebug.mode=coverage

.PHONY: help install build lint cs analyse test testdox coverage

help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#' Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

install: # Install dependencies.
	@composer validate --strict
	@composer install
	@git_install_hooks

build: lint analyse test coverage # Build and test application.

lint: # Fix coding standards violations.
	@php vendor/bin/php-cs-fixer fix

cs: lint # \033[33mAlias\033[00m for \033[1;32mlint\033[00m recipe.

analyse: # Analyze code quality.
	@php vendor/bin/phpstan analyse

test: # Run application tests.
	@php vendor/bin/phpunit --colors -v

testdox: # Run application tests in TestDox format.
	@php vendor/bin/phpunit --colors --testdox

coverage: # Generate code coverage report in HTML format.
	@php ${PHP_COVERAGE_MODE} vendor/bin/phpunit -v --coverage-html=.phpunit/coverage-html --colors --display-incomplete --display-skipped --display-deprecations --display-errors --display-notices --display-warnings
