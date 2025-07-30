set :environment, ENV['RAILS_ENV']
set :output, 'log/cron.log'

every 1.hour do
    runner "ProductSyncWorker.perform_async"
end