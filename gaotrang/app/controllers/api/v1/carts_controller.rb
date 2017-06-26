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
      @cart = Cart.new()

      if cart_params[:cart_lines]
        cart_params[:cart_lines].each do |line|
          @cart.cart_lines << CartLine.new(line)
        end
      end

      if @cart.save
        render json: @cart, status: :created
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /carts/1
    def update
      if cart_params[:cart_lines]
        if cart_params[:cart_lines].size != 0
          @cart.cart_lines.delete(@cart.cart_lines)
          cart_params[:cart_lines].each do |line|
            @cart.cart_lines << CartLine.new(line)
          end
        end
      end
      if @cart.save
        render json: @cart, status: :created
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    end

    def checkout
      if @cart.order
        render json: {message: 'cart has been checked out'}, status: :unprocessable_entity
      else
        user = User.new(user_params)
        @order = Order.new(adjustment: 0, state: 'open')
        byebug
        address_params[:addresses].each do |address|
          address[:type] = address[:type].classify
          @order.addresses << Address.new(address)
        end

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
        params.permit(cart_lines: %i[product_id quantity price])
      end

      #Params for order
      def user_params
        params.require(:user).permit(:name, :email)
      end

      def address_params
        params.permit(addresses: %i[first_name last_name company_name line_1 line_2 type instruction])
      end

      # Only allow a trusted parameter "white list" through.
      def search_params
        allowed_attrs = %i[name categories]
        params.permit(*allowed_attrs)
      end
  end
end