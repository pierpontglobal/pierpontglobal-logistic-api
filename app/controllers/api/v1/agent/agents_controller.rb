class Api::V1::Agent::AgentsController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: ::Agent.create!(agent_parameters)
  end

  def show
    render json: ::Agent.all, status: :ok
  end

  def show_by_id
    if params[:id].present?
      agent = ::Agent.find(params[:id])
      render json: agent, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end

  end

  def update
    if params[:id].present?
      agent = ::Agent.find(params[:id])
      result = agent.update!(agent_parameters)
      render json: agent, :status => :ok
    end
  rescue StandardError => e
    render json: {
        error: e
    }, :status => :bad_gateway
  end

  def delete
    if params[:id].present?
      result = ::Agent.find(params[:id])
      if result.present?

        begin
          result.destroy!
          render json: result, :status => :ok

        rescue ActiveRecord::InvalidForeignKey => e
          render json: {
              error: e
          }, :status => :bad_gateway
        end

      else
        render json: { error: "Agent not found" }, :status => :ok
      end
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end


  def agent_parameters
    params.require('agent').permit('name', 'address')
  end
end