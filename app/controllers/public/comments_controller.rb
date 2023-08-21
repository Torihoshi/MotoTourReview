# frozen_string_literal: true

class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user # Assuming you have a current_user method

    if @comment.save
      flash[:success] = "コメントが投稿されました"
    else
      flash[:error] = "コメントの投稿に失敗しました"
    end

    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user && @comment.destroy
      flash[:success] = "コメントが削除されました"
    else
      flash[:error] = "コメントの削除に失敗しました"
    end

    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
