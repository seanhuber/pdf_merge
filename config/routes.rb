PdfMerge::Engine.routes.draw do
  root 'folder#index'
  post 'bundled_pdf/pdf' => 'bundled_pdf#pdf'
  get  'folder/show'     => 'folder#show'
  get  'fyle/show'       => 'fyle#show'
  get  'fyle/thumbs'     => 'fyle#thumbs'
end
