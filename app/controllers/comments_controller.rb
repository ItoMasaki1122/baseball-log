class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def new
  end

  def create
    @game = Game.find(params[:game_id])
    comment = Comment.new(comment_params)
    if comment.save
      flash[:success] = 'コメントを送信しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントの送信に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    comment = @game.comments.find(params[:id])
    comment.destroy
    flash[:success] = 'コメントの削除に成功しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, game_id: params[:game_id])
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to current_user
    end
  end
end
