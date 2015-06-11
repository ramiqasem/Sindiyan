class MicropostsController < ApplicationController
  include AutoHtml
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  

  def create
    @micropost = current_user.microposts.build(micropost_params)
    groups = (params[:group_ids])
    if @micropost.save
      if params[:attachment].present?
        if params[:attachment]['attachment'].present?
          params[:attachment]['attachment'].each do |a|
            @attachment = @micropost.attachment.create!(:attachment => a, :micropost_id => @micropost.id, :name => a.original_filename)
            @attachment.save
            
          end
        end
      end 
      if groups 
        groups.each do |group_id|

          group=Group.find(group_id)
          @micropost.group<<group
          group.increment_new
          
          
        end
      end
      
      
      flash[:success] = "Message Sent!"
      
    else
      @feed_items = []
      render 'static_pages/home'
    end
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js { render layout: false, content_type: 'text/javascript' }
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def add_new_comment
    commentable = Micropost.find(params[:id])
    @comment= commentable.comments.create
    @comment.user_id = current_user.id
    @comment.comment = params[:comment]
    @comment.save
    flash[:success] = "Comment Added!"
    respond_to do |format|
      format.html {redirect_to :back}
      format.js { render layout: false, content_type: 'text/javascript' }
    end
  end

  private

  def micropost_params
   params.require(:micropost).permit(:content, :picture, :auto_html, :id, grouping_attributes: [:id], attachment_attributes: [:attachment])
 end

 def correct_user
  @micropost = current_user.microposts.find_by(id: params[:id])
  redirect_to root_url if @micropost.nil?
end


end