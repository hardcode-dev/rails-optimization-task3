# frozen_string_literal: true
require 'diffy'
require 'addressable'

class PageChangesChecker
  DEFAULT_PAGE = '/автобусы/Самара/Москва'
  LATEST_PAGE_FILE_NAME = 'tmp/latest_page.html'

  attr_reader :page, :app

  def initialize(page: DEFAULT_PAGE)
    @page = page
    @app = ActionDispatch::Integration::Session.new(Rails.application)
  end

  def dump_page
    app.get url
    File.write(LATEST_PAGE_FILE_NAME, clean_up_html(app.response.body))
  end

  def check_page
    elapsed_time = Benchmark.realtime { app.get url }
    latest_page = File.read(LATEST_PAGE_FILE_NAME)
    new_page = clean_up_html(app.response.body)

    puts Diffy::Diff.new(latest_page, new_page).to_s(:html)
    puts '====================='
    puts "TIME: #{elapsed_time}"
  end

  private

  def url
    @url ||= Addressable::URI.parse("http://localhost:3000/#{page}").display_uri.to_s
  end

  def clean_up_html(html)
    doc = Nokogiri::HTML(html)
    doc.xpath("//script").remove
    doc.to_s
  end
end
