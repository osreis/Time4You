class CashiersController < ApplicationController
  def index
  	if !params[:date]
  		@date = Date.today
  	else
		@date = Date.new(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i)
  	end
  	@cashier = Cashier.where(opened: @date).first
  end

  def new
  	initial_amount = params[:cashier][:initial_amount].to_f
  	@cashier = Cashier.new
  	@cashier.open initial_amount
  	redirect_to '/cashiers'
  end

  def close
  	@cashier = Cashier.find(params[:id])
  	@cashier.close if @cashier
  	redirect_to '/cashiers'
  end

end
