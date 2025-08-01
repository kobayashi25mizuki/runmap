class GroupUsersController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    current_user.group_users.create(group_id: @group.id, status: 'pending')
    flash[:application] = "参加申請を送りました"
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    current_user.group_users.find_by(group_id: @group.id)&.destroy
    redirect_to group_path(@group)
  end

  def approve
    group_user = GroupUser.find(params[:id])
    group_user.update(status: 'approved')
    flash[:approval] = "参加申請を承認しました"
    redirect_to group_path(params[:group_id])
  end

  def reject
    group_user = GroupUser.find(params[:id])
    group_user.destroy
    flash[:rejection] = "参加申請を拒否しました"
    redirect_to group_path(params[:group_id])
  end
end
