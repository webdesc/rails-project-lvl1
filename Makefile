test:
	rake test
install:
	bundle install
lint:
	rubocop

.PHONY: all test clean
