app-bash:
	docker-compose run --rm app bash

app-install-bundle:
	docker-compose run --rm app bundle install --jobs $(shell nproc)

app-update: app-update-bundle

app-update-bundle:
	docker-compose run --rm app bundle update --jobs $(shell nproc)

app-debug:
	docker attach --sig-proxy=false --detach-keys="ctrl-c" $(shell docker ps -q --filter publish=3000)

app-lint:
	docker-compose run --rm app make lint

app-lint-fix:
	docker-compose run --rm app make linter-code-fix

app-rails-console:
	docker-compose run --rm app make console

app-test:
	docker-compose run --rm app make test

app-rails:
	docker-compose run --rm app bin/rails $(T)

app-make:
	docker-compose run --rm app make $(T)

app-test:
	docker-compose run --rm app make test

app-fixtures-load:
	docker-compose run --rm app make fixtures-load

