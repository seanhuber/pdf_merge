feature 'Build pdf' do
  let!(:root_folder) { FactoryGirl.create :root_folder }
  let!(:fyle1) { FactoryGirl.create :fyle, folder_id: root_folder.id, path: 'aaa.pdf', num_pages: 1, thumb_dimensions: {1 => [116, 150]} }

  before(:all) do
    FileUtils.mv Rails.root.join('..', 'local_store_backup'), Rails.root.join('..', 'local_store')
  end

  after(:all) do
    FileUtils.mv Rails.root.join('..', 'local_store'), Rails.root.join('..', 'local_store_backup')
  end

  scenario 'clicking a file', js: true do
    visit pdf_merge_path

    within ".right-pane > .fyle-overview[data-fyle-id='#{fyle1.id}']" do
      click_on 'View/Select Page(s)'
    end

    within ".thumbs li[data-page-num='1']" do
      check 'page'
    end

    within '.thumbs .buttons' do
      click_on 'Add Selected Page(s)'
    end

    # binding.pry
    expect(page).to have_content('Which section do you want to add the 1 selected page(s) to?')

    within '#selections_modal form' do
      fill_in 'new_section', with: 'First Section'
    end

    within '#selections_modal .modal-footer' do
      click_on 'Save'
    end

    pdf_window = nil
    within 'nav.navbar' do
      within '.bundle-details' do
        expect(page).to have_content('1 section(s) totaling 1 page(s).')
      end

      click_on 'Tools'
      pdf_window = window_opened_by { click_on 'Build PDF' }
    end

    # only works in selenium: https://github.com/teampoltergeist/poltergeist/issues/561
    # within_window pdf_window do
    #   convert_pdf_to_page
    #   expect(page).to have_content('Emerald')
    # end
  end
end

def convert_pdf_to_page
  temp_pdf = Tempfile.new('pdf')
  temp_pdf << page.source.force_encoding('UTF-8')
  reader = PDF::Reader.new(temp_pdf)
  pdf_text = reader.pages.map(&:text)
  temp_pdf.close
  page.driver.response.instance_variable_set('@body', pdf_text)
end
