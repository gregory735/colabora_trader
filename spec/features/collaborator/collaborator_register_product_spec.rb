feature 'Collaborator register product' do
  scenario 'Successfully' do
    ProductCategory.create!(name: 'Eletrônicos')
    ProductCategory.create!(name: 'Joias')
    ProductCategory.create!(name: 'Casa')
    ProductCategory.create!(name: 'Elefante')
    ProductCategory.create!(name: 'Cozinha')
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario')
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Colocar um produto à venda'
    select 'Eletrônicos', from: 'Categoria de produto'
    fill_in 'Produto', with: 'Processador intel I5 9º geração'
    fill_in 'Preço', with: '100'
    fill_in 'Quantidade', with: '1'
    fill_in 'Condição', with: 'novo'
    fill_in 'Data inicio venda', with: '21/08/2030'
    fill_in 'Data fim venda', with: '21/09/2030'
    click_on 'Colocar à venda'

    expect(page).to have_content('Produto registrado com sucesso')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('1')
    expect(page).to have_content('Novo')
    expect(page).to have_content('Processador intel I5 9º geração')
    expect(page).to have_content('Eletrônicos')
    expect(page).to have_content('21/08/2030')
    expect(page).to have_content('21/09/2030')
  end

  scenario 'and field cannot be blank' do
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario')
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Colocar um produto à venda'
    click_on 'Colocar à venda'

    expect(page).to have_content('Categoria de produto é obrigatório(a)')
    expect(page).to have_content('Categoria de produto não pode ficar em branco')
    expect(page).to have_content('Produto não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content('Quantidade não pode ficar em branco')
    expect(page).to have_content('Condição não pode ficar em branco')
    expect(page).to have_content('Start date não pode ficar em branco')
    expect(page).to have_content('End date não pode ficar em branco')
  end

  scenario 'and if not logged cannot register product' do
    visit new_product_path

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end
end