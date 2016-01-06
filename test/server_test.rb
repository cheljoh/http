require_relative 'test_helper' #don't need to have travis CI
# require '../lib/server'

class ServerTest < Minitest::Test
  def test_response
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
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/hello")
    assert_equal "<pre> Hello, World!", response.body[0..18]
  end

  def test_root
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/")

    expected = "<pre>\nVerb: GET"

    assert_equal expected, response.body[0..14]
  end

end
