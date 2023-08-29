# frozen_string_literal: true

class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # レビュー一覧を表示する処理
    @posts = if params[:category_id].present?
      Post.where(category_id: params[:category_id])
    else
      Post.all
    end
  end

  def show
    # レビュー詳細を表示する処理
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = "投稿が更新されました"
      redirect_to admin_post_path(@post)
    else
      flash.now[:error] = "投稿の更新に失敗しました"
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:spot_name, :title, :comment, :visited_date, :category_id)
  end
end
