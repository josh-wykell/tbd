module ApplicationHelper
  def render_comments(commentable, nested = false)
    render :partial => 'comments/index', :locals => { :commentable => commentable, :nested => nested }
  end
end
