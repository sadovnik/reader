task :worker => :environment do
  # https://github.com/ddollar/foreman/issues/159
  $stdout.sync = true

  logger = Logger.new(STDOUT)

  loop do
    logger.info 'Working...'

    new_posts_count = UpdateSourcesWorker.perform

    logger.info "Done! Posts added: #{new_posts_count}"

    logger.info 'Sleeping...'

    sleep 30.minutes
  end
end
