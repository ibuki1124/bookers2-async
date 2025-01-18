class RelationshipsController < ApplicationController
  # フォロー機能
  def create
    user = User.find(params[:user_id])
    current_user.relationships.create(followed_id: user.id)
    redirect_to request.referer
  end

  # フォロー削除機能
  def destroy
    user = User.find(params[:user_id])
    current_user.relationships.find_by(followed_id: user.id).destroy
    redirect_to request.referer
  end
  # フォロワー一覧表示
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  # フォロー一覧表示
  def following
    user = User.find(params[:user_id])
    @users = user.following
  end
end
