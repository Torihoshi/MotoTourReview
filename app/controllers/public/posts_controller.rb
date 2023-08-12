class Public::PostsController < ApplicationController
  def index
    # レビュー一覧を表示する処理
    @categories = Category.all
    @posts = if params[:category_id].present?
                Post.where(category_id: params[:category_id])
              elsif params[:word]
                Post.where("spot_name LIKE ?", "%#{params[:word]}%")
              else
                Post.all
              end
  end

  def show
    # レビュー詳細を表示する処理
    @post = Post.find(params[:id])
    @comment = Comment.new
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
    params.require(:post).permit(:user_id, :spot_name, :title, :comment, :visited_date, :category_id, :star)
  end

end
