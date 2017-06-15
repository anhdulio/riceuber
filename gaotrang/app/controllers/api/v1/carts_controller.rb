module Api::V1
  class CartsController < ApiController
    before_action :set_cart, only: [:show, :update, :destroy]
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
        if @cart.products.find_by_id(cart_params[:cart_line][:product_id])
          cart_line = CartLine.find(cart_params[:cart_line][:id])
          cart_line.quantity += 1
        else
          cart_line = CartLine.new(cart_params[:cart_line])
        end
      when 'remove'
        cart_line = CartLine.find(cart_params[:cart_line][:id])
        cart_line.destroy
      when 'update'
        cart_line = CartLine.find(cart_params[:cart_line][:id])
        cart_line.quantity = cart_params[:cart_line][:quantity]
      else
        render json: {message: 'invalid action'}, status: :unprocessable_entity and return
      end

      if cart_line.save
        @cart.update_total
        render json: @cart
      else
        render json: @cart.errors, status: :unprocessable_entity
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

      # Only allow a trusted parameter "white list" through.
      def search_params
        allowed_attrs = %i[name categories]
        params.permit(*allowed_attrs)
      end
  end
end