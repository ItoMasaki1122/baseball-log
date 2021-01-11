class GamesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @user = User.find(params[:id])
    @game = Game.find(params[:id])
  end
  
  def new
    @game = current_user.games.build
  end

  def create
    @game = current_user.games.build(game_params)

    if @game.save
      flash[:success] = '試合を登録しました。'
      redirect_to @game
    else
      flash.now[:danger] = '試合の登録に失敗しました。'
      render :new
    end
  end

  def destroy
    @game.destroy
    flash[:success] = '試合を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
   private

  def game_params
    params.require(:game).permit(:date, :place, :enemy, :result, :topic, :content)
  end
  
  def correct_user
    @game = current_user.games.find_by(id: params[:id])
    unless @game
      redirect_to root_url
    end
  end
end
