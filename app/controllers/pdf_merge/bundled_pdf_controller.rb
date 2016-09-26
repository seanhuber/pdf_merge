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

    def save
      # ap (params.to_unsafe_h)
      sections = sections_params params
      # ap sections
      head :ok
    end

    private

    def sections_params params
      params.require(:sections).values.map do |section|
        section_h = {name: section['name']}
        section_h[:pages] = section['pages'].values.map do |page|
          {
            fyle_id:  page['fyle_id'].to_i,
            page_num: page['page_num'].to_i
          }
        end
        section_h
      end
    end
  end
end
