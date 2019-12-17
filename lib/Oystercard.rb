class Oystercard
  attr_accessor :balance, :limit

#   def balance
#     @balance
#   end
    # def balance=(value)
    #   @balance = value
    # end


  def initialize(balance: 0, limit: 90)
    @balance = balance
    @limit = limit
  end

  def top_up(amount)
    fail "Balance can't be over 90" if balance > 90
    if @balance + amount > 90
      return
    else
      @balance += amount
    end
  end



end