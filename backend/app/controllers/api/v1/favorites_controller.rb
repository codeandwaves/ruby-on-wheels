class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    # require authentication
    favorite = Favorite.new(favorite_params)
    favorite.user = current_user

    if favorite.save
      render json: favorite, status: :created
    else
      render json: { errors: { message: favorite.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.favorites.find(params[:car_id]).destroy!
    head :no_content
  end

  def index
    render json: BaseSerializer.render(current_user.favorite_cars)
  end

  private

  def favorite_params
    params.permit(:car_id)
  end
end
