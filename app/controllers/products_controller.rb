class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_collaborator!

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
    @product_categories = ProductCategory.all
  end

  def create
    @product = Product.create(product_params)
    @product.collaborator = current_collaborator
    if @product.save
      redirect_to @product, notice: 'Produto registrado com sucesso!'
    else
      render :new
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product)
      .permit(:start_date, :end_date, :collaborator_id, 
        :product_category_id, :price, :amount, :name, :condition)
  end
end