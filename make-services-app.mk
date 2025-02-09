app-bash:
	docker-compose run --rm app bash

app-install-bundle:
	docker-compose run --rm app bundle install --jobs $(shell nproc)

app-update: app-update-bundle

app-update-bundle:
	docker-compose run --rm app bundle update --jobs $(shell nproc)

app-debug:
	docker attach --sig-proxy=false --detach-keys="ctrl-c" $(shell docker ps -q --filter publish=3000)

app-rails-console:
	docker-compose run --rm app make console

app-rails:
	docker-compose run --rm app bin/rails $(T)

app-make:
	docker-compose run --rm app make $(T)

app-test:
	docker-compose run --rm app make test

app-fixtures-load:
	docker-compose run --rm app make fixtures-load

app-benchmark:
	docker-compose run --rm app lib/benchmark.rb $(T)

app-benchmark-small:
	make app-benchmark T='small'

app-benchmark-medium:
	make app-benchmark T='medium'

app-benchmark-large:
	make app-benchmark T='large'

app-report:
	docker-compose run --rm app bin/rake reports:build[$(T)]

