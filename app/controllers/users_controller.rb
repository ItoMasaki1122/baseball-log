class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :search]
  before_action :correct_user, only: [:edit]
  
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @like = @user.likes.first
    @games = @user.games.order(id: :desc).page(params[:page])
    @win_games = @user.games.where(result: '勝ち').count
    @lose_games = @user.games.where(result: '負け').count
    @draw_games = @user.games.where(result: '引き分け').count
    @win_rate = sprintf("%.3f",@win_games / (@win_games + @lose_games).to_f)
    
      if @win_rate < '1'
        str = @win_rate
        @win_rate = str[1,4]
      end
    
  end

  def new
    @user = User.new
  end

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params)
      @user.save
      team = Team.find(params[:favorite][:team_id])
      @user.favorite(team)
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    end
    rescue
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
        @user = User.find(params[:id])
        @user.update!(user_params)
        team = Team.find(params[:favorite][:team_id])
        @user.favchange(team)
        flash[:success] = 'ユーザー情報は正常に更新されました'
        redirect_to @user
    end
  rescue
        flash.now[:danger] = 'ユーザー情報は更新されませんでした'
        render :edit
  end
  
  def search
    @team = Team.find(params[:team_id])
    @users = @team.relikes.order(id: :desc).page(params[:page]).per(25)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduce, :email, :password, :password_confirmation)
  end
  
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to current_user
    end
  end
end
