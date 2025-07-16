class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
    def destroy
        @post_comments = PostComment.find(params[:id])
        @post_comments.destroy
        redirect_to admin_dashboards_path, notice: 'コメントを削除しました。'
    end
end
