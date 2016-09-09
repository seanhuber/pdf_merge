module PdfMerge
  describe Sync do
    it 'should sync a remote store to a local store' do
      FileUtils.rm_rf(PdfMerge.local_store) if File.directory?(PdfMerge.local_store)
      Sync.sync!

      expect(File).to exist(File.join(PdfMerge.local_store, 'sample_remote_store', 'olympus.pdf'))

      (1..3).each do |page_num|
        [1500, 150].each do |thumb_size|
          expect(File).to exist(File.join(PdfMerge.local_store, 'images', 'sample_remote_store', 'olympus.pdf', "#{thumb_size}_#{page_num}.png"))
        end
      end

      FileUtils.rm_rf(PdfMerge.local_store) if File.directory?(PdfMerge.local_store)
    end
  end
end
