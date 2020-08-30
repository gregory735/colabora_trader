feature 'visitor open home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('Bem vindo ao Colabora Trader!')
  end
end