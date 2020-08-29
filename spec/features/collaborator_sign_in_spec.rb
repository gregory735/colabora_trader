feature 'collaborator sign in' do
  scenario 'from home page' do
    visit root_path

    expect(page).to have_link('Nova Conta')
    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    Collaborator.create!(name: 'Grégory', email: 'gregory@colaboratrader.com',
                 password: '123456', cpf: '310.208.020-06')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'gregory@colaboratrader.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(page).to have_content('Grégory')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('Sair')
    expect(page).not_to have_content('Entrar')
  end

  scenario 'and fields are blank' do
    Collaborator.create!(name: 'Grégory', email: 'gregory@colaboratrader.com',
                 password: '123456', position: 'estagiario')

    visit root_path
    click_on 'Entrar'
    click_on 'Entrar'

    expect(page).to have_content('E-mail ou senha inválidos')
  end
end
