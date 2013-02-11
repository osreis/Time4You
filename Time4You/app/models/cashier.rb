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
  	total_sum, c_sum, d_sum, e_sum	= 0.0, 0.0, 0.0, 0.0
  	if self.opened
  		orders 	= Order.where(created: self.opened, status: "CONF")
  		orders.each do |o|
  			amount 		 = o.consumerAmount.to_f
  			total_sum 	+= amount
  			case o.payment_types.first.id
  			when 1 then c_sum += amount
  			when 2 then d_sum += amount
  			when 3 then e_sum += amount
  			end
  		end
  	end
  	{
  		total: self.initial_amount + total_sum,
  		c: c_sum,
  		d: d_sum,
  		e: e_sum + self.initial_amount
  	}
  end

end
