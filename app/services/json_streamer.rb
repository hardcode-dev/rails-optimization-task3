# frozen_string_literal: true

class JsonStreamer
  def self.stream(filename)
    new(filename).stream
  end

  def initialize(filename)
    @file = File.open(filename, 'r:UTF-8')
  end

  def stream
    Enumerator.new do |yielder|
      loop do
        yielder << Oj.load(object)
      rescue Oj::ParseError, TypeError => _e
        break
      end
    end
  end

  private

  attr_reader :file

  def object
    nesting = 0
    str = +''

    while nesting > 0 || str.empty?
      ch = file.getc

      return if file.eof?

      nesting += 1 if ch == '{'
      str << ch if nesting >= 1
      nesting -= 1 if ch == '}'

      str
    end

    str
  end
end
