DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

#
# BUILD CUSTOM ALLPLAYERS BOOTSTRAP
#

default:
	mkdir -p vendor
	cd vendor; git clone https://github.com/twitter/bootstrap.git
	cd vendor/bootstrap; git clone https://github.com/AllPlayers/allplayers-theme.git bootstrap
	# patch bootstrap to inject overrides.less
	cd vendor/bootstrap; git apply ../../bootstrap.patch
	cd vendor/bootstrap; make bootstrap
	# TODO: cd vendor/bootstrap/bootstrap; git add .; git commit $DATEBUILD

.DEFAULT_GOAL := default
.PHONY: test
