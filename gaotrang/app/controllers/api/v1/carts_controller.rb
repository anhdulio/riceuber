module Api::V1
  class CartsController < ApiController
    before_action :set_cart, only: [:show, :update, :destroy, :checkout]
    rescue_from ActiveRecord::RecordNotFound, :with => :update
    # GET /carts/1
    def show
      render json: @cart
    end

    # POST /carts
    def create
      @cart = Cart.new
      if @cart.save
        render json: {cart_id: @cart.id}, status: :created
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /carts/1
    def update
      case cart_params[:cart_action]
      when 'add'
        product_id = cart_params[:cart_line][:product_id]
        if @cart.products.find_by_id(product_id)
          cart_line = @cart.cart_lines.find_by_product_id(product_id)
          cart_line.quantity += 1
        else
          cart_line = CartLine.new(cart_params[:cart_line])
          cart_line.quantity = 1
        end
      when 'remove'
        cart_line = CartLine.find(cart_params[:cart_line][:id])
        cart_line.destroy
      when 'update'
        cart_line = CartLine.find(cart_params[:cart_line][:id])
        cart_line.quantity = cart_params[:cart_line][:quantity]
        cart_line.price = cart_params[:cart_line][:price]
      else
        render json: { message: 'invalid action' }, status: :unprocessable_entity and return
      end

      if cart_line.save
        render json: @cart
      else
        render json: @cart.errors, status: :unprocessable_entity
      end

    end

    def checkout
      if @cart.order
        render json: {message: 'cart has been checked out'}, status: :unprocessable_entity
      else
        user = User.new(user_params)
        billing_address = Address.new(address_params('billing'))
        billing_address.type = 'billing'
        shipping_address = Address.new(address_params('shipping'))
        shipping_address.type = 'shipping'
        @order = Order.new(adjustment: 0, state: 'open')
        @order.addresses << billing_address
        @order.addresses << shipping_address
        @order.cart = @cart
        @order.user = user
        if @order.save
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end
    end

    # DELETE /carts/1
    def destroy
      @cart.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_cart
        @cart = Cart.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def cart_params
        params.permit(:cart_action, cart_line: %i[id product_id cart_id quantity price])
      end

      #Params for order
      def user_params
        params.require(:user).permit(:name, :email)
      end

      def address_params(address_type)
        case address_type
        when 'billing'
          params.require(:billing_address).permit(%i[first_name last_name company_name line_1 line_2])
        when 'shipping'
          params.require(:shipping_address).permit(%i[first_name last_name company_name line_1 line_2 instruction])
        else
        end
      end

      # Only allow a trusted parameter "white list" through.
      def search_params
        allowed_attrs = %i[name categories]
        params.permit(*allowed_attrs)
      end
  end
end