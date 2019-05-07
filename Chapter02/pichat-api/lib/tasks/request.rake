namespace :request do
  desc "Generate example requests"
  task :attachments_create, [:file] => :environment do |task, args|
    message = {
      message_id: 1,
      media_type: 1,
      url: "http://google.com/",
      file_name: File.basename(args.file),
      data: Base64.strict_encode64(open(args.file, 'rb').read)
    }
    puts JSON.pretty_generate(message)
  end
end
