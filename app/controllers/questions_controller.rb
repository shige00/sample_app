class QuestionsController < ApplicationController
    before_action :set_movie, only: [:show, :edit, :update, :destroy]
    before_action :check_login, only: [:new, :edit, :create, :update, :destroy]
    before_action :check_auther, only: [ :edit, :update, :destroy]
    # GET /movies
    # GET /movies.json
    def index
      @q = Question.ransack(params[:q])
      @movies = @q.result.includes(:user).page(params[:page]).reverse_order.per(16)
    end

    # GET /movies/1
    # GET /movies/1.json
    def show
        @user = User.find_by(id: @movie.user_id)
        @movies = Movie.where(user_id: @user.id)
        @likes = Like.where(movie_id: @movies.ids)
        @answers = Answer.where(user_id: @user.id)
        @nices = Nice.where(answer_id: @answers.ids)
    end

    # GET /movies/new
    def new
        @movie = Question.new
        @movie.auther = current_user.name
    end

    # GET /movies/1/edit
    def edit
        @movie = Question.find_by(id: params[:id])
    end
  
    # POST /movies
    # POST /movies.json
    def create
        @movie = Question.new(movie_params)
        @movie.auther = current_user.name
        @movie.user_id = current_user.id
        respond_to do |format|
        if @movie.save
            format.html { redirect_to @movie, notice: '投稿しました。' }
            format.json { render :show, status: :created, location: @movie }
        else
            format.html { render :new }
            format.json { render json: @movie.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /movies/1
    # PATCH/PUT /movies/1.json
    def update
      respond_to do |format|
        if @movie.update(movie_params)
          format.html { redirect_to @movie, notice: '投稿を編集しました。' }
          format.json { render :show, status: :ok, location: @movie }
        else
          format.html { render :edit }
          format.json { render json: @movie.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /movies/1
    # DELETE /movies/1.json
    def destroy
      @movie.destroy
      respond_to do |format|
        format.html { redirect_to questions_url, notice: '投稿を削除しました。' }
        format.json { head :no_content }
      end
    end
  
    def search
      @movies = Question.search(params[:keyword])
      @keyword = params[:keyword]
      render "index"
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_movie
        @movie = Question.find(params[:id])
      end
  
      def check_login
        if current_user == nil
          flash[:notice] = '権限がありません'
          redirect_to("/")
        end
      end
  
      def check_auther
        if current_user.admin?
        elsif @movie.user_id != current_user.id
          flash[:notice] = '権限がありません'
          redirect_to questions_path
        end
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def movie_params
        params.require(:question).permit(:title, :content, :movie)
      end
end
