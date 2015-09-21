Clearance.configure do |config|
  config.mailer_sender = "reply@example.com"
  config.sign_in_guards = [ArchivedAccountGuard]
end
