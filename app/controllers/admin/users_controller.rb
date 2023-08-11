class Admin::UsersController < ApplicationController
  def show
    # ユーザー詳細を表示する処理
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    # ユーザー情報編集フォームを表示する処理
        @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報が更新されました"
      redirect_to admin_user_path(@user)
    else
      flash.now[:error] = "ユーザー情報の更新に失敗しました"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :bike_name, :is_deleted)
  end
end
