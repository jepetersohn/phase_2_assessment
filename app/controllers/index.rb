require "bcrypt"

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/signin' do
  if current_user
    @current_user = current_user
    @created_events = @current_user.created_events
    @all_events = Event.all
    erb :user_page
  else
    erb :signin
  end
end

post '/signup' do
  User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
end

post '/signin' do
  @current_user = User.find_by_email(params[:email])
  if @current_user.password == params[:password]
    session[:id] = @current_user.id
    @created_events = current_user.created_events
    @attended_events = current_user.attended_events
    @all_events = Event.all
    erb :user_page
  end
end

get '/logout' do
  session.clear
  redirect '/signin'
end

post '/event/new' do 
  start_time = Time.new(params[:starts_at])
  end_time = Time.new(params[:ends_at])
  @event = Event.create(user_id: current_user.id, name: params[:name], location: params[:location], starts_at: start_time, ends_at: end_time)
  return @event.name
end

post '/event/edit/:id' do 
  Event.update(params[:id], name: params[:name], location: params[:location], starts_at: params[:starts_at], ends_at: params[:ends_at])
  redirect '/signin'
end

get "/user/event/:id" do 
  @event = Event.find(params[:id])
  erb :user_event
end

get "/event/:id" do 
  @event = Event.find(params[:id])
  erb :event_page
end

get "/attend/:id" do
  EventUser.create(user_id: current_user.id, event_id: params[:id])
  redirect '/signin'
end
