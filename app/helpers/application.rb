helpers do
  def get_environment
    base_url = URI.parse(request.base_url)
    url = base_url.host
    !/(live|dev)/.match(url).nil? ? /(live|dev)/.match(url)[0] : url
  end


  def nil_or_empty(variable)
    variable.nil? || variable.empty?
  end

end
