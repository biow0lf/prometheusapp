module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def url(string)
    content_for(:url) { string }
  end
end
