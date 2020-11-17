# frozen_string_literal: true

class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[show update destroy]

  # GET /apartments
  def index
    @apartments = Apartment.where(user_id: @authenticated_user_id)

    render json: @apartments
  end

  # GET /apartments/1
  def show
    render json: @apartment
  end

  # POST /apartments
  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.user_id = @authenticated_user_id

    if @apartment.save
      render json: @apartment, status: :created, location: @apartment
    else
      render json: @apartment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /apartments/1
  def update
    if @apartment.update(apartment_params)
      render json: @apartment
    else
      render json: @apartment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /apartments/1
  def destroy
    @apartment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_apartment
    @apartment = Apartment.find_by(user_id: @authenticated_user_id, id: params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def apartment_params
    params.permit(:name, :street_address, :zip_code, :state, :icon_color, :type, :bedrooms, :bathrooms, :price, :status)
  end
end
