# frozen_string_literal: true

class Public::HomesController < ApplicationController
  def top
    @users = User.all
    @random_posts = Post.where(is_private: false).order('RAND()').limit(4)
  end

  def about
  end
end
