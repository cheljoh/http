require_relative 'test_helper'

class ServerRequestTest < Minitest::Test

  def test_does_server_make_request
    client = Hurley::Client.new("http://127.0.0.1:9292")
    request = client.get("/")
    assert request
  end

  def test_does_it_shutdown
    skip
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/shutdown")
    assert_equal "Total requests:", response.body[25..39]
  end

end
