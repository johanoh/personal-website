module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = { autolink: true, tables: true, fenced_code_blocks: true })
    markdown.render(text).html_safe
  end
end
