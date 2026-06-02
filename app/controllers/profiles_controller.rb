class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to profile_path(@profile), notice: "Votre profil a bien été créé"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: "Votre profil a été mis à jour"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # ------------ METHODES PRIVEES ------------
  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number, :address, :role)
  end
end
