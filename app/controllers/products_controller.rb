class ProductsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @products = Product.all.order(:name)
    end
    
    def purchase
      product = Product.find(params[:id])
      service = PurchaseService.new(current_user, product)
  
      if service.call
        redirect_to root_path, notice: "Successfully purchased #{product.name}"
      else
        redirect_to root_path, alert: "Purchase failed. Do you have enough credit?"
      end
    end
end
  