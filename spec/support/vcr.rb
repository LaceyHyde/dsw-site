require "vcr"
require "uri"

driver_hosts = Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }

VCR.configure do |c|
  c.ignore_hosts(*driver_hosts)
  c.cassette_library_dir = "spec/support/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.filter_sensitive_data("<SENDGRID_API_KEY>") { ENV["SENDGRID_API_KEY"] }
  c.filter_sensitive_data("<SENDGRID_LIST_ID>") { ENV["SENDGRID_LIST_ID"] }
  c.filter_sensitive_data("<AWS_ACCESS_KEY_ID>") { ENV["AWS_ACCESS_KEY_ID"] }
  c.filter_sensitive_data("<AWS_SECRET_ACCESS_KEY>") { ENV["AWS_SECRET_ACCESS_KEY"] }
  c.filter_sensitive_data("<HELPSCOUT_DOCS_AUTH_HEADER>") { Base64.strict_encode64("#{ENV["HELPSCOUT_DOCS_KEY"]}:X") }
  c.filter_sensitive_data("<HELPSCOUT_DOCS_COLLECTION_ID>") { ENV["HELPSCOUT_DOCS_COLLECTION_ID"] }
end
