module PdfMerge
  class Fyle < ApplicationRecord
    self.table_name = 'fyles'

    belongs_to :folder

    before_validation :set_folder

    validates :path, presence: true

    def self.imagify remote_relative_path
      file = find_or_create_by! path: File.join(remote_relative_path.split(File::SEPARATOR)[1..-1])
      file.update_column :num_pages, nil
      ImagifyJob.perform_later file.id
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
