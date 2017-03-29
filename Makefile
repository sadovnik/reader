start:
	bundle exec rails server

console:
	bundle exec rails console

migrate:
	bundle exec rails db:migrate

install:
	bundle install

test:
	bundle exec rake spec
