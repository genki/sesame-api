require 'net/https'

class SesameAPI
  VERSION = '0.1.0'
  ENDPOINT = URI('https://api.candyhouse.co/public/sesame/')

  def initialize(sesame_id, token)
    @path = ENDPOINT.path + sesame_id
    @opts = {'Authorization' => token, 'Content-Type' => 'application/json'}
    @client = Net::HTTP.new ENDPOINT.host, ENDPOINT.port
    @client.use_ssl = true
    @client.verify_mode = OpenSSL::SSL::VERIFY_PEER
    @client.verify_depth = 5
  end

  def lock
    req = Net::HTTP::Post.new @path, @opts
    req.body = '{"command":"lock"}'
    @client.request req
  end

  def unlock
    req = Net::HTTP::Post.new @path, @opts
    req.body = '{"command":"unlock"}'
    @client.request req
  end

  def status
    @client.request Net::HTTP::Get.new @path, @opts
  end
end
