class ProductCategoriesController < ApplicationController
  before_action :check_administrator
  before_action :set_product_category, only: [:show, :edit, :update]
  before_action :authenticate_collaborator!

  def index
    @product_categories = ProductCategory.all
  end

  def show; end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to @product_category, notice: 'categoria registrada com sucesso!'
    else
      render :new
    end
  end

  def edit; end

  def update
    print "estou aqui"
    if @product_category.update(product_category_params)
      redirect_to @product_category
    else
      render :edit
    end
  end

  def check_administrator
    if collaborator_signed_in?
      if !(current_collaborator.admin)
        redirect_to root_path, notice: 'você não é administrador'
      end
    else
      redirect_to new_collaborator_session_path, notice: 'Você deve estar logado!'
    end
  end

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  private

  def product_category_params
    params.require(:product_category)
      .permit(:name)
  end
end
