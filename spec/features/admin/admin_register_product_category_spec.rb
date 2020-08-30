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
end
