class NiceController < ApplicationController
  def simple
 	@ref = request.referer.to_s
  end

  def many

  end
end
