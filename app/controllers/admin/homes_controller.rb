# frozen_string_literal: true

class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    # 会員一覧トップページを表示する処理
    @users = User.all
  end
end
