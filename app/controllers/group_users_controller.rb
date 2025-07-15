class GroupUsersController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    current_user.group_users.create(group_id: @group.id, status: 'pending')
    redirect_to group_path(@group), application: "参加申請を送りました"
  end

  def destroy
    @group = Group.find(params[:group_id])
    current_user.group_users.find_by(group_id: @group.id)&.destroy
    redirect_to group_path(@group)
  end

  def approve
    group_user = GroupUser.find(params[:id])
    group_user.update(status: 'approved')
    redirect_to group_path(params[:group_id]), approval: "参加申請を承認しました"
  end

  def reject
    group_user = GroupUser.find(params[:id])
    group_user.update(status: 'rejected')
    redirect_to group_path(params[:group_id]), rejection: "参加申請を拒否しました"
  end
end
