CURDIR := $(shell pwd)
TARGETS := .tmux.conf .gitconfig .gitignore_global .ctags
ORIGDIR := orig
LINKDIR := link

.PHONY: copy
copy:
	@for t in $(TARGETS); do \
		if [[ ! -e $(CURDIR)/$(LINKDIR)/$$t ]]; then \
			cp $(CURDIR)/$(ORIGDIR)/$$t $(CURDIR)/$(LINKDIR); \
			echo "Copy: $(CURDIR)/$(LINKDIR)/$$t"; \
		else \
			echo "Skip: $(CURDIR)/$(LINKDIR)/$$t already exist!"; \
		fi \
	done

.PHONY: clean
clean:
	@for t in $(TARGETS); do \
		if [[ -e $(CURDIR)/$(LINKDIR)/$$t ]]; then \
			if [ -z `diff $(CURDIR)/$(ORIGDIR)/$$t $(CURDIR)/$(LINKDIR)/$$t` ]; then \
				rm $(CURDIR)/$(LINKDIR)/$$t; \
				echo "Remove: $(CURDIR)/$(LINKDIR)/$$t"; \
			else \
				echo "Changes found: $(CURDIR)/$(LINKDIR)/$$t"; \
			fi \
		else \
			echo "No such file: $(CURDIR)/$(LINKDIR)/$$t"; \
		fi \
	done

.PHONY: link
link:
	@for t in $(TARGETS); do\
		ln -s $(CURDIR)/$(LINKDIR)/$$t ~/$$t; \
		echo "Link: ~/$$t --> $(CURDIR)/$(LINKDIR)/$$t"; \
	done

.PHONY: unlink
unlink:
	@for t in $(TARGETS); do\
		unlink ~/$$t; \
		echo "Unlink: ~/$$t -X-> $(CURDIR)/$(LINKDIR)/$$t"; \
	done
