class SuggestionsController < InheritedResources::Base
  respond_to :html, :js

  def create
    create! { suggestions_path }
  end

  def vote
    resource.votes += 1
    if resource.save
      redirect_to suggestions_path, flash: { success: "Thanks for voting!" }
    else
      redirect_to suggestions_path, flash: { error: "OHNO!" }
    end
  end
end
