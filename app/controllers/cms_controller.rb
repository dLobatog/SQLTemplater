class CmsController < ActionController::Metal
  include ActionController::Rendering
  include AbstractController::Helpers
  append_view_path SqlTemplate::Resolver.instance
  helper CmsHelper

  def respond
    render :template => params[:page]
  end
end
