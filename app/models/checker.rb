class Checker
  attr_accessor :errors

  def initialize
    @errors = []
  end

  def port_open?(ip, port, seconds=1)
    Timeout::timeout(seconds) do
      begin
        TCPSocket.new(ip, port).close
        true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH => error_message
        @errors << error_message.message
        false
      end
    end
  rescue Timeout::Error, SocketError => error_message
    @errors << error_message.message
    false
  end

  def url_exists?(url_string)
    url_string = url_validator(url_string)
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
  rescue => error_message
    @errors << error_message.message
    false #false if can't find the server
  end

  def url_validator(url_string)
    unless url_string[/\Ahttp:\/\//] || url_string[/\Ahttps:\/\//]
      url_string = "http://#{url_string}"
    end
    url_string
  end

end