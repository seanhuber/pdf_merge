module PdfMerge
  class Engine < ::Rails::Engine
    isolate_namespace PdfMerge

    config.to_prepare do
      PdfMerge.local_store ||= File.expand_path Rails.root.join('..', 'pdf_merge_store')
    end
  end

  mattr_accessor :local_store
  @@local_store = nil

  mattr_accessor :remote_store
  @@remote_store = nil

  def self.setup
    yield self
  end
end
