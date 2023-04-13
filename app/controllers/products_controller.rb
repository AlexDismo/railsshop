class ProductsController < ApplicationController
  before_action :admin?, only: [:new, :create, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def index
    @products = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_item
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    session[:cart] ||= {}

    if session[:cart].has_key?(product.name)
      session[:cart][product.name]["quantity"] += quantity
    else
      session[:cart][product.name] = { "name" => product.name, "quantity" => quantity }
    end

    redirect_to carts_path
  end






  private

  private def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def admin?
    current_user && current_user.role == 'admin'
  end

  helper_method :admin?
end
