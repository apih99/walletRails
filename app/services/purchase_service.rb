class PurchaseService
    def initialize(user, product)
        @user = user
        @product = product
    end

    def call
        ActiveRecord::Base.transaction do
            raise "Insufficient funds" unless @user.credit >= @product.price

            @user.decrement!(:credit, @product.price)

            Transaction.create!(
                user: @user,
                action: "purchase",
                amount: @product.price,
                transactionable: @product
            )
        end
        true

    rescue StandardError => e
        Rails.logger.error "Purchase failed for user #{@user.id}: #{e.message}"
        false
    end
end