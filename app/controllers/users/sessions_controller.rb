# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in

  # POST /resource/sign_in
  def create
    user = User.find_or_initialize_by(email: user_params[:email])
    if user.new_record?
      user.password = user_params[:password]
      if user.save
        sign_in user
        flash[:notice] = 'Create account and sign in successfully.'
      else
        flash[:alert] = user.errors.first.full_message
      end
    else
      if user.valid_password?(user_params[:password])
        sign_in user
        flash[:notice] = 'Sign in successfully.'
      else
        flash[:alert] = 'Wrong password'
      end
    end
    redirect_to root_path
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
