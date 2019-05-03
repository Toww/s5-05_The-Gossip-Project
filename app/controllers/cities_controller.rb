class CitiesController < ApplicationController
	def show
  	# On stock dans une variable l'entrée de la base de donnée qui
    # correspond à notre city via le paramètre récupéré dans l'URL
    @city = City.find(params[:id])

    # On stock tout nos users dans une variable
    @city_users = @city.users.all

    # On créer un array vide afin de stocker les gossips associés à chaque ville
    @city_gossips = []

    # Pour chaque ville on récupère les utilisateurs,
    @city.users.each do |user|

    	# puis avec la seconde boucle on récupère les gossips de chaque user,
    	# et on rentre ces gossips dans notre array afin de les afficher sur la view ville
    	user.gossips.each do |gossip|
    		@city_gossips << gossip
    	end
    end

    # On vérifie que @city_gossips passe bien par la console du server
    puts "*"*60
    puts @city_gossips
    puts "*"*60
  end
end
