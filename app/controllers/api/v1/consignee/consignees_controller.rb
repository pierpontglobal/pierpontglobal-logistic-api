class Api::V1::Consignee::ConsigneesController < ApplicationController
  before_action :authenticate_user!

  def create
    consignee = ::Consignee.create!(consignee_params)
    render json: consignee, :status => :ok
  end

  def show
    consignees = ::Consignee.all
    render json: consignees, :status => :ok
  end

  def update
    if params[:id].present?
      consignee = ::Consignee.find(params[:id])
      consignee.update!(consignee_params)
      render json: consignee, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end

  def show_by_id
    if params[:id].present?
      consignee = ::Consignee.find(params[:id])
      render json: consignee, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :bad_request
    end
  end

  def delete
    if params[:id].present?
      result = ::Consignee.destroy(params[:id])
      render json: result, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end


  def consignee_params
    params.require(:consignee).permit(:name, :address)
  end
end