class MembershipsController < ApplicationController
  def new
  	@membership=Membership.new
  end

  def create

  	group = Group.find_by(passcode: params[:group][:passcode].downcase)
    if group
    	if !current_user.group.include?(group)
    	current_user.group<<group
      group.capacity +=1
      group.save
    	flash[:success] = "You have joined #{group.name}"
    	
    	else
    	flash[:danger] = "You are already following this group"
    	end
    else
      flash[:danger] = "Incorrect Group Code"
    end
    redirect_to root_path
  end

  def destroy
    Membership.find(params[:id]).destroy
    flash[:success] = "User Removed"
    redirect_to :back
  end

  def index
  end
end
