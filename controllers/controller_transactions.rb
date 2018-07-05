require('sinatra')
require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tagtype')
require('date')

SPENDING_LIMIT = 2000

get '/transactions' do
  @transactions = Transaction.all
  @tagtypes = TagType.all
  @display_total = Transaction.get_total_value()
  erb(:'transactions/index')
end

get '/transactions/breakdown' do
  @transactions = Transaction.all
  @tagtypes = TagType.all
  @display_total = Transaction.get_total_value()
  @total_values_by_tag_array = Transaction.get_total_values_by_tag()
  erb(:'transactions/breakdown')
end

get '/transactions/monthly' do
  @transactions = Transaction.all
  @display_total = Transaction.get_total_value()
  @monthly_totals = Transaction.get_spending_by_month()
  erb(:'transactions/monthly')
end

get '/transactions/annual' do
  @transactions = Transaction.all
  @display_total = Transaction.get_total_value()
  @annual_totals = Transaction.get_spending_by_year_and_month()
  erb(:'transactions/annual')
end

get '/transactions/new' do
  @merchants = Merchant.all
  @tagtypes = TagType.all
  erb(:'transactions/new')
end


post '/transactions' do
  Transaction.new(params).save
  @display_total = Transaction.get_total_value()

  if @display_total > SPENDING_LIMIT
    erb(:'transactions/warning')
  else
    redirect to '/transactions'
  end

end

get '/transactions/:id' do
  @transaction = Transaction.find(params['id'].to_i)
  @merchant = Merchant.find(@transaction.merchant_id)
  @tagtype = TagType.find(@transaction.tagtype_id)
  erb(:'transactions/show')
end

get '/transactions/:id/edit' do
  @merchants = Merchant.all
  @tagtypes = TagType.all
  @transaction = Transaction.find(params['id'].to_i)
  erb(:'transactions/edit')
end



post '/transactions/:id' do
  @transaction = Transaction.new(params)
  @transaction.update
  redirect to "/transactions/#{params['id']}"
end

post '/transactions/:id/delete' do
  @transaction = Transaction.find(params['id'].to_i)
  @transaction.delete
  redirect to '/transactions'
end
