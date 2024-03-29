module Api::V1
  class ProductsController < ApiController
    before_action :set_product, only: [:show, :update, :destroy]

    # GET /products
    def index
      if search_params.empty?
        @products = Product.all
      else
        @products = Product.search(search_params.to_unsafe_h)
      end
      render json: @products
    end

    # GET /products/1
    def show
      render json: @product
    end

    # POST /products
    def create
      @product = Product.new(product_params)
      if @product.save
        render json: @product, status: :created, location: v1_product_url(@product.slug)
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /products/1
    def update
      if @product.update(product_params)
        render json: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    # DELETE /products/1
    def destroy
      @product.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.friendly.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def product_params
        allowed_attrs = %i[name description available_on slug
                           meta_description meta_keywords price categories]
                           .concat(Product.content_attributes.keys)
        params.require(:product).permit(*allowed_attrs)
      end

      # Only allow a trusted parameter "white list" through.
      def search_params
        allowed_attrs = %i[name categories]
        params.permit(*allowed_attrs)
      end
  end
end