class Api::V1::CarsController < ApplicationController
  include Paginable

  before_action :set_car, only: %i[show favorite]

  def index
    @cars = Car.includes(:brand)
                .page(current_page)
                .per(per_page)

    options = links_paginated_options('api_v1_cars_path', @cars)

    render json: CarSerializer.render(@cars, root: :data)
  end

  def show
    render json: CarSerializer.render(@car, root: :data)
  end

  def favorite
    # require authentication

    @new_favorite = Favorite.create(
      user: current_user,
      car: @car
    )

    if @new_favorite.valid?
      render json: { status: :success, message: "Added sucessfully" }
    else
      render json: { status: :bad_request, message: @new_favorite.errors.full_messages }
    end
  end


  private

  # def car_params
  #   params.require(:car).permit(:title, :price, :published)
  # end

  def set_car
    @car = Car.find(params[:id])
  end
end