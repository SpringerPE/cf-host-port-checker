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
  check = Checker.new
  if (!url.nil? && !url.empty?)
    if check.url_exists?(url)
      flash[:true] = "Yes! I can reach #{url}!"
    else
      flash[:false] = "Boohoo... I can't reach #{url}."
      flash[:errors] = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
    end
  elsif (!host.nil? && !host.empty?) && (!port.nil? && !port.empty?)
    if check.port_open?(host, port)
      flash[:true] = "Yes! I can reach #{host}:#{port}!"
    else
      flash[:false] = "Boohoo... I can't reach #{host}:#{port}."
      flash[:errors] = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
    end
  else
    flash[:errors] = "Stop trying to defeat the system. Put your queries right."
  end
  erb :index
end

