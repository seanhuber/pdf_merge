require_dependency "pdf_merge/application_controller"

module PdfMerge
  class FolderController < ApplicationController
    def folder_tree_demo
      path = File.join params.require(:path).split(File::SEPARATOR)[1..-1]

      folder = path.present? ? Folder.find_by_path(path) : Folder.root

      render json: {folders: folder.folders.map{|f| File.basename(f.path)}, files: folder.fyles.map{|f| File.basename(f.path)}}
    end
  end
end
