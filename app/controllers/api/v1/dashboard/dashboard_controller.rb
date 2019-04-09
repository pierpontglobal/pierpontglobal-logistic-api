class Api::V1::Dashboard::DashboardController < ApplicationController
  before_action :authenticate_user!
  require 'time'
  require 'date'

  def show

    incomes = ::Charge.where(:charge_type_id => 1)
    expenses = ::Charge.where(:charge_type_id => 2)

    @total_income = 0
    @total_expense = 0
    if incomes.any?
      incomes.each do |i|
        @total_income += i[:rate] * i[:amount] + i[:amount]
      end
    end
    if expenses.any?
      expenses.each do |e|
        @total_expense += e[:rate] * e[:amount] + e[:amount]
      end
    end

    @total_profit = @total_income - @total_expense

    @total_weight = 0
    @total_pieces = 0
    containers = ::Commodity.where(:commodity_type_id => 2)
    if containers.any?
      containers.each do |c|
        artifact = ::Container.find(c[:reference])
        @total_pieces += c[:pieces]
        if artifact.present?
          @total_weight += artifact[:total_weight]
        end
      end
    end

    containers = ::Commodity.where(:commodity_type_id => 1)
    if containers.any?
      containers.each do |c|
        @total_pieces += c[:pieces]
      end
    end

    render json: {
        total_income: @total_income,
        total_expense: @total_expense,
        total_profit: @total_profit,
        total_weight: @total_weight,
        total_pieces: @total_pieces
    }, :status => :ok

  rescue StandardError => e

    render json: {
        error: e
    }, :status => :bad_gateway

  end

  def income_expense_profit_last_week
    days_to_count = params[:days].to_i

    day_data_list = []

    while days_to_count >= 0 do

      days_ago = (Time.now - days_to_count.days)
      day_ago = (Time.now - (days_to_count - 1).days)

      total_income = 0
      total_expense = 0

      incomes = ::Charge.where('created_at >= ? and created_at <= ? and charge_type_id = ?', days_ago, day_ago, 1)
      expenses = ::Charge.where('created_at >= ? and created_at <= ? and charge_type_id = ?', days_ago, day_ago, 2)

      if incomes.any?
        incomes.each { |i|
          total_income += i[:rate] * i[:amount] + i[:amount]
        }
      end
      if expenses.any?
        expenses.each do |e|
          total_expense += e[:rate] * e[:amount] + e[:amount]
        end
      end

      day_data_list.append ({
          total_income: total_income,
          total_expense: total_expense,
          label: days_ago.strftime("%m/%d/%y"),
          from: days_ago.strftime("%Y%m%d"),
          to: day_ago.strftime("%Y%m%d")
      })

      days_to_count -= 1

    end

    render json: day_data_list, :status => :ok

  rescue StandardError => e
    render json: {
        error: e
    }, :status => :bad_gateway

  end

end