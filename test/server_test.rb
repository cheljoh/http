require_relative 'test_helper'
require '../lib/server'

class ServerTest < Minitest::Test

  def test_response
    skip
    response = Hurley.get("http://127.0.0.1:9292")
    assert response.success?
  end

  def test_host
    client = Hurley::Client.new("http://127.0.0.1:9292")
    assert_equal "127.0.0.1", client.host
  end

  def test_port
    client = Hurley::Client.new("http://127.0.0.1:9292")
    assert_equal 9292, client.port
  end

  def test_hello_world
    skip
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get "" do |request|
      request.url
    end
    assert_equal "", response.body
  end
end
