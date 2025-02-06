include make-compose.mk
include make-services-app.mk

test:
	bin/rails test


backend:
	rm -rf tmp/pids/server.pid
	bundle exec rails s -p 3000 -b '0.0.0.0'

setup:
	make setup-app

setup-app:
	cp -n .env.example .env || true
	bin/setup

fixtures-load:
	bin/rake utils:reload_json[fixtures/small.json]

clean:
	bin/rails db:drop

console:
	bin/rails c

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:schema:load
	bin/rails db:migrate
	bin/rake reload_json[fixtures/small.json]
	bin/rails log:clear tmp:clear
	bin/rails restart

start:
	bin/rails s

lint: lint-code lint-style

linter-code-fix:
	bundle exec rubocop -A

test:
	bundle exec rspec

.PHONY: test