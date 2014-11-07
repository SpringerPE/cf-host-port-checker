helpers do
  def get_environment
    base_url = URI.parse(request.base_url)
    url = base_url.host
    !/(live|dev)/.match(url).nil? ? /(live|dev)/.match(url)[0] : url
  end

  def nil_or_empty(variable)
    variable.nil? || variable.empty?
  end

  def connect_to_correct_checker(url=nil, host=nil, port=nil)
    checker = Checker.new
    if !nil_or_empty(url)
      url_check_checker(url, checker)
    elsif !nil_or_empty(host) && !nil_or_empty(port)
      host_port_checker(host, port, checker)
    else
      no_input_message
    end
  end

  def url_check_checker(url, checker)
    if checker.url_exists?(url)
      reachable(url)
    else
      unreachable(url, checker)
    end
  end

  def host_port_checker(host, port, checker)
    endpoint = "#{host}:#{port}"
    if checker.port_open?(host, port)
       reachable(endpoint)
    else
      unreachable(endpoint, checker)
    end
  end

  def no_input_message
    status 400
    @errors = "Stop trying to defeat the system. Put your queries right."
  end

  def error_logs(checker)
    "This is what happened:<br>#{checker.errors.map(&:capitalize).join("<br>")}"
  end

  def unreachable_message(endpoint)
    "Boohoo... I can't reach #{url}."
  end

  def unreachable(endpoint, checker)
    status 412
    @false = unreachable_message(endpoint)
    @errors = error_logs(checker)
  end

  def reachable(endpoint)
    @true = "Yes! I can reach #{endpoint}!"
  end

end
