class Api::V1::Expense::ExpensesController < ApplicationController
  before_action :authenticate_user!

  def create
    e = params[:expense]
    expense = ::Expense.create!(:amount => e.amount, :venor => e.vendor, :currency => e.currency,
    :date => e.date, :payment => e.payment, :quantity => e.quantity, :rates => e.rate, :units => e.units);
    render json: expense, :status => :ok
  end

end