class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
    def index
        @users = User.all
        @groups = Group.all
        @post_comments = PostComment.all
    end
end
