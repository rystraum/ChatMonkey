class UsersController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @user = User.find_by_email(params[:user][:email])

    if @user.nil?
      redirect_to @chatroom, :flash => { :error => "No such user" }
    elsif @chatroom.users.include? @user
      redirect_to @chatroom, :flash => { :error => "User is already in here" }
    else
      @chatroom.users << @user
      redirect_to @chatroom, :flash => { :notice => "User invited" }
    end
  end
end
