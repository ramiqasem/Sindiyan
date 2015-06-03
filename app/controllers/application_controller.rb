class ApplicationController < ActionController::Base
  after_filter :flash_to_headers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    include SessionsHelper

    def flash_to_headers
      return unless request.xhr?
      response.headers['X-Message'] = flash[:error]  unless flash[:error].blank?
      response.headers['X-Message'] = flash[:success]  unless flash[:success].blank?
      response.headers['X-Message'] = flash[:warning]  unless flash[:warning].blank?
      response.headers['X-Message'] = flash[:info]  unless flash[:info].blank?
      # repeat for other flash types...

      flash.discard
    end

private

def logged_in_user
    unless logged_in?
        store_location
        flash[:danger]="Please Login to view this page"
        redirect_to login_url
    end
  end

end
