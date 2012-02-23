# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

class ChatroomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_owner, :only => [:edit, :update, :destroy]
  before_filter :user_is_allowed, :only => [:show, :full]

  # GET /chatrooms
  # GET /chatrooms.json
  def index
    @chatrooms = current_user.chatrooms.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chatrooms }
    end
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    @msgs = @chatroom.msgs.last(20).reverse
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chatroom }
    end
  end

  def full
    @msgs = @chatroom.msgs.reverse
    respond_to do |format|
      format.html
      format.json { render json: @chatroom }
    end
  end

  # GET /chatrooms/new
  # GET /chatrooms/new.json
  def new
    @chatroom = current_user.chatrooms.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chatroom }
    end
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms
  # POST /chatrooms.json
  def create
    @chatroom = current_user.chatrooms.build(params[:chatroom])

    respond_to do |format|
      if current_user.chatrooms << @chatroom
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
        format.json { render json: @chatroom, status: :created, location: @chatroom }
      else
        format.html { render action: "new" }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chatrooms/1
  # PUT /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update_attributes(params[:chatroom])
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1
  # DELETE /chatrooms/1.json
  def destroy
    @chatroom.destroy

    respond_to do |format|
      format.html { redirect_to chatrooms_url, alert: "Chatroom deleted. :(" }
      format.json { head :ok }
    end
  end

private
  def user_is_owner
    @chatroom = Chatroom.find(params[:id])
    redirect_to root_path, :flash => { :notice => "You don't own that" } unless current_user.chatrooms.include? @chatroom
  end

  def user_is_allowed
    @chatroom = Chatroom.find(params[:id])
    redirect_to root_path, :flash => { :notice => "You don't have permission to see this" } unless @chatroom.users.include? current_user
  end
end
