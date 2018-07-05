require('sinatra')
require_relative('../models/tagtype')

get '/tagtypes' do
  @tagtypes = TagType.all
  erb(:'tagtypes/index')
end

get '/tagtypes/new' do
  erb(:'tagtypes/new')
end

post '/tagtypes' do
  @tagtype_exists = TagType.find_by_type(params['type'])
  if @tagtype_exists != nil
    erb(:'tagtypes/tagtype_found')
  else
    TagType.new(params).save
    redirect to '/tagtypes'
  end
end

get '/tagtypes/:id' do
  @tagtype = TagType.find(params['id'].to_i)
  erb(:'tagtypes/show')
end

get '/tagtypes/:id/edit' do
  @tagtype = TagType.find(params['id'].to_i)
  erb(:'tagtypes/edit')
end

post '/tagtypes/:id' do
    @tagtype = TagType.new(params)
    @tagtype.update
    redirect to "/tagtypes/#{params['id']}"
end

post '/tagtypes/:id/delete' do
  @tagtype = TagType.find(params['id'].to_i)
  @tagtype.delete
  redirect to '/tagtypes'
end
