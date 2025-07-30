class InventoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @inventory_items = current_user.user_products.includes(:product).order('products.name')
  end
end