class Panelist < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:name, :affiliation]

  has_and_belongs_to_many :events
end