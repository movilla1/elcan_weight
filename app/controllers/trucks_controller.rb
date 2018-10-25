# frozen_string_literal: true

class TrucksController < ApplicationController
  def by_license
    @trucks = Truck
              .where("license LIKE '?%'", params[:term])
              .map { |item| { id: item.id, text: item.license } }
    respond_to do |format|
      format.json do
        render json: trucks, status: 200
      end
    end
  end
end
