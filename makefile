setup:
	@docker compose build
	@docker compose up -d
	@docker compose exec app bundle exec rake db:migrate

start:
	@docker compose up -d

stop:
	@docker compose down

bash:
	@docker compose exec app sh

logs:
	@docker compose logs -f --tail=0 app
