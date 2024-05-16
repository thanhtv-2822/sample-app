class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add(:password, I18n.t("mail.reset_password.password_empty"))
    elsif @user.update(user_params)
      @user.send_password_reset_success_email
      flash[:success] = t "mail.reset_password.success"
      redirect_to @user
      return
    end
    render :edit
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "mail.reset_password.send_mail"
      redirect_to root_url
    else
      flash.now[:danger] = t "mail.reset_password.not_found"
      render :new
    end
  end

  private

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "mail.reset_password.expired"
    redirect_to new_password_reset_url
  end

  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "mail.reset_password.not_found"
    redirect_to root_url
  end

  def valid_user
    return if @user&.activated && @user&.authenticated?(:reset, params[:id])

    flash[:danger] = t "mail.reset_password.not_auth"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
