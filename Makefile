DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#
SHA=$(shell git rev-parse HEAD)

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

#
# COMMIT CUSTOM ALLPLAYERS BOOTSTRAP TO gh-pages
#

commitpages:
	@echo "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
	@echo "-----BEGIN RSA PRIVATE KEY-----" >> ~/.ssh/id_rsa
	@for i in $(shell seq 0 24); do eval echo "\$$IDRSA_PRIV_ENV$$i" >> ~/.ssh/id_rsa; done
	@echo "-----END RSA PRIVATE KEY-----" >> ~/.ssh/id_rsa
	@chmod 0600 ~/.ssh/id_rsa
	cd vendor/bootstrap/bootstrap; git remote add ap git@github.com:AllPlayers/allplayers-theme.git; git fetch ap; \
	git add .; \
	git commit -m "Automated build ${DATE}: ${SHA}"; git --no-pager log -n3; \
	git push ap gh-pages;


.DEFAULT_GOAL := default
.PHONY: test default commitpages
