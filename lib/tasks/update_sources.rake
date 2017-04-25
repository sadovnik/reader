task :update_sources => :environment do
  # https://github.com/ddollar/foreman/issues/159
  $stdout.sync = true

  logger = Logger.new(STDOUT)
  new_posts_count = UpdateSourcesWorker.new.perform
  logger.info "Posts added: #{new_posts_count}"
end
