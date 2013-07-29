# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

class Chatroom < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :msgs
  has_one  :last_message, class_name: Msg, readonly: true, order: "created_at DESC LIMIT 1"

  attr_accessible :topic
end
