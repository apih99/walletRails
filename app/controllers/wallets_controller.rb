class WalletsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @transactions = current_user.transactions.order(created_at: :desc)
    end
  
    def update
      amount = params[:amount].to_d
      service = TopUpService.new(current_user, amount)
  
      if service.call
        redirect_to wallet_path, notice: "Successfully topped up your wallet!"
      else
        @transactions = current_user.transactions.order(created_at: :desc)
        flash.now[:alert] = "Top-up failed. Please enter a valid amount."
        render :show, status: :unprocessable_entity
      end
    end
  end