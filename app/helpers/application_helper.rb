module ApplicationHelper
  def current_path_with_clicked?
    params[:clicked] == 'true'
  end
end
