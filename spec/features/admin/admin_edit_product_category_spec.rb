feature 'Admin edir product category' do
  scenario 'successfully' do
    ProductCategory.create!(name: 'Eletrodomésticos')
    ProductCategory.create!(name: 'Veículos')
    collaborator = Collaborator.create!(name: 'Grégory', email: 'greg@colaboratrader.com',
                                        password: '123456', cpf: '310.208.020-06',
                                        position: 'Estagiario', admin: true)
    login_as(collaborator, scope: :collaborator)

    visit root_path
    click_on 'Ver categorias de produto'
    click_on 'Eletrodomésticos'
    click_on 'Editar'
    fill_in 'Nome da categoria', with: 'Para sua casa'
    click_on 'Editar'

    expect(page).to have_content('Para sua casa')
    expect(page).not_to have_content('Eletrodomésticos')
  end
end
