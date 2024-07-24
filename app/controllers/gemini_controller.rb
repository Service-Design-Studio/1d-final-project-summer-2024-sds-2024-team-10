class GeminiController < ApplicationController
  def test
    service = GeminiService.new
    @result = service.generate_content('hi!')
  end
end