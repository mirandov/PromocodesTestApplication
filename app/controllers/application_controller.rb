class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :check_app_auth

  private
  ## Выбор текущей роли и проверка прав доступа для неё у данного пользователя
  def check_app_auth()
    if current_user.nil?
      redirect_to(login_path(), notice: flash[:notice])
    else
      @current_user_object = current_user
      @current_user_login = @current_user_object.email

      @current_role_user = params[:user_role_id]
      @current_role_user = session[:user_role_id] if @current_role_user.nil?
      if @current_role_user.nil?
        @current_role_user = @current_user_object.role_users.first
      else
        @current_role_user = RoleUser.find(@current_role_user)
        unless @current_user_object.role_users.include?(@current_role_user)
          @current_role_user = @current_user_object.role_users.first
        end
      end
      # Сохраняем в сессию, чтобы данная роль была выбрана и дальше
      unless @current_role_user.nil?
        session[:user_role_id] = @current_role_user.id
      end
    end
  end

  ## Проверка прав доступа выбранной роли для данного метода
  def check_ctr_auth()
    return (@current_role_user.try(:is_admin?) ) #or @current_role_user.try(:is_operator?)
  end

  def not_authenticated
    redirect_to login_path, danger: "Сначала войдите в систему!"
  end
  def check_role(*roles)
    unless roles.find{|x| @current_role_user.try("is_#{x}?") }
      redirect_to(ip_path(
       bad_action_name: action_name,
       bad_controller_name: controller_name,
       bad_user_role: @current_role_user.try(:id)))
    end
  end
end
