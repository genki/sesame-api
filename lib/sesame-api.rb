require 'net/https'

class SesameAPI
  ENDPOINT = URI('https://api.candyhouse.co/public/sesame/')

  def initialize(sesame_id, token)
    @id = sesame_id
    @path = ENDPOINT.path + @id
    @opts = {authorization:token, contentType:'application/json'}
    @client = Net::HTTP.new ENDPOINT.host, ENDPOINT.port
    @client.use_ssl = true
    @client.verify_mode = OpenSSL::SSL::VERIFY_PEER
    @client.verify_depth = 5
  end

  def lock
    @client.start{@client.post @path, 'lock', @opts}
  end

  def unlock
    @client.start{@client.post @path, 'unlock', @opts}
  end

  def status
    @client.start{@client.get @path, @opts}
  end
end
