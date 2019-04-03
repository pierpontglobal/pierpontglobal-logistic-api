class Api::V1::Container::ContainersController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: ::Container.create!(agent_parameters)
  end

  def show
    render json: ::Container.all, status: :ok
  end

  def show_by_id
    if params[:id].present?
      agent = ::Container.find(params[:id])
      render json: agent, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end

  end

  def update
    if params[:id].present?
      result = ::Container.where(:id => params[:id]).update!(agent_parameters)
      render json: result, :status => :ok
    end
  end

  def delete
    if params[:id].present?
      result = ::Container.find(params[:id]).destroy
      render json: result, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end


  def container_parameters
    params.require('container').permit('description', 'length', 'width', 'volumne', 'volWeight', 'height', 'tareWidth')
  end
end