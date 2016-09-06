require_dependency 'pdf_merge/application_controller'

module PdfMerge
  class FyleController < ApplicationController
    def show
      path = File.join params.require(:path).split(File::SEPARATOR)[1..-1]
      @fyle = Fyle.find_by_path path
    end
  end
end
