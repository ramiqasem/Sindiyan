class MembershipsController < ApplicationController
  def new
  	@membership=Membership.new
  end

  def create
  	group = Group.find_by(passcode: params[:passcode])
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

  def delete
  end

  def index
  end
end
