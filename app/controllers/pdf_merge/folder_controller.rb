require_dependency 'pdf_merge/application_controller'

module PdfMerge
  class FolderController < ApplicationController
    def show
      path = File.join params.require(:path).split(File::SEPARATOR)[1..-1]

      folder = path.present? ? Folder.find_by_path(path) : Folder.root

      ret_h = {folders: folder.folders.map{|f| File.basename(f.path)}}
      ret_h.merge!({files: folder.fyles.map{|f| File.basename(f.path)}}) unless params[:hide_fyles].present?

      render json: ret_h
    end
  end
end
