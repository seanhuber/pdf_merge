PdfMerge::Engine.routes.draw do
  root 'folder#index'
  post 'bundled_pdf/pdf'  => 'bundled_pdf#pdf'
  post 'bundled_pdf/save' => 'bundled_pdf#save'
  get  'folder/show'      => 'folder#show'
  get  'fyle/show'        => 'fyle#show'
  get  'fyle/thumbs'      => 'fyle#thumbs'
end
