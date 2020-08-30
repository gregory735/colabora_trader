feature 'Collaborator sign up' do
  scenario 'successfully' do
    visit root_path
    click_on 'Nova Conta'
    fill_in 'E-mail', with: 'greg@colaboratrader.com'
    fill_in 'Nome', with: 'Greg'
    fill_in 'Cpf', with: '310.208.020-06'
    fill_in 'Cargo', with: 'Diretor'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content('Você realizou seu registro com sucesso.')
    expect(page).to have_content('Greg')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
  end

  scenario 'and cpf must be unique' do
    Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                         password: '123456', cpf: '310.208.020-06', position: 'Estagiario')

    visit root_path
    click_on 'Nova Conta'
    fill_in 'E-mail', with: 'gregory@colaboratrader.com'
    fill_in 'Nome', with: 'Greg'
    fill_in 'Cpf', with: '310.208.020-06'
    fill_in 'Cargo', with: 'Diretor'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content('Cpf já está em uso')
    expect(page).to have_content('Nova conta')
    expect(page).to have_content('Não foi possível salvar collaborador')
    expect(page).to have_link('Voltar')
  end

  scenario 'and cpf must be valid' do
    visit root_path
    click_on 'Nova Conta'
    fill_in 'E-mail', with: 'greg@colaboratrader.com'
    fill_in 'Nome', with: 'Greg'
    fill_in 'Cpf', with: '1111'
    fill_in 'Cargo', with: 'Diretor'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content('Cpf deve ser válido')
  end

  scenario 'and email must be unique' do
    Collaborator.create!(name: 'Grégory', email: 'gregory@colaboratrader.com',
                         password: '123456', cpf: '310.208.020-06', position: 'Estagiario')

    visit root_path
    click_on 'Nova Conta'
    fill_in 'E-mail', with: 'gregory@colaboratrader.com'
    fill_in 'Nome', with: 'Greg'
    fill_in 'Cpf', with: '188.348.410-34'
    fill_in 'Cargo', with: 'Diretor'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content('E-mail já está em uso')
    expect(page).to have_content('Nova conta')
    expect(page).to have_content('Não foi possível salvar collaborador')
    expect(page).to have_link('Voltar')
  end

  scenario 'and both cpf, email must be unique' do
    Collaborator.create!(name: 'Grégory', email: 'gregory@colaboratrader.com',
                         password: '123456', cpf: '310.208.020-06', position: 'Estagiario')

    visit root_path
    click_on 'Nova Conta'
    fill_in 'E-mail', with: 'gregory@colaboratrader.com'
    fill_in 'Nome', with: 'Greg'
    fill_in 'Cpf', with: '310.208.020-06'
    fill_in 'Cargo', with: 'Diretor'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content('E-mail já está em uso')
    expect(page).to have_content('Cpf já está em uso')
    expect(page).to have_content('Nova conta')
    expect(page).to have_content('Não foi possível salvar collaborador')
    expect(page).to have_link('Voltar')
  end

  scenario 'and filds cannot be blank' do
    visit root_path
    click_on 'Nova Conta'
    click_on 'Registrar'

    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Cpf não pode ficar em branco')
    expect(page).to have_content('Cargo não pode ficar em branco')
    expect(page).to have_content('Não foi possível salvar collaborador')
    expect(page).to have_link('Voltar')
  end
end
