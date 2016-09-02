module PdfMerge
  class Folder < ApplicationRecord
    self.table_name = 'folders'

    belongs_to :parent_folder, class_name: 'Folder', foreign_key: :parent_folder_id, optional: true

    has_many :folders, foreign_key: :parent_folder_id, dependent: :destroy
    has_many :fyles, dependent: :destroy

    before_validation :set_parent_folder

    validates :path, presence: true

    def self.root
      find_by_path '.'
    end

    private

    def set_parent_folder
      return unless self.new_record? && path != '.'
      parent_path = File.dirname path
      self.parent_folder = Folder.find_or_create_by! path: parent_path
    end
  end
end
