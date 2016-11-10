Griddler.configure do |config|
  config.processor_class = Email::Processor
  config.email_service = :sendgrid
end
