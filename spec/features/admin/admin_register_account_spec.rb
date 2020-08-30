feature 'Admin sign up' do
  scenario 'successfully' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path

    expect(page).to have_content('Administrador: Grégory')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
  end

  scenario 'and is not an admin' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario')
    login_as(collaborator, scope: :collaborator)

    visit root_path

    expect(page).not_to have_content('Administrador: Grégory')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
  end
end
