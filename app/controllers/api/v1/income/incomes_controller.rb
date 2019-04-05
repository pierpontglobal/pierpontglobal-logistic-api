class Api::V1::Income::IncomeController < ApplicationController
  before_action :authenticate_user!

  def create
    e = params[:income]
    income = ::Income.create!(:amount => e.amount, :bill_to => e.billTo, :bill_to_name => e.billToName, :currency => e.currency,
                                :date => e.date, :payment => e.payment, :quantity => e.quantity, :rates => e.rate, :units => e.units);
    render json: income, :status => :ok
  end

end