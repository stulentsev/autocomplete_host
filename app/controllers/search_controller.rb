class SearchController < ApplicationController
  skip_before_action :verify_authenticity_token


  def index
    query = params[:term]
    if query.present?
      descriptions = Description.where("lower(value) like ?", "%#{query.downcase}%").limit(50)

      response = descriptions.map(&:value)
      render json: response, callback: params['callback']
    else
      render nothing: true
    end
  end


end
