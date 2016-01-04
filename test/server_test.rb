require './test/test_helper'
require './lib/server'

class ServerTest < Minitest::Test

  def test_a_hurley_test
    client = Hurley::Client.new("http://127.0.0.1:9292/")
    # request = client

    assert_equal "127.0.0.1", client.host
  end
end
