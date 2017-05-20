class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
    json_response(@profiles)
  end

  # POST /profiles
  def create
    @profile = Profile.create!(profile_params)
    json_response(@profile, :created)
  end

  # GET /profiles/:id
  def show
    json_response(@profile)
  end

  # PUT /profiles/:id
  def update
    @profile.update(profile_params)
    head :no_content
  end

  # DELETE /profiles/:id
  def destroy
    @profile.destroy
    head :no_content
  end

  private

  def profile_params
    # whitelist params
    params.permit(:firstname, :lastname, :phone, :email)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end