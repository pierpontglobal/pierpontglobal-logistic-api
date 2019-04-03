class Api::V1::IssuingCompany::IssuingCompaniesController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: ::IssuingCompany.create!(comp_parameters)
  end

  def show
    render json: ::IssuingCompany.all, status: :ok
  end

  def show_by_id
    if params[:id].present?
      comp = ::IssuingCompanypin.find(params[:id])
      render json: comp, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end

  def update
    if params[:id].present?
      result = ::IssuingCompany.where(:id => params[:id]).update!(comp_parameters)
      render json: result, :status => :ok
    end
  end

  def delete
    if params[:id].present?
      result = ::IssuingCompany.find(params[:id]).destroy
      render json: result, :status => :ok
    else
      render json: { error: "Please, provide an ID" }, :status => :ok
    end
  end


  def comp_parameters
    params.require('issuing_company').permit('company_name', 'company_location')
  end
end