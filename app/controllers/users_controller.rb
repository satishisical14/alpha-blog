class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	before_action :require_same_user, only: [:update, :edit, :destroy]
	before_action :require_admin, only: :destroy

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "User was succesfully created"
			redirect_to user_path(@user)
		else
			render :new
		end
	end

	def index 
		@users = User.paginate(page: params[:page], per_page: 2)
	end

	def edit 
	end

	def show
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "User updated succesfully"
			redirect_to user_path(@user)
		else
			render :edit 
		end
	end

	def destroy
		@user.destroy
		flash[:danger] = "user and all his articles deleted"
		redirect_to users_path
	end

	private
		def set_user
	  	@user = User.find(params[:id])
	  end

  	def user_params
			params.require(:user).permit(:username, :email, :password)
		end

		def require_same_user
			if current_user != @user and !current_user.admin?
				flash[:danger] = "Only Owner"
				redirect_to root_path
			end
		end

		def require_admin
			if !logged_in? and !current_user.admin?
				flash[:danger] = "only admin can delete"
				redirect_to root_path
			end
		end	
end