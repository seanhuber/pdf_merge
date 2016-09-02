module PdfMerge
  describe Fyle do
    let(:fyle) { FactoryGirl.build :fyle }

    describe 'path methods' do
      before :each do
        allow_any_instance_of(Fyle).to receive(:set_folder).and_return(nil)
      end

      it 'has a remote-relative path' do
        PdfMerge.remote_store = '/remote/store/path/this_is_root_dir'
        expect(fyle.remote_relative_path).to eql('this_is_root_dir/path/to/some/file.pdf')
      end
    end

    describe 'folder assignment' do
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
