# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

class Msg < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  attr_accessible :message

  delegate :id, to: :user, prefix: true, allow_nil: true

  default_scope includes(:chatroom, :user)

  def as_json(options={})
    super.merge({
      created_at_in_iso: created_at_in_iso,
      created_at_in_local: created_at_in_local,
      user: user.as_json
    })
  end

  def created_at_in_local
    return created_at.in_time_zone 8
  end

  def created_at_in_iso
    return created_at.iso8601
  end

  def to_s
    return message
  end
end

