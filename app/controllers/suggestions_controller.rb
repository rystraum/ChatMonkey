class SuggestionsController < InheritedResources::Base
  respond_to :html, :js

  def create
    create! { suggestions_url }
  end

end
