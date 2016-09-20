module PdfMerge
  class Fyle < ApplicationRecord
    self.table_name = 'fyles'

    serialize :thumb_dimensions, JSON

    belongs_to :folder

    before_validation :set_folder

    validates :path, presence: true

    def self.imagify remote_relative_path
      file = find_or_create_by! path: File.join(remote_relative_path.split(File::SEPARATOR)[1..-1])
      file.update_columns num_pages: nil, thumb_dimensions: nil
      ImagifyJob.perform_later file.id
    end

    def name
      File.basename path
    end

    # TODO: DRY with ImagifyJob and FyleHelper
    def pdf_path
      if DocPdf.doc? path
        File.join PdfMerge.doc_pdf_dir, File.basename(PdfMerge.remote_store), File.dirname(path), File.basename(path, '.*')+'.pdf'
      else
        File.join PdfMerge.local_store, File.basename(PdfMerge.remote_store), path
      end
    end

    def self.pdf_paths fyle_ids
      where(id: fyle_ids).map{|fyle| [fyle.id, fyle.pdf_path]}.to_h
    end

    def remote_relative_path
      File.join File.basename(PdfMerge.remote_store), path
    end

    private

    def set_folder
      return unless self.new_record?
      self.folder = Folder.find_or_create_by! path: File.dirname(path)
    end
  end
end
