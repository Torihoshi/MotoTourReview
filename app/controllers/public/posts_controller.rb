# frozen_string_literal: true

class Public::PostsController < ApplicationController
  before_action :set_search
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @categories = Category.all

    @pagy, @posts = pagy(@posts, items: 8)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = "投稿が成功しました。"
      redirect_to post_path(@post)
    else
      # byebug
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "投稿が更新されました"
      redirect_to post_path(@post)
    else
      # byebug
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to user_path(current_user)
  end

  private

    def set_search
      @q = Post.ransack(params[:q])
      if params[:q].present? && params[:q][:category_id_eq].present?
        @q.category_id_eq = params[:q][:category_id_eq]
      end
      @posts = @q.result(distinct: true).where(is_private: false).order(created_at: :desc)
    end


    def post_params
      params.require(:post).permit(:user_id, :category_id, :spot_name, :title, :comment, :visited_date, :star, :is_private, :address, :latitude, :longitude, images: [])
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user == current_user
        redirect_to post_path(@post)
      end
    end
end
