class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    # binding.pry
    if User.find_by(email: params[:email], password: params[:password])
      # erb ''
    else
      user = User.create(params)
      session[:id] = user.id
      redirect '/users/home'
    end
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    # binding.pry
    if user = User.find_by(params)
      session[:id] = user.id
      @session = session
      binding.pry
      redirect '/users/home'
    else
      redirect 'sessions/login'
    end

  end

  get '/sessions/logout' do

    redirect '/'
  end

  get '/users/home' do

    erb :'/users/home'
  end

end
