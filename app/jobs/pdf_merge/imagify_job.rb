module PdfMerge
  class ImagifyJob < ApplicationJob
    queue_as :default

    def perform fyle_id
      file = Fyle.find fyle_id
      file_path = file.remote_relative_path

      if DocPdf.doc? file_path
        pdf_root_dir = PdfMerge.doc_pdf_dir
        relative_pdf_path = DocPdf.convert_single!(File.join(PdfMerge.local_store, file_path))
      else
        pdf_root_dir = PdfMerge.local_store
        relative_pdf_path = file_path
      end
      num_pages = PdfThumbs.thumbnail_single! pdf_root_dir, relative_pdf_path

      thumb_dimensions = {}
      Dir.glob(File.join(PdfMerge.images_dir, file_path, '500_*.png')) do |thumbnail|
        thumb_dimensions[thumbnail.split('500_')[-1].split('.')[0]] = FastImage.size thumbnail
      end

      file.update_attributes! num_pages: num_pages, thumb_dimensions: thumb_dimensions
    end
  end
end
