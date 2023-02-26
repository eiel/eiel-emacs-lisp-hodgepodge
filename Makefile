.PHONY: test
test:
	emacs -batch -L . -l *-tests.el -f ert-run-tests-batch-and-exit
