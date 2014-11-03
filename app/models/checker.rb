class Checker
  def url_exists?(host, port)
    http = Net::HTTP.new(host, port)
    response = http.request_head('/')
    if response.kind_of?(Net::HTTPRedirection)
      # puts "**** REDIRECTED ****"
      new_url = URI.parse(response['location'])
      url_exists?(new_url.host, new_url.port) # Go after any redirect and make sure you can access the redirected URL 
    else
      # puts "**** ALOHA ****"
      ! %W(4 5).include?(response.code[0]) # Not from 4xx or 5xx families
    end
  rescue
    false
  end
end