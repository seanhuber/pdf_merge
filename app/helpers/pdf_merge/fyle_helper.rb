module PdfMerge
  module FyleHelper
    def page_image fyle, page_num, **opts
      pdf_path = if DocPdf.doc? fyle.path
        File.join File.dirname(fyle.path), File.basename(fyle.path, '.*')+'.pdf'
      else
        fyle.path
      end
      image_tag "/images/files/#{pdf_path}/500_#{page_num}.png", opts
    end
  end
end
