get '/' do
  erb :index
end

post '/' do
  host = params['host']
  port = params['port']
  check = Checker.new
  if check.url_exists?(host, port)
    flash[:notice] = "Yes #{host}:#{port} does exist!"
  else
    flash[:notice] = "Boohoo I can't find #{host}:#{port}!"
  end
  redirect to('/')
end