namespace :pdf_merge do
  desc 'syncs remote_store to local_store'
  task sync: :environment do
    # --------- RESET structure -------------
    # simple_structure = '/Users/seanhuber/Documents/pdfb2/simple_structure'
    # FileUtils.rm_rf(simple_structure) if File.directory?(simple_structure)
    # FileUtils.cp_r '/Users/seanhuber/Documents/pdfb2/simple_structure_og', simple_structure
    # PdfMerge::Folder.root&.destroy
    # ---------------------------------------

    rsync = Rsync.new(
      src_dir: PdfMerge.remote_store,
      dest_dir: PdfMerge.local_store,
      include_extensions: [:doc, :docx, :pdf],
      log_dir: Rails.root.join('log')
    )

    DocPdf.configure doc_dir: PdfMerge.local_store, pdf_dir: PdfMerge.doc_pdf_dir

    PdfThumbs.configure img_dir: PdfMerge.images_dir, thumb_sizes: [1000, 500]

    rsync.sync! do |file_path, new_file|
      PdfMerge::Fyle.imagify file_path
    end
  end
end
