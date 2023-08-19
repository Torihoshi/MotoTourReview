# frozen_string_literal: true

class Public::PostsController < ApplicationController
  def index
    @categories = Category.all
    @posts = if params[:category_id].present?
      Post.where(category_id: params[:category_id], is_private: false)
    elsif params[:word]
      Post.where("spot_name LIKE ?", "%#{params[:word]}%").where(is_private: false)
    else
      Post.where(is_private: false)
    end

    if params[:sort] == "favorites"
      @posts = @posts.left_joins(:favorites).group("posts.id").order("COUNT(favorites.id) DESC")
    elsif params[:sort] == "star"
      @posts = @posts.order(star: :desc)
    end

    @pagy, @posts = pagy(@posts, items: 9)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    # 新規レビュー投稿フォームを表示する処理
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id

    if post.save!
      redirect_to root_path, notice: "投稿が成功しました。"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    # 自分の投稿でなければ編集不可
    unless @post.user == current_user
      flash[:error] = "自分の投稿でないため、編集できません"
      redirect_to post_path(@post)
    end
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

  private
    # ストロングパラメータ
    def post_params
      params.require(:post).permit(
        :user_id, :category_id, :spot_name, :title, :comment,
        :visited_date, :image, :star, :is_private, :address, :latitude, :longitude
      )
    end
end
