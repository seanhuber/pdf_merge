require_dependency 'pdf_merge/application_controller'

module PdfMerge
  class BundledPdfController < ApplicationController
    def pdf
      pages = JSON.parse(params.require(:pages))
      pdf_paths = Fyle.pdf_paths pages.map{|pg| pg['fyle_id']}.uniq

      pdf = CombinePDF.new
      pages.each do |page|
        CombinePDF.load(pdf_paths[page['fyle_id']]).pages.each_with_index do |pdf_page, idx|
          pdf << pdf_page if page['page_num'] == idx+1
        end
      end

      send_data(pdf.to_pdf, filename: 'test.pdf', type: 'application/pdf', disposition: :inline)
    end
  end
end
