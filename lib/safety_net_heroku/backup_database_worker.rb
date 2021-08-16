require 'sidekiq/web'

module SafetyNetHeroku
  class BackupDatabaseWorker
    include Sidekiq::Worker

    sidekiq_options retry: false

    def perform

      database_name = SafetyNetHeroku.config[:database_name]
      region = SafetyNetHeroku.config[:aws_region]
      bucket = SafetyNetHeroku.config[:aws_bucket]
      backups_directory = SafetyNetHeroku.config[:aws_backups_directory]

      if database_name.nil?
        raise Exception.new 'SafetyNetHeroku.config[:database_name] not set'
      end

      if region.nil?
        raise Exception.new 'SafetyNetHeroku.config[:aws_region] not set'
      end

      if bucket.nil?
        raise Exception.new 'SafetyNetHeroku.config[:aws_bucket] not set'
      end

      if backups_directory.nil?
        raise Exception.new 'SafetyNetHeroku.config[:aws_backups_directory] not set'
      end

      temp_backups_root_directory = "#{Rails.root}/safety_net_heroku"
      temp_backups_directory = "#{temp_backups_root_directory}/database-backups"
      system("mongodump --uri=#{ENV['DB_URI_NO_OPTIONS']} --out=\"#{temp_backups_directory}\"")

      output_file_name = "#{Time.now.to_formatted_s(:long_ordinal).gsub(" ", "-").gsub(",", "")}.zip"
      output_path = "#{temp_backups_directory}/#{output_file_name}"
      system("zip -rj \"#{output_path}\" \"#{temp_backups_directory}/#{database_name}\"")

      s3 = Aws::S3::Resource.new(region: region)
      obj = s3.bucket(bucket).object("#{backups_directory}/#{output_file_name}")
      obj.upload_file(output_path)

      system("rm -r \"#{temp_backups_root_directory}\"")
    end

  end
end
