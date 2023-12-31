# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pagy::Backend

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

  def after_sign_up_path_for(resource)
    flash[:notice] = "登録が完了しました"
    user_path(resource)
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when User
      flash[:notice] = "ログインしました"
      user_path(resource)
    end
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end

end
