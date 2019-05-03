class UsersController < ApplicationController

	def new
    @user = User.new
  end

  def create

    if City.find_by(name: params[:city])
      @city = City.find_by(name: params[:city])
    else
      @city = City.create(name: params[:city], zip_code: params[:zip_code])
    end

     @user = User.new(first_name: params[:first_name],
      last_name: params[:last_name],
      description: params[:description],
      email: params[:email],
      age: params[:age],
      city: @city,
      password: params[:password],
      password_confirmation: params[:password_confirmation]
      )

    if @user.save
      flash[:success] = "Welcome #{@user.first_name}! 👍"
      log_in(@user)
      redirect_to root_path #Affiche l'index des gossips
    else
      render 'new' # Reste sur la view de gossips New.
    end   
  end

  def show
    # On stock dans une variable l'entrée de la base de donnée qui
    # correspond à notre user via le paramètre récupéré dans l'URL
    @user = User.find(params[:id])
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
