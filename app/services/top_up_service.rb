class TopUpService
    def initialize(user, amount)
      @user = user
      @amount = amount.to_d 
    end
  
    def call
      raise "Top-up amount must be positive" unless @amount > 0
  
      ActiveRecord::Base.transaction do
        @user.increment!(:credit, @amount)
  
        Transaction.create!(
          user: @user,
          action: 'top-up',
          amount: @amount
        )
      end
      true
    rescue StandardError => e
      Rails.logger.error "Top-up failed for user #{@user.id}: #{e.message}"
      false
    end
  end