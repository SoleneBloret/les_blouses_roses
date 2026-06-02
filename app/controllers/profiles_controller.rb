class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile.params)
    @profile.user = current_user
    if @profile.save
      redirect_to profile_path(@profile), notice: "Votre profile a bien été créé"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile.params)
      redirect_to profile_path(@profile), notice: "Votre profil a été mis à jour"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # ------------ METHODES PRIVEES ------------
  private

  def profile.params
    params.require(:profile).permit(:first_name, :last_name, :phone_number, :address, :role)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
