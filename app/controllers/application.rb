
get '/' do
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
  erb :index
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
  erb :index
end

get '/check' do
  url = params[:url]
  host = params[:host]
  port = params[:port]
  check = Checker.new
  if !nil_or_empty(url)
    if check.url_exists?(url)
      @true = "Yes! I can reach #{url}!"
    else
      status 412
      @false = "Boohoo... I can't reach #{url}."
      @errors = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
    end
  elsif !nil_or_empty(host) && !nil_or_empty(port)
    if check.port_open?(host, port)
      @true = "Yes! I can reach #{host}:#{port}!"
    else
      status 412
      @false = "Boohoo... I can't reach #{host}:#{port}."
      @errors = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
    end
  else
    status 400
    @errors = "Stop trying to defeat the system. Put your queries right."
  end
  erb :index
end