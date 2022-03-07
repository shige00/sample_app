class CommentsController < ApplicationController
    before_action :set_movie
    before_action :check_login, only: [:create, :destroy]
    before_action :check_auther, only: [:destroy]

    def create
        comment = current_user.comments.new(comments_params)
        comment.movie_id = @movie.id
        comment.user_id = current_user.id
        comment.auther = current_user.name
        comment.save
        redirect_to @movie
    end

    def destroy
        @movie.comments.destroy params[:id]
        redirect_to @movie
    end

    private
        def set_movie
            @movie = Movie.find(params[:movie_id])
        end

        def check_login
            if current_user == nil 
                flash[:notice] = '権限がありません'
                redirect_to("/")
            end
        end

        def check_auther
            if @movie.comments.find(params[:id]).user_id != current_user.id
                flash[:notice] = '権限がありません'
                redirect_to movies_path
            end
        end

        def comments_params
            params.required(:comment).permit(:content)
        end
end