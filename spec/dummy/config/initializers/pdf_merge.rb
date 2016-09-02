PdfMerge.setup do |config|
  if Rails.env.test?
    config.local_store = File.expand_path('../../../../local_store', __FILE__)
    config.remote_store = File.expand_path('../../../../sample_remote_store', __FILE__)
  else
    config.local_store = '/Users/seanhuber/Documents/pdfb2/simple_structure/app_managed'
    config.remote_store = '/Users/seanhuber/Documents/pdfb2/simple_structure/files'
  end
end
