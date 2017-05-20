class EntriesController < ApplicationController
  before_action :set_profile
  before_action :set_profile_entry, only: [:show, :update, :destroy]

  # GET /profiles/:profile_id/entries
  def index
    json_response(@profile.entries)
  end

  # GET /profiles/:profile_id/entries/:id
  def show
    json_response(@entry)
  end

  # POST /profiles/:profile_id/entries
  def create
    @profile.entries.create!(entry_params)
    json_response(@profile, :created)
  end

  # PUT /profiles/:profile_id/entries/:id
  def update
    @entry.update(entry_params)
    head :no_content
  end

  # DELETE /profiles/:profile_id/entries/:id
  def destroy
    @entry.destroy
    head :no_content
  end

  private

  def entry_params
    params.permit(:content, :occurred_on)
  end

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def set_profile_entry
    @entry = @profile.entries.find_by!(id: params[:id]) if @profile
  end
end