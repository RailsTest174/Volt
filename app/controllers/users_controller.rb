class UsersController < ActionController::Base
  layout "application"
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def upload_avatar
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @users
    else
      render 'edit'
    end  
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

end