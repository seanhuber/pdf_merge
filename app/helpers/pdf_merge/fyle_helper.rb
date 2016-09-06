module PdfMerge
  module FyleHelper
    def page_image fyle
      pdf_path = if DocPdf.doc? fyle.path
        File.join File.dirname(fyle.path), File.basename(fyle.path, '.*')+'.pdf'
      else
        fyle.path
      end
      image_tag "/images/files/#{pdf_path}/500_1.png"
    end
  end
end
