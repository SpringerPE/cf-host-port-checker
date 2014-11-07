class Checker
  attr_accessor :errors

  def initialize
    @errors = []
  end

  def port_open?(ip, port, seconds=1)
    Timeout::timeout(seconds) do
      connect_to_socket(ip,port)
    end
    rescue Timeout::Error, SocketError => error
      log_error(error.message)
      false
  end

  def url_exists?(url_string, seconds=5)
    Timeout::timeout(seconds) do
      connect_to_url(url_string)
    end
    rescue Timeout::Error => error
      log_error(error.message)
      false
  end

  def connect_to_url(url_string)
    begin
      response = create_request(url_string)
      check_response(response)
    rescue => error
      log_error(error.message)
      false #false if can't find the server
    end
  end

  def create_request(url_string)
    url_string = url_validator(url_string)
    url = URI.parse(url_string)
    HTTParty.get(url)
  end

  def check_response(response)
    if response.code.to_s.start_with?("2")
      true
    else
      error = response.code.to_s + ": " + response.message
      log_error(error)
      false
    end
  end

  def connect_to_socket(ip,port)
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH => error
      log_error(error.message)
      false
    end
  end

  def log_error(error)
    @errors << error
  end

  def url_validator(url_string)
    unless url_string[/\Ahttp:\/\//] || url_string[/\Ahttps:\/\//]
      url_string = "http://#{url_string}"
    end
    url_string
  end

end