enable :sessions

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
  @user = User.new(params[:user])
  if @user.save
    erb :register
  else
    @user[:not_registered] = true
    erb :register
  end
end

post '/login' do
  @user = User.find_by_email(params[:user][:email])
    if @user.password == params[:user][:password]
      session[:user] = @user.id
      redirect('/secret')
    else
      erb :login
    end
  # @user = User.authenticate(params[:user])
  # puts params.inspect
  # if @user.nil?
  #   erb :login
  # else
  #   redirect '/secret'
  # end
end

get '/secret' do
  erb :secret
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end



