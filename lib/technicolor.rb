require 'erb'
require 'yaml'
require 'ostruct'
require 'ruby-debug'

module Technicolor
  class ErbBinding < OpenStruct
    def get_binding
      return binding()
    end
  end

  class Generator
    def initialize(opts)
      @namespace = ErbBinding.new(opts)

    end

    def rgb(str)
      str.scan(/../).map {|color| color.to_i(16)}
    end

    def rgb_int(str)
      str.scan(/../).map {|color| color.to_i(16)/256.0}
    end

    def create_vim

      #path = File.join(File.dirname(__FILE__), 'technicolor', 'templates', 'vim.erb')
      path = File.join(File.dirname(__FILE__), 'technicolor', 'templates', 'solarized.vim.erb')
      template = IO.read(path)

      colorscheme = ERB.new(template).result(@namespace.get_binding)

      colorscheme.gsub(/^\s+/, "")
    end
  end
end
