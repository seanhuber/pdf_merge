module PdfMerge
  describe Fyle do

    describe 'path methods' do
      let(:fyle) { FactoryGirl.build :fyle }

      before :each do
        allow_any_instance_of(Fyle).to receive(:set_folder).and_return(nil)
      end

      it 'has a remote-relative path' do
        remote_store = PdfMerge.remote_store
        PdfMerge.remote_store = '/remote/store/path/this_is_root_dir'
        expect(fyle.remote_relative_path).to eql('this_is_root_dir/path/to/some/file.pdf')
        PdfMerge.remote_store = remote_store
      end
    end

    describe 'folder assignment' do
      let(:fyle) { FactoryGirl.build :fyle }

      it 'generates folder records' do
        fyle.save!
        [
          '.',
          'path',
          'path/to',
          'path/to/some'
        ].each do |path|
          expect(Folder.where(path: path)).to exist
        end
      end
    end
  end
end
