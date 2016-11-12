module Renderers
  class Markdown
    def self.process(text)
      markdown.render(text)
    end

    def self.markdown
      Redcarpet::Markdown.new(renderer, {
        autolink: true,
        no_intra_emphasis: true,
        strikethrough: true
      })
    end

    def self.renderer
      Redcarpet::Render::HTML.new({
        filter_html: true,
        no_images: true,
        no_styles: true,
        safe_links_only: true
      })
    end

    private_class_method :markdown
    private_class_method :renderer
  end
end
