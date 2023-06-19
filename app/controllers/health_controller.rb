class HealthController < ApplicationController
  skip_before_action :authorize
  
  def health
    render json: { API: "OK"}, status: :ok
  end
end