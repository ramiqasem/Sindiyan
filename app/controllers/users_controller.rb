class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
 
  def new
  	@user = User.new
  end

   def create
  	#if params[:avatar].present?
     # preloaded = Cloudinary::PreloadedFile.new(params[:avatar])         
    # raise "Invalid upload signature" if !preloaded.valid?
    #@user.avatar = preloaded.identifier
   # end
    @user=User.new(user_params)
      	if @user.save
          
          #UserMailer.account_activation(@user).deliver_now
          #flash[:info] = "Please check your email to activate your account."
          #redirect_to root_url
          log_in @user
  		    flash[:success] = "Welcome to the Sample App!"
  		    redirect_to root_url
  	   else
  		    render 'new'
  	   end
  end

  def show
  	@user=User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile successfully changed!"
      redirect_to @user

    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page])
  end

 def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def reset_group
    @group_id = params[:group_id]
    membership = Membership.where("group_id = ? AND user_id = ?", params[:group_id], current_user.id)
    membership.each do |membership|
    membership.new_count=0
    membership.save
    end
    
    
    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript' }
    end
  end

  private

  	def user_params 
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
 		end

    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end