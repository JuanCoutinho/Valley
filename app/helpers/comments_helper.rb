# app/helpers/comments_helper.rb
module CommentsHelper
  def highlight_mentions(comment_body)
    # Captura menções (@username) e envolve em uma tag <span>
    comment_body.gsub(/(@\w+)/) do |mention|
      "<span class='text-blue-500 font-bold'>#{mention}</span>".html_safe
    end
  end
end
