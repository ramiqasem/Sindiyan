class StaticPagesController < ApplicationController
    require 'will_paginate/array'

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      
      @group = Group.new
      @event = Event.new
      
      @groups=current_user.group
      
      #@microposts = @groups.map(&:micropost).paginate(page: params[:page], :per_page => 5)
      if params[:id]
        Rails.logger.debug params.inspect
        if params[:id]=="feed"
          @feed= current_user.feed.paginate(page: params[:page], :per_page => 5)
          Rails.logger.debug("@ feed feed")
        else
        group=Group.find(params[:id])
        Rails.logger.debug("@ feed group")
        @feed = group.micropost.paginate(page: params[:page], :per_page => 5)
        
      end
    else
      @feed= current_user.feed.paginate(page: params[:page], :per_page => 5)
      Rails.logger.debug("@ feed home")
    end 

      
      @owned_groups= current_user.owned_groups
      @attachment=@micropost.attachment.new
       

      respond_to do |format|
      
      format.js { render layout: false, content_type: 'text/javascript' }
      format.html 
      end

    end
  end

  def help
    if logged_in?
      @micropost  = current_user.microposts.build
      
      @group = Group.new
      @event = Event.new
      
      @groups=current_user.group
      @feed=current_user.feed
      #@microposts = @groups.map(&:micropost).paginate(page: params[:page], :per_page => 5)
      if params[:id]
        group=Group.find(params[:id])
        @posts = group.micropost.paginate(page: params[:page], :per_page => 5)
        Rails.logger.debug("My object: #{@posts}")
      end

      
      @owned_groups= current_user.owned_groups
      @attachment=@micropost.attachment.new
       

      respond_to do |format|
      
      format.js { render layout: false, content_type: 'text/javascript' }
      format.html 
      end

    end
  end

  def about
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @group = Group.new
      @groups=current_user.group
      @owned_groups= current_user.owned_groups
      
    end
  end


  def contact
  end

  def test
    #render layout: false
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
   end

end
