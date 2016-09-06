PdfMerge::Engine.routes.draw do
  root 'folder#index'
  get 'folder/show' => 'folder#show'
  get 'fyle/show' => 'fyle#show'
end
