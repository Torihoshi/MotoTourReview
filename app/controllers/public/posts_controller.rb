class Public::PostsController < ApplicationController
  def index
    # レビュー一覧を表示する処理
    @posts = Post.all
  end

  def show
    # レビュー詳細を表示する処理
  end

  def new
    # 新規レビュー投稿フォームを表示する処理
    @post = Post.new
  end

  def create
    # レビューの新規投稿を処理する処理
    post = Post.new(post_params)
    post.user_id = current_user.id # ユーザーIDをセット
    # @post.category_id = params[:post][:category_id] # カテゴリーIDをセット

    if post.save!
      redirect_to root_path, notice: '投稿が成功しました。'
    else
      render :new
    end
  end

  def edit
    # レビュー編集フォームを表示する処理
  end

  def update
    # レビューの編集内容を更新する処理
  end

  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:user_id, :spot_name, :title, :comment, :visited_date, :category_id)
  end

end
