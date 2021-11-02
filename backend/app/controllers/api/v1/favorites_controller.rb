class Api::V1::FavoritesController < ApplicationController
  def create
    # require authentication
    binding.pry
    favorite = Favorite.new(favorite_params)
    favorite.user = current_user

    if favorite.save
      render json: favorite, status: :created
    else
      render json: favorite.erros, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.favorites.find(params[:car_id]).destroy!
    head :no_content
  end

  private

  def favorite_params
    params.require(:favorite).permit(:id)
  end
end
