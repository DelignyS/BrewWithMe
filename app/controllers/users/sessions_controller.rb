class Users::SessionsController < Devise::SessionsController
  def create
    super do
      flash[:notice] = "Bienvenue #{current_user.email}" if current_user
    end
  end
end