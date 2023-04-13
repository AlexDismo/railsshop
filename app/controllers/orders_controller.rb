class OrdersController < ApplicationController
  def new
    @order = current_user.order || current_user.create_order
  end

  def create
    @order = current_user.order || current_user.create_order

    product = Product.find(params[:product_id])
    @order.order_descriptions.create(product_id: product.id, quantity: 1)

    redirect_to orders_path, notice: 'Product added to cart'
  end
end
