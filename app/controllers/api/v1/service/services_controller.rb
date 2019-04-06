class Api::V1::Service::ServicesController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: ::Service.create!(comp_parameters)
  end

  def show
    render json: ::Service.all, status: :ok
  end

  def show_by_id
    if params[:id].present?
      comp = ::Service.find(params[:id])
      render json: comp, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end

  def update
    if params[:id].present?
      result = ::Service.where(:id => params[:id]).update!(comp_parameters)
      render json: result, :status => :ok
    end
  end

  def delete
    if params[:id].present?
      result = ::Service.find(params[:id]).destroy
      render json: result, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end


  def comp_parameters
    params.require('service').permit('name')
  end
end