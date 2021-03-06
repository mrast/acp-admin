module HasAuthToken
  extend ActiveSupport::Concern

  def verify_auth_token(scope)
    token = Current.acp.credentials("#{scope}_auth_token".to_sym)

    if (!token || params[:auth_token] != token) && !admin_signed_in?
      render plain: 'unauthorized', status: :unauthorized
    end
  end
end
