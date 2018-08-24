web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
sidekiq: bundle exec sidekiq -v -c 3 -q default -q mailers
