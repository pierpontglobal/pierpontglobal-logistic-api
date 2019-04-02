class Api::V1::ModeOfTransportation::ModeOfTransportationsController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: ::ModeOfTransportation.create!(transport_paramaters)
  end

  def show
    render json: ::ModeOfTransportation.all, status: :ok
  end

  def show_by_id
    if params[:id].present?
      agent = ::ModeOfTransportation.find(params[:id])
      render json: agent, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end

  def update
    if params[:id].present?
      result = ::ModeOfTransportation.where(:id => params[:id]).update!(transport_paramaters)
      render json: result, :status => :ok
    end
  end

  def delete
    if params[:id].present?
      result = ::ModeOfTransportation.find(params[:id]).destroy
      render json: result, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end


  def transport_paramaters
    params.require('mode_of_transportation').permit('name')
  end
end