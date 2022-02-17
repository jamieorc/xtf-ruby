module XTF
  module Search
    class Constants
      def self.phrase_delimiters
        /[\-\s\\\/.,;:()]+/
      end
    end
  end
end
$:.unshift(File.dirname(__FILE__))
require 'search/element'
