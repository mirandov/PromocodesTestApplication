class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :check_app_auth, only: [:new, :create, :activate]
  skip_before_filter :require_login, :only => [:new, :create, :activate]
  before_action -> {check_role('admin')}, except: [:new, :create, :activate]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def new_by_admin
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path(), notice: 'Пользователь создан. Проверьте вашу почту для активации пользователя.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_by_admin
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path(), notice: 'Пользователь создан. На его почту отправлено сообщение об активации.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'Пользователь изменён.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Пользователь удалён.' }
      format.json { head :no_content }
    end
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(login_path, :notice => 'Адрес электронной почты подтверждён.')
    else
      not_authenticated
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
        :activation_state, :activation_token, :activation_token_expires_at,
      # nested_start
      # Добавляем связанные атрибуты
        {role_users_attributes: [:_destroy, :id, :role_id, :data]}
      # nested_finish
      )
    end
end
