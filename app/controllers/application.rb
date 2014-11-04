get '/' do
  erb :index
end

post '/tcp' do
  host = params['host']
  port = params['port']
  check = Checker.new
  if check.port_open?(host, port)
    flash[:true] = "Yes! I can reach #{host}:#{port}!"
  else
    flash[:false] = "Boohoo... I can't reach #{host}:#{port}."
  end
  redirect to('/')
end

post '/url' do
  url = params['url']
  check = Checker.new
  if check.url_exists?(url)
    flash[:true] = "Yes! I can reach #{url}!"
  else
    flash[:false] = "Boohoo... I can't reach #{url}."
  end
  redirect to('/')
end