class Api::V1::Charge::ChargesController < ApplicationController
  before_action :authenticate_user!

  def show
    charges = ::Charge.all.joins!(:charge_type, :service)
                          .select('charges.*, charge_types.*, services.*')
    render json: {
        charges: charges
    }, :status => :ok
  end


  def create
    charges = params[:charges]
    to_add_charges = []
    if charges.present?
      if charges.any?

        charges.each do |c|
          to_add_charges.append(c)
        end

        created_charges = ::Charge.create!(to_add_charges)

        render json: {
            charges: created_charges
        }, :status => :ok

      else
        render json: {
            error: "Dto must be an array of charges"
        }, :status => :bad_request
      end
    else
      render json: {
          error: "Please, provide the correct dto"
      }, :status => :bad_request
    end
  end

  def delete
    if params[:id].present?
      charge = ::Charge.find(params[:id])
      if charge.present?
        ::Charge.destroy(charge[:id])

        render json: {
            charge: charge
        }, :status => :ok
      else
        render json: {
            error: "Could not found charge"
        }, :status => :not_found
      end
    else
      render json: {
          error: "Please, provide an ID"
      }, :status => :bad_request
    end
  end

  def charges_parameters
    params[:charges].permit()
  end

end