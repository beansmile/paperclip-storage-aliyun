require "active_record"
require "nulldb"
require "paperclip"

class Post < ActiveRecord::Base
  include Paperclip::Glue

  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment
end

RSpec.configure do |config|
  config.before(:all) do
    FileUtils.mkdir_p File.join(Bundler.root, "tmp")
    ActiveRecord::Base.establish_connection(
      adapter: "nulldb",
      schema: File.join(Bundler.root, "spec/fixtures/schema.rb"),
    )
  end

  config.after(:all) do
    ActiveRecord::Base.remove_connection
  end
end
