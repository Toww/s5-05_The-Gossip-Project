class LikesController < ApplicationController
	def new	
		 # Pour revenir au gossip sur lequel on ajoute un commentaire
		 @gossip = Gossip.find(params[:gossip_id]) 
    # Pour ajouter un commentaire
    @like = Like.new
  end

  def create		
  	@gossip = Gossip.find(params[:gossip_id])
  	@like = Like.create(user: current_user, gossip: @gossip)

    # On rafraîchit la page pour afficher l'ajout de like
    # (request.referrer donne la page en cours)
    redirect_to request.referrer
  end

  def edit		
  end

  def update		
  end

  def destroy
  	@gossip = Gossip.find(params[:gossip_id])
  	@like = Like.find(params[:id])
 		
 		@like.destroy
  	redirect_to request.referrer
  end
end
