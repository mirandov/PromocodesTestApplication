class RoleUsersController < ApplicationController
  before_action :set_role_user, only: [:show, :edit, :update, :destroy]
  before_action -> {check_role('admin')}, except: [:new, :create, :activate]

  # GET /role_users
  # GET /role_users.json
  def index
    @role_users = RoleUser.all
  end

  # GET /role_users/1
  # GET /role_users/1.json
  def show
  end

  # GET /role_users/new
  def new
    @role_user = RoleUser.new
  end

  # GET /role_users/1/edit
  def edit
  end

  # POST /role_users
  # POST /role_users.json
  def create
    @role_user = RoleUser.new(role_user_params)

    respond_to do |format|
      if @role_user.save
        format.html { redirect_to @role_user, notice: 'Role user was successfully created.' }
        format.json { render :show, status: :created, location: @role_user }
      else
        format.html { render :new }
        format.json { render json: @role_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role_users/1
  # PATCH/PUT /role_users/1.json
  def update
    respond_to do |format|
      if @role_user.update(role_user_params)
        format.html { redirect_to @role_user, notice: 'Role user was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_user }
      else
        format.html { render :edit }
        format.json { render json: @role_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_users/1
  # DELETE /role_users/1.json
  def destroy
    @role_user.destroy
    respond_to do |format|
      format.html { redirect_to role_users_url, notice: 'Role user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_user
      @role_user = RoleUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_user_params
      params.require(:role_user).permit(:role_id, :user_id, :data)
    end
end
