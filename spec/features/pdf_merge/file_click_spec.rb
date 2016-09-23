feature 'Fyle click' do
  let!(:root_folder) { FactoryGirl.create :root_folder }
  let!(:fyle1) { FactoryGirl.create :fyle, folder_id: root_folder.id, path: 'aaa.pdf', num_pages: 3 }
  let!(:fyle2) { FactoryGirl.create :fyle, folder_id: root_folder.id, path: 'my_file.pdf', num_pages: 4 }

  before(:all) do
    FileUtils.mv Rails.root.join('..', 'local_store_backup'), Rails.root.join('..', 'local_store')
  end

  after(:all) do
    FileUtils.mv Rails.root.join('..', 'local_store'), Rails.root.join('..', 'local_store_backup')
  end

  scenario 'clicking a file', js: true do
    visit pdf_merge_path

    within 'nav.navbar > .bundle-details' do
      expect(page).to have_content('0 section(s) totaling 0 page(s).')
    end

    page.execute_script("$(\".left-pane li.file[data-path='./my_file.pdf'] > .basename\").trigger('click')");

    within ".right-pane > .fyle-overview[data-fyle-id='#{fyle2.id}']" do
      expect(page).to have_content(fyle2.path)
      expect(page).to have_content("#{fyle2.num_pages} Pages")
    end
  end
end
