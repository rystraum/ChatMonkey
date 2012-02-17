class PagesController < ApplicationController
  def home
    s = ""; IO.readlines(Rails.root.join("CHANGELOG.md")).each {|l| s += l }
    @changelog = s.truncate(1000)
  end
end
