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

  def notice
    if flash[:notice]
      content = ''
      content << content_tag(:div, content_tag(:p, flash[:notice]), :class => "notice", :id => "notice")
    end
  end

  def errors_for(*args)
    content_for(:errors) { error_messages_for(*args) }
  end

  def tab_selected?(controller_name)
    "selected" if @controller.controller_path.split("/").include?(controller_name)
  end

end

