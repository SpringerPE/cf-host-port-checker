get '/' do
  base_url = URI.parse(request.base_url)
  url = base_url.host
  @live_or_dev = !/(live|dev)/.match(url).nil? ? /(live|dev)/.match(url)[0] : url
  erb :index
end

post '/tcp' do
  host = params['host']
  port = params['port']
  redirect to("/tcp/#{host}/#{port}")
end

post '/url' do
  url = params['url']
  redirect to("/url/#{url}")
end

get '/tcp/:host/:port' do
  host = params['host']
  port = params['port']
  check = Checker.new
  if check.port_open?(host, port)
    flash[:true] = "Yes! I can reach #{host}:#{port}!"
  else
    flash[:false] = "Boohoo... I can't reach #{host}:#{port}."
    flash[:errors] = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
  end
  redirect to('/')
end

get '/url/:url' do
  url = params['url']
  check = Checker.new
  if check.url_exists?(url)
    flash[:true] = "Yes! I can reach #{url}!"
  else
    flash[:false] = "Boohoo... I can't reach #{url}."
    flash[:errors] = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
  end
  redirect to('/')
end