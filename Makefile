reload_example:
	bundle exec rake reload_json[fixtures/example.json]
reload_large:
	bundle exec rake reload_json[fixtures/large.json]
reload_medium:
	bundle exec rake reload_json[fixtures/medium.json]
reload_small:
	bundle exec rake reload_json[fixtures/small.json]

open:
	open http://localhost:3000/автобусы/Самара/Москва
pghero:
	open http://localhost:3000/pghero