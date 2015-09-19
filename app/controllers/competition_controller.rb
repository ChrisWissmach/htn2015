class CompetitionController < ApplicationController

	def elo(winner, loser)

		@winner = Picture.find(winner)
		@loser = Picture.find(loser)

		winner_score = @winner.elo
		loser_score = @loser.elo

    expected = 1 / (1 + 10**((loser - winner)/400))
    mult = 0;
    
    if (winner < 1200)
        mult = 30
    elsif (winner < 1600)
        mult = -0.05 *  winner + 100
    else
        mult = 10
    end
    
    elo = (mult * (1 - expected)).round

    @winner.elo = winner_score + elo
    @loser.elo = loser_score - elo

    if @winner.save && @loser.save
    	render :json => {:success => true, :message => "Elo updated"}
    else
    	render :json => {:success => false, :message => "Elo not updated"}
    end

  end
	
	
	def get_pictures()
		num_pics = Picture.count
		@first_pic = Picture.all[rand(num_pics)]

		photo_elo = @first_pic.elo.to_i

		elo_search = 50
	
		until Picture.where(elo: (photo_elo - 50)...(photo_elo + 50))
			elo_search += 50
		end 
	
		bound_array = Picture.where(elo: (photo_elo - 50)...(photo_elo + 50))
		length = bound_array.length

		@second_pic = bound_array[rand(length)]

		if @first_pic && @second_pic
			render :json => {:success => true, first_image: @first_pic, second_image: @second_pic, first_image_url: @first_pic.image.url, second_image_url: @second_pic.image.url}
		else
			render :json => {:success => false}
		end
	end
end
