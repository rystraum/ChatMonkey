# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

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
