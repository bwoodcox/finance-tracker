class FriendshipsController < ApplicationController
  def create
    friend = User.find params[:friend]
    @user_stock = Friendship.create(user: current_user, friend: friend)
    flash[:notice] = "You are now following #{friend.full_name}."
    redirect_to my_friends_path
  end

  def destroy
    friend = current_user.friendships.where(friend_id: params[:id]).first
    friend.destroy
    flash[:notice] = "Friend was successfully unfollowed."
    redirect_to my_friends_path
  end
end
