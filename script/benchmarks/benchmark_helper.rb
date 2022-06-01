require_relative "../../config/environment"
require_relative '../../lib/json_importer'

SIZE = ENV['SIZE']&.downcase

def work
  path =
    case SIZE
    when 'large'
      Rails.root.join('fixtures', 'large.json')
    when 'medium'
      Rails.root.join('fixtures', 'medium.json')
    else
      Rails.root.join('fixtures', 'small.json')
    end

  JSONImporter.new.call(path)
end

# RSS - Resident Set Size
# объём памяти RAM, выделенной процессу в настоящее время
def with_rss
  rss = -> { `ps -o rss= -p #{Process.pid}`.to_i / 1024 }
  display_rss = ->(usage) { "%d MB" % usage }

  rss_before = rss.call

  puts "RSS before: #{display_rss.call(rss_before)}"

  yield

  rss_after = rss.call
  puts "RSS after: #{display_rss.call(rss_after)} (#{display_rss.call(rss_after - rss_before)})"
end

def with_gc_off
  GC.disable
  yield
  GC.enable
end

class GCSuite
  def warming(*)
    run_gc
  end

  def running(*)
    run_gc
  end

  def warmup_stats(*)
  end

  def add_report(*)
  end

  private

  def run_gc
    GC.enable
    GC.start
    GC.disable
  end
end
