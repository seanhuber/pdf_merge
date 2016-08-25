Rails.application.routes.draw do
  mount PdfMerge::Engine => "/pdf_merge"
end
