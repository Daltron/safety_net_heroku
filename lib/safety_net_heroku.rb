require "safety_net_heroku/version"
require "safety_net_heroku/backup_database_worker"

module SafetyNetHeroku
  def self.config
    @config ||= {
      :database_name => nil,
      :aws_region => nil,
      :aws_bucket => nil,
      :aws_backups_directory => nil
    }
  end
end
