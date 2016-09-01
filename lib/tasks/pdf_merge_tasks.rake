namespace :pdf_merge do
  desc 'syncs remote_store to local_store'
  task sync: :environment do
    ap ({
      local_store: PdfMerge.local_store,
      remote_store: PdfMerge.remote_store
    })
  end
end
