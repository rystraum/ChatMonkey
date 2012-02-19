class Suggestion < ActiveRecord::Base
  attr_accessible :content, :votes
  default_scope order("votes desc")
end
