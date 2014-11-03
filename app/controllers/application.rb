get '/' do
  erb :index
end

post '/' do
  host = params['host']
  port = params['port']
  check = Checker.new
  if check.url_exists?(host, port)
    flash[:true] = "Yes! I can reach #{host}:#{port}!"
  else
    flash[:false] = "Boohoo... I can't reach #{host}:#{port}."
  end
  redirect to('/')
end