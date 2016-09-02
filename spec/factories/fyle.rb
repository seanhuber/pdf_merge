FactoryGirl.define do
  factory :fyle, class: 'PdfMerge::Fyle' do
    path 'path/to/some/file.pdf'
  end
end
