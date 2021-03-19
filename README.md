A simple gem for backing up a MongoDB database to AWS when hosted on Heroku using a Sidekiq worker.

## Installation

```ruby
gem 'safety_net_heroku'
```

## Usage

Add this buildpack to your Heroku setup: `http://github.com/uhray/heroku-buildpack-mongo.git`

Ensure this environment variable is set within Heroku: 

```ruby
ENV['DB_URI_NO_OPTIONS']
```

Create a new Safety Net Heroku initializer:

```ruby
# safety_net_heroku.rb

SafetyNetHeroku.config[:database_name] = 'database_name'
SafetyNetHeroku.config[:aws_region] = 's3_region'
SafetyNetHeroku.config[:aws_bucket] = 's3_bucket'
SafetyNetHeroku.config[:aws_backups_directory] = s3_directory'

```

Add the worker to your sidekiq schedule as a cron job:

```ruby
# sidekiq_schedule.yml

backup_database:
  cron: "0 3 * * *"
  class: "SafetyNetHeroku::BackupDatabaseWorker"
```

#### Your database will now be backed up to the AWS directory specified periodically based on your cron settings! 🎉

## Author

Dalton Hinterscher, daltonhint4@gmail.com

## License

Safety Net Heroku is available under the MIT license. See the LICENSE file for more info.
