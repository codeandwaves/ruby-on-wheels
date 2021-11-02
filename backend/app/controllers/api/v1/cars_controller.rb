class Api::V1::CarsController < ApplicationController
  include Paginable

  before_action :authenticate_user!
  before_action :set_car, only: %i[show favorite]

  def index
    @cars = Car.includes(:brand)
                .page(current_page)
                .per(per_page)

    options = links_paginated_options('api_v1_cars_path', @cars)

    render json: BaseSerializer.render(@cars, options)
  end

  def show
    render json: BaseSerializer.render(@car)
  end

  private
  def set_car
    @car = Car.find(params[:id])
  end
end