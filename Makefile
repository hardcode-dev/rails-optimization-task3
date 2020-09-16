.PHONY: test

all: test small
test:
	rails test
small:
	rails 'reload_json[fixtures/small.json]'
