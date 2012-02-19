class Suggestion < ActiveRecord::Base
  attr_accessible :content, :votes
  validates_presence_of :content
  default_scope order("votes desc")
end
