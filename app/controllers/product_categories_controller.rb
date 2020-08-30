class ProductCategoriesController < ApplicationController
  before_action :check_administrator
  before_action :set_product_category, only: [:show]
  before_action  :authenticate_collaborator!

  def index
    @product_categories = ProductCategory.all
  end

  def show; end

  def new
    if !(current_collaborator.admin)
      redirect_to root_path, notice: 'você não é administrador'
    end
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

  def check_administrator
    if !(current_collaborator.admin)
      redirect_to root_path, notice: 'você não é administrador'
    end
  end

  def set_product_category
    @product_category= ProductCategory.find(params[:id])
  end

  private

  def product_category_params
    params.require(:product_category)
      .permit(:name)
  end
end