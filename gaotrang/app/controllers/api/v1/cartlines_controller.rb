module Api::V1
  class CartlinesController < ApiController
    before_action :set_line, only: [:update, :destroy]
    before_action :set_cart, only: :create
    rescue_from ActiveRecord::RecordNotFound, :with => :create

    def create
      if @cart.products.find_by(id: cart_line_params[:product_id])
        cart_line = @cart.cart_lines.find_by_product_id(cart_line_params[:product_id])
        cart_line.quantity += 1
        cart_line.price = cart_line_params[:price]
        cart_line.save
      else
        @cart.cart_lines << CartLine.new(cart_line_params)
      end

      if @cart.save
        render json: @cart, status: :created
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @cart_line.destroy
        @cart.save
        render json: @cart
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    end

    def update
      @cart_line.quantity = cart_line_params[:quantity] if cart_line_params[:quantity]
      @cart_line.price = cart_line_params[:price] if cart_line_params[:price]
      if @cart_line.save
        @cart.save
        render json: @cart
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @cart = Cart.find(params[:cart_id])
      @cart_line = @cart.cart_lines.find_by_id(params[:id])
    end

    def set_cart
      @cart = Cart.find(params[:cart_id])
    end

    def cart_line_params
      params.require(:cart_line).permit(%i[product_id quantity price])
    end

  end
end
