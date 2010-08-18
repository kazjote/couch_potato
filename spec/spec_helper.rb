require 'rubygems'
require 'spec'

$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'couch_potato'

require 'time'
require 'active_support/core_ext/object/blank.rb'
require 'active_support/core_ext/hash/except.rb'

if ENV["RUN_CODE_RUN"]
  CouchPotato::Config.database_name = 'http://langalex.couch.io/couch_potato_test'
else
  CouchPotato::Config.database_name = 'couch_potato_test'
end


CouchPotato::Config.validation_framework = ENV['VALIDATION_FRAMEWORK'].to_sym unless ENV['VALIDATION_FRAMEWORK'].blank?

# silence deprecation warnings from ActiveModel as the Spec uses Errors#on
begin
  ActiveSupport::Deprecation.silenced = true
rescue
  # ignore errors, ActiveSupport is probably not installed
end

class Child
  include CouchPotato::Persistence

  property :text
end

class Comment
  include CouchPotato::Persistence

  validates_presence_of :title

  property :title
end

def recreate_db
  CouchPotato.couchrest_database.recreate!
end
recreate_db

Spec::Matchers.define :string_matching do |regex|
  match do |string|
    string =~ regex
  end
end
