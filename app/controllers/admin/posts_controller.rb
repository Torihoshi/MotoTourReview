# frozen_string_literal: true

class Admin::PostsController < ApplicationController
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

    if @post.user == current_user && @post.update(post_params)
      flash[:success] = "投稿が更新されました"
      redirect_to post_path(@post)
    else
      flash.now[:error] = "投稿の更新に失敗しました"
      render :edit
    end
  end
end
