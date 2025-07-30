class ProductSyncWorker
    include Sidekiq::Worker

    def perform
        Rails.logger.info "Starting Product Sync Job..."

        response = HTTParty.get("https://fakestoreapi.com/products")

        if response.success?
            products = JSON.parse(response.body)
            products.each do |product_data|
                Product.find_or_initialize_by(name: product_data['title']).update!(
                    price: product_data['price'],
                )
            end
            Rails.logger.info "Product Sync Job finished successfully. Synced #{products.count} products."
        else
            Rails.logger.error "Failed to fetch products from API. Status: #{response.code}"

        end
    end
end