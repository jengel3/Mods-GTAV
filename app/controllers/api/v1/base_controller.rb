# /api/v1
class Api::V1::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
 
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  before_filter :verify_user, only: [:create, :update, :destroy]
 
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
 
  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
 
      render :text => '', :content_type => 'text/plain'
    end
  end

  def verify_user
    key = request.headers['X-API-Key']
    if !key || key.blank?
      return render :text => 'API key not found. Please verify key.', status: 401
    end

    api_key = ApiKey.where(:key => key).first
    if !api_key
      return render :text => 'API key invalid, please verify that it is correct.', status: 401
    end

    @user = api_key.user
  end
end