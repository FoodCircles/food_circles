PDFKit.configure do |config|

  config.wkhtmltopdf ='/usr/local/bin/wkhtmltopdf'
  config.default_options = {
      :encoding=>"UTF-8",
      :page_size=>"Letter",
      :disable_smart_shrinking=>false
  }
end