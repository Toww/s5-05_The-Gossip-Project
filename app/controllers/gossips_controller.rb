class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]

	def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(user: User.find(session[:user_id]),
      title: params[:title],
      content: params[:content])

    if @gossip.save
      flash[:success] = "Gossip successfully added! 👍"
      redirect_to gossips_path #Affiche l'index des gossips
    else
      render 'new' # Reste sur la view de gossips New.
    end
  end

  def show
    # On stock dans une variable l'entrée de la base de donnée qui
    # correspond à notre gossip via le paramètre récupéré dans l'URL
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
  end

  def index
    # On récupère tous les potins dans une variable
    @all_gossips = Gossip.all.reverse # On applique reverse pour avoir les derniers gossips en premier
    puts "*"*60
    puts "Fetching database for gossips"
    puts "-"*60
    # On vérifie si l'appel se fait bien sur le serveur
    puts @all_gossips 
    puts "*"*60
  end

  def edit
    @gossip = Gossip.find(params[:id])

    # Si l'utilisateur n'est pas l'auteur on redirige vers la page du potin sans pouvoir l'éditer,
    # et on prévient 
    is_not_author? 
  end

  def update
    @gossip = Gossip.find(params[:id])

    # Si l'utilisateur n'est pas l'auteur on redirige vers la page du potin sans pouvoir l'éditer,
    # et on prévient 
    is_not_author?

    if @gossip.update(title: params[:title],
      content: params[:content])

      flash[:success] = "Gossip successfully modified! 👍"
      redirect_to gossip_path
    else
      render 'edit'
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    
    # Si l'utilisateur n'est pas l'auteur on redirige vers la page du potin sans pouvoir l'éditer,
    # et on prévient, sinon on détruit le potin
    if !is_not_author? 
      @gossip.destroy
      flash[:alert] = "Gossip deleted! 🗑️"
      redirect_to gossips_path
    end
  end

  # On utilise une méthode pour sécuriser l'édition et la suppression des gossips
  def is_not_author?
    if current_user != @gossip.user
      flash[:alert] = "Well tried! You're not the gossip author..."
      redirect_to gossip_path
    end
  end
end
