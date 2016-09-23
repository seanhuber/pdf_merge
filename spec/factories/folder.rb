FactoryGirl.define do
  factory :root_folder, class: 'PdfMerge::Folder' do
    path '.'
  end
end
