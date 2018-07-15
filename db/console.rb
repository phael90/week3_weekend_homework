require_relative('../model/customer')
require_relative('../model/film')
require_relative('../model/ticket')

require('pry-byebug')

customer1 = Customer.new(
  {'name' => 'Digory',
  'funds' => '200'
})

customer2 = Customer.new(
  {'name' => 'Daniel',
  'funds' => '150'
})

customer1.save()
customer2.save()



film1 = Film.new(
  {'title' => 'Pokemon',
  'price' => '10'
})

film2 = Film.new(
  {'title' => 'Everything is Illuminated',
  'price' => '8'
})

film1.save()
film2.save()



ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket1.save()
ticket2.save()
#
# p Film.all
# p Customer.all
# p Ticket.all
customer2.name = "Joanna"
customer2.update

film1.title = "Green Mile"
film1.price = "8"
film1.update

# customer1.delete
# film1.delete

# p customer1.films
p film1.customers

customer2.buy_ticket(film2)
p customer2.funds

p customer2.customers_tickets

p film2.number_of_customers
