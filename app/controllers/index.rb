get '/' do
  # Look in app/views/index.erb
  erb :index
end


get '/login' do
  @user = "true"
  erb :login
end

get '/register' do 
  erb :register
end

post '/register' do
  puts params.inspect
  @user = User.new(params)
  if @user.save
    erb :register
  else
    @user[:not_registered] = true
    erb :register
  end
end

post '/login' do
  @user = User.authenticate(params)
  if @user.nil?
    erb :login
  else
    erb :secret
  end
end
