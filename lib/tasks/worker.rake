task :worker => :environment do
  loop do
    puts 'Working...'

    new_posts_count = UpdateSourcesWorker.perform

    puts "Done! Posts added: #{new_posts_count}"

    puts 'Sleeping...'

    sleep 5.minutes
  end
end
