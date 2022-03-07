class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :follow, :follower]
    before_action :check_login, only: [:edit, :update]
    before_action :check_auther, only: [:edit, :update]

    # GET /users/1
    # GET /users/1.json
    def show
        @movies = Movie.where(user_id: @user.id).reverse_order
        @likes = Like.where(movie_id: @movies.ids)
        likes = Like.where(user_id: @user.id).pluck(:movie_id)
        @like_movies = Movie.find(likes)
        @answers = Answer.where(user_id: @user.id)
        @nices = Nice.where(answer_id: @answers.ids)
        @questions = Question.where(user_id: @user.id).reverse_order
        nices = Nice.where(user_id: @user.id).pluck(:answer_id)
        @nice_answers = Answer.find(nices)
        @follows = Relationship.where(user_id: @user.id)
        @followers = Relationship.where(follow_id: @user.id)
    end

    def follow
        @follows = Relationship.where(user_id: @user.id)
    end

    def follower
        @followers = Relationship.where(follow_id: @user.id)
    end

    # GET /users/1/edit
    def edit
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
        respond_to do |format|
            if @user.update(user_params)
            format.html { redirect_to @user }
            format.json { render :show, status: :ok, location: @user }
            else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:id])
        end

        def check_login
            if current_user == nil 
                flash[:notice] = '権限がありません'
                redirect_to("/")
            end
        end

        def check_auther
            if @user.id != current_user.id
                flash[:notice] = '権限がありません'
                redirect_to("/")
            end
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
            params.require(:user).permit(:name, :avatar)
        end

    end 