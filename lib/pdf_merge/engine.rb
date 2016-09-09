module PdfMerge
  class Engine < ::Rails::Engine
    isolate_namespace PdfMerge

    config.to_prepare do
      PdfMerge.local_store     ||= File.expand_path Rails.root.join('..', 'pdf_merge_store')
      PdfMerge.doc_pdf_dir     ||= File.join PdfMerge.local_store, 'doc_pdfs'
      PdfMerge.images_dir      ||= File.join PdfMerge.local_store, 'images'
      PdfMerge.page_image_size ||= 1500
      PdfMerge.thumbnail_size  ||= 150
    end
  end

  mattr_accessor :doc_pdf_dir
  @@doc_pdf_dir = nil

  mattr_accessor :images_dir
  @@images_dir = nil

  mattr_accessor :local_store
  @@local_store = nil

  mattr_accessor :page_image_size
  @@page_image_size = nil

  mattr_accessor :remote_store
  @@remote_store = nil

  mattr_accessor :thumbnail_size
  @@thumbnail_size = nil

  def self.setup
    yield self

    Rails.application.config.middleware.use Rack::Static, urls: ["/images/#{File.basename(remote_store)}"], root: local_store
    # http://localhost:3000/images/files/olympus.pdf/1000_2.png
  end
end
