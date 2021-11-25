test:
	rake test
install:
	bundle install
lint:
	rubocop
lint!:
	rubocop -a

.PHONY: all test clean
