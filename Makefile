.PHONY: test

all: test small
test:
	rails test
example:
	rails 'reload_json[fixtures/example.json]'
small:
	rails 'reload_json[fixtures/small.json]'
medium:
	rails 'reload_json[fixtures/medium.json]'
large:
	rails 'reload_json[fixtures/large.json]'
one_by_one: example small medium large
stream:
	rails reload_json_stream
