class Checker

  def port_open?(ip, port, seconds=1)
    Timeout::timeout(seconds) do
      begin
        TCPSocket.new(ip, port).close
        true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        false
      end
    end
  rescue Timeout::Error, SocketError
    false
  end

  def url_exists?(url_string)
    url = URI.parse(url_string)
    request = Net::HTTP.new(url.host, url.port)
    request.use_ssl = (url.scheme == 'https')
    path = !url.path.empty? ? url.path : '/'
    response = request.request_head(path)

    if response.kind_of?(Net::HTTPRedirection)
      url_exists?(response['location']) # Go after any redirect and make sure you can access the redirected URL
    else
      ! %W(4 5).include?(response.code[0]) # Not from 4xx or 5xx families
    end
  rescue
    false #false if can't find the server
  end
end