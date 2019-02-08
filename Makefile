#######################################################
# DO NOT EDIT THIS FILE!                              #
#                                                     #
# It's auto-generated by symfony-cmf/dev-kit package. #
#######################################################

############################################################################
# This file is part of the Symfony CMF package.                            #
#                                                                          #
# (c) 2011-2017 Symfony CMF                                                #
#                                                                          #
# For the full copyright and license information, please view the LICENSE  #
# file that was distributed with this source code.                         #
############################################################################

TESTING_SCRIPTS_DIR=vendor/symfony-cmf/testing/bin
CONSOLE=${TESTING_SCRIPTS_DIR}/console
VERSION=dev-master
ifdef BRANCH
	VERSION=dev-${BRANCH}
endif
PACKAGE=symfony-cmf/routing-bundle
HAS_XDEBUG=$(shell php --modules|grep --quiet xdebug;echo $$?)

list:
	@echo 'test:                    will run all tests'
	@echo 'unit_tests:               will run unit tests only'
	@echo 'functional_tests_phpcr:  will run functional tests with PHPCR'
	@echo 'functional_tests_orm:    will run functional tests with ORM'
	@echo 'test_installation:    will run installation test'
EXTRA_INCLUDES:=$(wildcard ${TESTING_SCRIPTS_DIR}/make/unit_tests.mk)
ifneq ($(strip $(EXTRA_INCLUDES)),)
  contents :=  $(shell echo including extra rules $(EXTRA_INCLUDES))
  include $(EXTRA_INCLUDES)
endif
EXTRA_INCLUDES:=$(wildcard ${TESTING_SCRIPTS_DIR}/make/functional_tests_phpcr.mk)
ifneq ($(strip $(EXTRA_INCLUDES)),)
  contents :=  $(shell echo including extra rules $(EXTRA_INCLUDES))
  include $(EXTRA_INCLUDES)
endif
EXTRA_INCLUDES:=$(wildcard ${TESTING_SCRIPTS_DIR}/make/functional_tests_orm.mk)
ifneq ($(strip $(EXTRA_INCLUDES)),)
  contents :=  $(shell echo including extra rules $(EXTRA_INCLUDES))
  include $(EXTRA_INCLUDES)
endif
EXTRA_INCLUDES:=$(wildcard ${TESTING_SCRIPTS_DIR}/make/test_installation.mk)
ifneq ($(strip $(EXTRA_INCLUDES)),)
  contents :=  $(shell echo including extra rules $(EXTRA_INCLUDES))
  include $(EXTRA_INCLUDES)
endif

.PHONY: test
test: build/xdebug-filter.php  unit_tests functional_tests_phpcr functional_tests_orm
lint-php:
	php-cs-fixer fix --ansi --verbose --diff --dry-run
.PHONY: lint-php

int: lint-composer lint-php
.PHONY: lint

lint-composer:
	composer validate
.PHONY: lint-composer

cs-fix: cs-fix-php
.PHONY: cs-fix

cs-fix-php:
	php-cs-fixer fix --verbose
.PHONY: cs-fix-php

build:
	mkdir $@

build/xdebug-filter.php: phpunit.xml.dist build
ifeq ($(HAS_XDEBUG), 0)
	phpunit --dump-xdebug-filter $@
endif
