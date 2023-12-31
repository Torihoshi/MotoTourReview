# frozen_string_literal: true

module Public::PostsHelper

  def sort_by_sort_url(url, order)
    url.gsub(/%5Bs%5D=\w+\+\w+/, "%5Bs%5D=#{order}")
  end

end
