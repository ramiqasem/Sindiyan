class GroupsController < ApplicationController
  def create
    @group = current_user.group.build(group_params)
    @group.passcode=  6.times.map { [*'0'..'9', *'a'..'z', *'A'..'Z'].sample }.join
    @group.capacity = 1
    #grouping = (params[:group_ids])
    if @group.save
      membership=Membership.find_by(group_id: @group.id, user_id: current_user.id)
      membership.owner = true
      if membership.save
      flash[:success] = "Group created!"
      redirect_to root_url
      end
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = "Group deleted"
    redirect_to request.referrer || root_url
    
  end

  def join
    
    
  end

  def edit
    @group=Group.find(params[:id])
  end

  def update
    @group=Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "Group changed!"
      redirect_to root_url

    else
      render 'edit'
    end
  end

  def create_join

  end 


   private

    def group_params 
      params.require(:group).permit(:name, :description, :passcode)
    end

end
