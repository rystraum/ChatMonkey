class Msg < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  attr_accessible :message

  def created_at_in_local
    return self.created_at.in_time_zone 8
  end

  def created_at_in_iso
    return self.created_at.iso8601
  end
end
