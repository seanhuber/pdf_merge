module PdfMerge
  describe Fyle do
    describe 'path methods' do
      let(:fyle) { FactoryGirl.build_stubbed :fyle }

      before :each do
        allow_any_instance_of(Fyle).to receive(:set_folder).and_return(nil)
      end

      it 'has a remote-relative path' do
        PdfMerge.remote_store = '/remote/store/path/this_is_root_dir'
        expect(fyle.remote_relative_path).to eql('this_is_root_dir/path/to/some/file.pdf')
      end
    end
  end
end
