require_relative 'test_helper' #don't need to have travis CI

class ServerTest < Minitest::Test
  def test_response
    response = Hurley.get("http://127.0.0.1:9292")

    assert response.success?
  end
end
