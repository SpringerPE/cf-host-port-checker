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
      log_error(error)
      false
  end

  def url_exists?(url_string, seconds=5)
    Timeout::timeout(seconds) do
      connect_to_url(url_string)
    end
    rescue Timeout::Error => error
      log_error(error)
      false
  end

  def flash_messages(url)
    if url_exists?(url)
      flash[:true] = "Yes! I can reach #{url}!"
    else
      flash[:false] = "Boohoo... I can't reach #{url}."
      flash[:errors] = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
    end
  end

  def connect_to_url(url_string)
    begin
      response = create_request(url_string)
      check_response(response)
    rescue => error
      log_error(error)
      false #false if can't find the server
    end
  end

  def create_request(url_string)
    url_string = url_validator(url_string)
    url = URI.parse(url_string)
    HTTParty.get(url)
  end

  def check_response(response)
    response.code.to_s.start_with?("2")
  end

  def connect_to_socket(ip,port)
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH => error
      log_error(error)
      false
    end
  end

  def log_error(error)
    @errors << error.message
  end

  def url_validator(url_string)
    unless url_string[/\Ahttp:\/\//] || url_string[/\Ahttps:\/\//]
      url_string = "http://#{url_string}"
    end
    url_string
  end

end