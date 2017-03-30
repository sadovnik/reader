start:
	bundle exec rails server

console:
	bundle exec rails console

migrate:
	bundle exec rails db:migrate

rollback:
	bundle exec rails db:rollback

install:
	bundle install

test:
	bundle exec rake spec
