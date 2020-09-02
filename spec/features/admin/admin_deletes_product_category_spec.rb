feature 'Admin deletes product category' do
  scenario 'successfully' do
    ProductCategory.create!(name: 'Eletrodomésticos')
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Ver categorias de produto'
    click_on 'Eletrodomésticos'
    click_on 'Apagar'

    expect(current_path).to eq product_categories_path
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and others categories still existing' do
    ProductCategory.create!(name: 'Eletrodomésticos')
    ProductCategory.create!(name: 'Veículos')
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Ver categorias de produto'
    click_on 'Eletrodomésticos'
    click_on 'Apagar'

    expect(current_path).to eq product_categories_path
    expect(page).not_to have_content('Eletrodomésticos')
    expect(page).to have_content('Veículos')
  end
end
