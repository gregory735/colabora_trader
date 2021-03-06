feature 'Admin sign up' do
  scenario 'successfully' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Registrar categoria de produto'
    fill_in 'Nome da categoria', with: 'Eletrodomésticos'
    click_on 'Cadastrar'

    expect(page).to have_content('categoria registrada com sucesso!')
    expect(page).to have_content('Eletrodomésticos')
  end

  scenario 'and product category must be unique' do
    ProductCategory.create!(name: 'Eletrodomésticos')
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Registrar categoria de produto'
    fill_in 'Nome da categoria', with: 'Eletrodomésticos'
    click_on 'Cadastrar'

    expect(page).to have_content('Nome da categoria já está em uso')
    expect(page).not_to have_content('categoria registrada com sucesso!')
    expect(current_path).to eq product_categories_path
  end

  scenario 'and field cannot be blank' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Registrar categoria de produto'
    click_on 'Cadastrar'

    expect(page).to have_content('Nome da categoria não pode ficar em branco')
    expect(page).not_to have_content('categoria registrada com sucesso!')
    expect(current_path).to eq product_categories_path
  end

  scenario 'and see all categories registred' do
    ProductCategory.create!(name: 'Eletrodomésticos')
    ProductCategory.create!(name: 'Carros')
    ProductCategory.create!(name: 'Joias')
    ProductCategory.create!(name: 'Jardinagem')
    ProductCategory.create!(name: 'Cosméticos')
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Ver categorias de produto'

    expect(page).to have_content('Eletrodomésticos')
    expect(page).to have_content('Carros')
    expect(page).to have_content('Joias')
    expect(page).to have_content('Jardinagem')
    expect(page).to have_content('Cosméticos')
  end

  scenario 'and no one category was registered' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Ver categorias de produto'

    expect(page).to have_content('Nenhuma categoria cadastrada')
    expect(page).not_to have_content('Carros')
    expect(page).not_to have_content('Joias')
    expect(page).not_to have_content('Jardinagem')
    expect(page).not_to have_content('Cosméticos')
  end

  scenario 'and common user cannot register category' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario')
    login_as(collaborator, scope: :collaborator)

    visit new_product_category_path

    expect(page).to have_content('você não é administrador')
    expect(current_path).to eq root_path
  end

  scenario 'and common user cannot see category' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario')
    login_as(collaborator, scope: :collaborator)

    visit product_categories_path

    expect(page).to have_content('você não é administrador')
    expect(current_path).to eq root_path
  end

  scenario 'and if not logged in cannot see category' do
    visit product_categories_path

    expect(page).to have_content('Você deve estar logado!')
    expect(current_path).to eq new_collaborator_session_path
  end
end
