# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

class PagesController < ApplicationController
  def home
    s = ""; IO.readlines(Rails.root.join("CHANGELOG.md")).each {|l| s += l }
    @changelog = s.truncate(1000)
  end
end
