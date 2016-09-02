namespace :pdf_merge do
  desc 'syncs remote_store to local_store'
  task sync: :environment do
    PdfMerge::Sync.sync!
  end
end
