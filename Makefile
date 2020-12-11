# dotfiles Makefile
.ONESHELL:
SHELL:=/bin/bash

validate:
	@[[ -z $$NAME ]]  && echo 'export  NAME=<user>' &&  exit 1 || echo   NAME=$(NAME)
	@[[ -z $$EMAIL ]] && echo 'export EMAIL=<email>' && exit 1 || echo  EMAIL=$(EMAIL)

gitconfig: validate
	@cat templates/gitconfig | sed -e 's/NAME/"$(NAME)"/g' -e 's/EMAIL/"$(EMAIL)"/g' > home/.gitconfig

install-tools:
	@sudo apt-get install -yq python3 python3-pip python3-setuptools
	@sudo pip install ansible-base
	@ansible-galaxy collection install community.general
	# @sudo easy_install pip

all: gitconfig install-tools
	@ansible-playbook -i ansible/hosts ansible/setup-dotfiles.yml --ask-become-pass