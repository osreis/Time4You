class Cashier < ActiveRecord::Base
  attr_accessible :initial_amount, :closed, :opened

  def open initial_amount
  	puts 'open'
  	if initial_amount > 0.0 and !self.opened
  		self.initial_amount = initial_amount
		self.opened			= Date.today
		self.save!
  	end
  end

  def close
  	if self.opened and !self.closed
  		self.closed = Date.today
  		self.save
  	end
  end

  def current_balance
  	total_sum = 0.0
    payment_type_sums = {}
    PaymentType.all.each do |payment_type|
      payment_type_sums.merge!({payment_type.id.to_s => 0})
    end
  	if self.opened
  		orders 	= Order.where(created: self.opened, status: "CONF")
  		orders.each do |o|
  			amount 		 = o.consumerAmount.to_f
  			total_sum 	+= amount
  			payment_type_id = o.payment_types.first.id.to_s
  			payment_type_sums[payment_type_id] += amount 
  		end
  	end
    dinheiro_id = PaymentType.find_or_create_by_name("Dinheiro", discount: 20.0).id.to_s
    payment_type_sums[dinheiro_id] += self.initial_amount
  	{
  		total: self.initial_amount + total_sum,
  		payment_type_sums: payment_type_sums
  	}
  end

end
