require_dependency 'pdf_merge/application_controller'

module PdfMerge
  class BundledPdfController < ApplicationController
    def pdf
      # TODO: implement
      ap JSON.parse(params.require(:sections))
      head :ok
    end
  end
end
