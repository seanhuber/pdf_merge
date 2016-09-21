feature 'Fyle click' do
  scenario 'clicking a file', js: true do
    visit '/pdf_merge'
    expect(page).to have_content('asdf')
    binding.pry
  end
end
