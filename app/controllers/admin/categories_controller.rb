class Admin::CategoriesController < ApplicationController
  def index
    # カテゴリー一覧を表示する処理
    @categories = Category.all
  end

  def new
    # 新規カテゴリー投稿フォームを表示する処理
    @category = Category.new
  end

  def create
    # カテゴリーの新規投稿を処理する処理
    @category = Category.new(category_params)

    if @category.save!
      redirect_to admin_categories_path, notice: '投稿が成功しました。'
    else
      render :new
    end
  end

  def edit
    # カテゴリー編集フォームを表示する処理
    @category = Category.find(params[:id])
  end

  def update
    # カテゴリー編集内容を更新する処理
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: '編集が成功しました。'
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
