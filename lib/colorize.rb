class Colorize
  def self.red(text)
    colorize(text, "31")
  end

  def self.green(text)
    colorize(text, "32")
  end

  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  private_class_method :colorize
end
