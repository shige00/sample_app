class NicesController < ApplicationController
    before_action :answer_params
    before_action :check_login, only: [:create, :destroy]
    before_action :check_auther, only: [:destroy]
    def create
        Nice.create(user_id: current_user.id, answer_id: params[:id])
    end
    
    def destroy
        Nice.find_by(user_id: current_user.id, answer_id: params[:id]).destroy
    end
    
    private
    
    def answer_params
        @answer = Answer.find(params[:id])
    end

    def check_login
        if current_user == nil 
            flash[:notice] = '権限がありません'
            redirect_to("/")
        end
    end

    def check_auther
        nice = Nice.find_by(answer_id: @answer.id)
        if nice.user_id != current_user.id
            flash[:notice] = '権限がありません'
            redirect_to movies_path
        end
    end
end