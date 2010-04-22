module LayoutHelper

  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def stylesheet_merged(*args)
    content_for(:head) { stylesheet_link_merged(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def javascript_merged(*args)
    content_for(:head) { javascript_include_merged(*args) }
  end

end

