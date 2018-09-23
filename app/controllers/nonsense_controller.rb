class NonsenseController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET, POST /nonsense
  def log
    logger.info(request.raw_post)
  end
end
