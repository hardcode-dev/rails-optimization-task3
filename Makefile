task:
	bundle exec rake reload_json[fixtures/large.json]

test:
	bundle exec rails test

.PHONY:	test
