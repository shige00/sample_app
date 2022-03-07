class AnswersController < ApplicationController
    before_action :set_movie
    before_action :check_login, only: [:create, :destroy]
    before_action :check_auther, only: [:destroy]

    def create
        answer = current_user.answers.new(answers_params)
        answer.question_id = @movie.id
        answer.user_id = current_user.id
        answer.auther = current_user.name
        answer.save
        redirect_to @movie
    end

    def destroy
        @movie.answers.destroy params[:id]
        redirect_to @movie
    end

    private
        def set_movie
            @movie = Question.find(params[:question_id])
        end

        def check_login
            if current_user == nil 
                flash[:notice] = '権限がありません'
                redirect_to("/")
            end
        end

        def check_auther
            if @movie.answers.find(params[:id]).user_id != current_user.id
                flash[:notice] = '権限がありません'
                redirect_to questions_path
            end
        end

        def answers_params
            params.required(:answer).permit(:content)
        end
end