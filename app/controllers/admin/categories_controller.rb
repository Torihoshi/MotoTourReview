# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    # カテゴリー一覧を表示する処理
    @categories = Category.all

    # カテゴリごとの投稿数を取得
    @category_post_counts = {}
    @categories.each do |category|
      @category_post_counts[category] = category.posts.count
    end
  end

  def new
    # 新規カテゴリー投稿フォームを表示する処理
    @category = Category.new
  end

  def create
    # カテゴリーの新規投稿を処理する処理
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "投稿が成功しました。"
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
      redirect_to admin_categories_path, notice: "更新が成功しました。"
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    # カテゴリに関連付けられた投稿が存在するか確認
    if @category.posts.any?
      redirect_to admin_categories_path, alert: "カテゴリに関連付けられた投稿が存在するため、カテゴリを削除できません。"
    else
      if @category.destroy
        redirect_to admin_categories_path, notice: "カテゴリが削除されました。"
      else
        redirect_to admin_categories_path, alert: "カテゴリの削除に失敗しました。"
      end
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
