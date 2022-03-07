class LikesController < ApplicationController
    before_action :movie_params
    before_action :check_login, only: [:create, :destroy]
    before_action :check_auther, only: [:destroy]
    def create
        Like.create(user_id: current_user.id, movie_id: params[:id])
    end
    
    def destroy
        Like.find_by(user_id: current_user.id, movie_id: params[:id]).destroy
    end
    
    private
    
    def movie_params
        @movie = Movie.find(params[:id])
    end

    def check_login
        if current_user == nil 
            flash[:notice] = '権限がありません'
            redirect_to("/")
        end
    end

    def check_auther
        like = Like.find_by(movie_id: @movie.id)
        if like.user_id != current_user.id
            flash[:notice] = '権限がありません'
            redirect_to movies_path
        end
    end
end