class CompetitionController < ApplicationController

	def elo()

		@winner = Picture.find(params[:winner])
		@loser = Picture.find(params[:loser])

		winner_score = @winner.elo
		loser_score = @loser.elo

    expected = 1 / (1 + 10**((loser_score - winner_score)/400))
    mult = 0;
    
    if (winner_score < 1200)
        mult = 30
    elsif (winner_score < 1600)
        mult = -0.05 *  winner_score + 100
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
		@second_pic = nil


		photo_elo = @first_pic.elo.to_i

		elo_search = 50
	
		until Picture.where(elo: (photo_elo - elo_search)...(photo_elo + elo_search)) && (@second_pic != @first_pic) && @second_pic
			
			bound_array = Picture.where(elo: (photo_elo - elo_search)...(photo_elo + elo_search))
			length = bound_array.length
			random = (rand(length) * 3457) % length
			@second_pic = bound_array[random]
			if length == 1
				elo_search += 50
			end

		end 
	
		

		if @first_pic && @second_pic
			render :json => {:success => true, first_image: @first_pic, second_image: @second_pic, first_image_url: @first_pic.image.url, second_image_url: @second_pic.image.url}
		else
			render :json => {:success => false}
		end
	end
end
