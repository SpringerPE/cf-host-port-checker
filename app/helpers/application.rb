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
    if !nil_or_empty(url)
      url_check(url)
    elsif !nil_or_empty(host) && !nil_or_empty(port)
      host_port_check(host, port)
    else
      error_message
    end
  end

  def url_check(url)
    check = Checker.new
    if check.url_exists?(url)
      @true = "Yes! I can reach #{url}!"
    else
      status 412
      @false = "Boohoo... I can't reach #{url}."
      @errors = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
    end
  end

  def host_port_check(host,port)
    check = Checker.new
    if check.port_open?(host, port)
        @true = "Yes! I can reach #{host}:#{port}!"
    else
      status 412
      @false = "Boohoo... I can't reach #{host}:#{port}."
      @errors = "This is what happened:<br>#{check.errors.map(&:capitalize).join("<br>")}"
    end
  end

  def error_message
    status 400
    @errors = "Stop trying to defeat the system. Put your queries right."
  end


end
