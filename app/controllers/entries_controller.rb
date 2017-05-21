class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_user_entry, only: [:show, :update, :destroy]


  # GET /entries
  def index
    logger.debug "Getting entries for current user #{current_user.inspect}"
    json_response(@user.entries)
  end

  # GET /entries/:id
  def show
    json_response(@entry)
  end

  # POST /users/:user_id/entries
  def create
    entry = @user.entries.create!(entry_params)
    json_response(entry, :created)
  end

  # PUT /users/:user_id/entries/:id
  def update
    @entry.update(entry_params)
    head :no_content
  end

  # DELETE /users/:user_id/entries/:id
  def destroy
    @entry.destroy
    head :no_content
  end

  private

  def entry_params
    params.permit(:content, :occurred_on, :linked_user_id)
  end

  def set_user
    @user = User.find(current_user.id) if user_signed_in?
  end

  def set_user_entry
    @entry = @user.entries.find_by!(id: params[:id]) if @user
  end
end