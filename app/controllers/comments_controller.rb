class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def index
    @comments = Comment.all
  end

  def new
    # Pour revenir au gossip sur lequel on ajoute un commentaire
    @gossip = Gossip.find(params[:gossip_id]) 
    # Pour ajouter un commentaire
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end


  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(user: User.find(session[:user_id]), content: params[:content], gossip: @gossip)

    if @comment.save
      flash[:success] = "Comment successfully added! 👍"
      redirect_to gossip_path(@gossip.id)
    else
     redirect_to gossip_path(@gossip.id)
   end
 end


 def update
  @comment = Comment.find(params[:id])
  @gossip = Gossip.find(params[:gossip_id])

  if @comment.update(content: params[:content])

    flash[:success] = "Gossip successfully modified! 👍"
    redirect_to gossip_path(@gossip.id)
  else
    render 'edit'
  end
end

def destroy
  @gossip = Gossip.find(params[:gossip_id])
  @comment = Comment.find(params[:id])


  @comment.destroy
  flash[:alert] = "Comment deleted! 🗑️"
  redirect_to gossip_path(@gossip.id)
end
end
