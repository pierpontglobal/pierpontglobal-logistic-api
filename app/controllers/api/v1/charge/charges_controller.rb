class Api::V1::Charge::ChargesController < ApplicationController
  before_action :authenticate_user!

  def show
    charges = ::Charge.where(:shippment_id => params[:shipp_id]).joins!(:charge_type, :service)
                          .select('charges.id as charge_id, charges.*, charge_types.*, services.*')
    render json: {
        charges: charges
    }, :status => :ok
  end


  def create

    income_params = income_paramaters
    expense_params = expense_parameters
    results = []

    if params['income'].present?
      charge_type = ::ChargeType.where(:custom_id => 1)[0]
      if charge_type.present?
        income_params['charge_type_id'] = charge_type[:id]

        created_charge = ::Charge.create!(income_params)

        charge_dto = ::Charge.where(:id => created_charge[:id])
                      .joins!(:charge_type).select('charge_types.*, charges.*')[0]

        puts charge_dto.inspect

        results.append(charge_dto)
      end

    end

    if params['expense'].present?
      charge_type = ::ChargeType.where(:custom_id => 2)[0]
      if charge_type.present?
        expense_params['charge_type_id'] = charge_type[:id]

        created_charge = ::Charge.create!(expense_params)

        charge_dto = ::Charge.where(:id => created_charge[:id])
                         .joins!(:charge_type).select('charge_types.*, charges.*')[0]

        puts charge_dto.inspect

        results.append(charge_dto)
      end

    end

    render json: {
        charges: results
    }, :status => :ok

  end

  def delete
    if params[:charge_id].present?
      charge = ::Charge.find(params[:charge_id])
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

  def income_paramaters
    params.require('income').permit('quantity', 'unit', 'rate', 'bill_to_name', 'bill_to', 'amount', 'currency', 'payment',
                                    'shippment_id', 'service_id') if params['income']
  end

  def expense_parameters
    params.require('expense').permit('quantity', 'unit', 'rate', 'vendor', 'amount', 'currency', 'payment',
                                    'shippment_id', 'service_id') if params['expense']
  end


end