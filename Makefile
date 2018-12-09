CURDIR := $(shell pwd)
TARGETS := .tmux.conf .gitconfig
ORIGDIR := orig
LINKDIR := link

.PHONY: copy
copy:
	@for t in $(TARGETS); do \
		if [[ ! -e $(CURDIR)/$(LINKDIR)/$$t ]]; then \
			cp $(CURDIR)/$(ORIGDIR)/$$t $(CURDIR)/$(LINKDIR); \
		else \
			echo Skip copy: $(CURDIR)/$(LINKDIR)/$$t already exist!; \
		fi \
	done

.PHONY: clean
clean:
	@for t in $(TARGETS); do \
		if [[ -e $(CURDIR)/$(LINKDIR)/$$t ]]; then \
			if [ -z `diff $(CURDIR)/$(ORIGDIR)/$$t $(CURDIR)/$(LINKDIR)/$$t` ]; then \
				rm $(CURDIR)/$(LINKDIR)/$$t; \
			else \
				echo Changes found: $(CURDIR)/$(LINKDIR)/$$t; \
			fi \
		else \
			echo No such file: $(CURDIR)/$(LINKDIR)/$$t; \
		fi \
	done

.PHONY: link
link:
	@for t in $(TARGETS); do\
		ln -s $(CURDIR)/$(LINKDIR)/$$t ~/$$t; \
	done

.PHONY: unlink
unlink:
	@for t in $(TARGETS); do\
		unlink ~/$$t; \
	done
