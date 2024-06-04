class ComingSoonController < ApplicationController
  def index_jobs
  end

  def index_versioning
  end

  def index_deploy
  end

  def index_messages
  end

  def landing_page
    redirect_to marketplace_root_path if user_signed_in? && !params[:clicked].present?
  end
end
