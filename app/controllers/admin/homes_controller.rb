class Admin::HomesController < ApplicationController
  def top
    # 会員一覧トップページを表示する処理
    @users = User.all
  end
end
