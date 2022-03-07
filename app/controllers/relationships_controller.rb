class RelationshipsController < ApplicationController
    before_action :check_login, only: [:create, :destroy]
    def create
        @user = User.find(params[:follow])
        current_user.follow(@user)
    end

    def destroy
        @user = current_user.relationships.find(params[:id]).follow
        current_user.unfollow(params[:id])
    end

    private
    def check_login
        if current_user == nil 
            flash[:notice] = '権限がありません'
            redirect_to("/")
        end
    end
end
