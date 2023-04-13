class CartsController < ApplicationController
  def index
    @cart_items = session[:cart] || {}
  end
  def remove_item
    product_id = params[:product_id]
    session[:cart].delete(product_id)
    redirect_to carts_path
  end

  def clear_cart
    session[:cart] = {}
    redirect_to carts_path
  end

  def cart_total
    session[:cart].values.map { |product| product['quantity'].to_i }.sum
  end

  def checkout
    @order = current_user.orders.new(amount: cart_total)
    if @order.save
      session[:cart].each do |product_id, product_info|
        item = Product.where(name: product_info['name']).first
        quantity = product_info["quantity"]
        @order.order_descriptions.create(product_id: item.id, quantity: quantity, order_id: @order.id)

      end
      session[:cart] = {}
      redirect_to products_path
    else
      render 'checkout_error'
    end
  end

  def user_orders
    @orders = current_user.orders.includes(:order_descriptions)
  end

end
