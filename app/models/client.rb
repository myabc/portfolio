class Client < ActiveRecord::Base
  #def self.table_name_prefix() "pf_" end
  #def self.primary_key() "client_id" end
  has_many :projects
  validates_presence_of( :name, :short_name )
  validates_uniqueness_of( :short_name )
end