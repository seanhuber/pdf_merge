PdfMerge::Engine.routes.draw do
  root 'folder#index'
  get 'demo/folder-tree' => 'folder#folder_tree_demo'
end
