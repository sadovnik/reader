task :worker => :environment do
  # https://github.com/ddollar/foreman/issues/159
  $stdout.sync = true
  sleep_interval = ENV['WORKER_SLEEP_INTERVAL'] || 30

  logger = Logger.new(STDOUT)

  logger.info "Sleep interval is #{sleep_interval} minutes"

  loop do
    logger.info 'Working...'

    begin
      new_posts_count = UpdateSourcesWorker.perform
    rescue StandardError => e
      logger.error 'Got error!'
      logger.error e
    end

    logger.info "Done! Posts added: #{new_posts_count}"

    logger.info 'Sleeping...'

    sleep sleep_interval.minutes
  end
end
