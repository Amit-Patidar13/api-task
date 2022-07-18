class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @users = User.where(user_type: [User.user_types[:teacher], User.user_types[:student]])
    elsif current_user.teacher?
      @users = User.student
    else
      render json: { message: 'You are not authorize to perform this action'}, status: 401  
    end
      render json: @users
  end

  def demo
    users = User.all
    render json: {success: true, data: users}
  end

 def create
    if current_user.admin?
      @users = User.student.new(user_params)
      @users = User.teacher.new(user_params)
      if @users.save
        render json: @users
      end
    else
       render json: { message: 'You are not authorize to perform this action'}, status: 401
    end
  end

  def show
    if current_user.admin?
      @users = User.teacher.find(params[:id])
      @users = User.student.find(params[:id])
    elsif current_user.teacher?
      @users = User.student.find(params[:id])
      render json: @users
    else
      render json: {message: "you are not authorize to perform this action"},status: 401
    end 
  end


  def update
    if current_user.admin? || current_user.id.to_s == params[:id]
      @user = User.find_by(id: params[:id])
      if @user.update(user_params)
        render json: {message: "update sucessfully"}
      else
        render json: { message: 'You are not authorize to perform this action'}, status: 401
      end
    end
  end
 

  def destroy
    if current_user.admin? && current_user.id.to_s != params[:id]
      user = User.find_by(id: params[:id])
      if user.destroy
        render json: {message: "deleted succesfully"}
      else
        render json:{message: 'you are not authorize to perform this action'},status:401
      end
    else
      render json:{message: 'you are not authorize to perform this action'},status: 401
    end
  end

  def user_params
    params.require(:user).permit(:fname,:lname,:contact,:age,:city, :email, :password, :user_type)
  end
end

