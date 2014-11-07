get '/' do
  erb :index
end

post '/tcp' do
  host = params['host']
  port = params['port']
  redirect to("/check?host=#{host}&port=#{port}")
end

post '/url' do
  url = params['url']
  redirect to("/check?url=#{url}")
end

get '/check' do
  url = params[:url]
  host = params[:host]
  port = params[:port]
  connect_to_correct_checker(url, host, port)
  erb :index
end

