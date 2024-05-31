module ApplicationHelper
  def current_path_with_clicked?
    request.path == root_path && params[:clicked] == 'true'
  end
end
