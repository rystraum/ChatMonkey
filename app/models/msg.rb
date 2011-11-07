class Msg < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  attr_accessible :message
end
