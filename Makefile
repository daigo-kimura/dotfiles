CURDIR := $(shell pwd)
TARGETS := .tmux.conf .gitconfig

.PHONY: all
all:
	@for t in $(TARGETS); do\
		ln -s $(CURDIR)/$$t ~/$$t;\
	done

.PHONY: clean
clean:
	@for t in $(TARGETS); do\
		unlink ~/$$t; \
	done
