Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
