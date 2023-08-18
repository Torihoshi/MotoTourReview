class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :unsubscribe]

  def show
    @user_posts = @user.posts.order(created_at: :desc)
  end

  def edit
    # ユーザー情報の編集フォームを表示する処理
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報が更新されました"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "ユーザー情報の更新に失敗しました"
      render :edit
    end
  end

  def unsubscribe
    # ユーザーの退会確認画面を表示する処理
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会が完了しました。"
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :introduction, :bike_name, :is_deleted)
    end
end
