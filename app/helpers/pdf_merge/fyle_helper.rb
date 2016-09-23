module PdfMerge
  module FyleHelper
    def page_image fyle, page_num, img_size, **opts
      pdf_path = if DocPdf.doc? fyle.path
        File.join File.dirname(fyle.remote_relative_path), File.basename(fyle.path, '.*')+'.pdf'
      else
        fyle.remote_relative_path
      end
      image_tag "/images/#{pdf_path}/#{img_size}_#{page_num}.png", opts
    end
  end
end
