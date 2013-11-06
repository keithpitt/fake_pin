module FakePin
  class Token
    def self.generate(prefix)
      new(prefix).generate
    end

    def initialize(prefix)
      @prefix = prefix
    end

    def generate
      "#{@prefix}_#{Time.now.to_f.to_s.gsub(/\./, '')}"
    end
  end
end
