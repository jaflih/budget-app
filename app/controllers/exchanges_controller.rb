class ExchangesController < ApplicationController
  before_action :set_exchange, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id])
    @exchanges = @category.exchanges.order(created_at: :desc)

    redirect_to new_user_session_path, notice: 'Can not access this ressource' if @category.user != current_user
  end

  def new
    @category = Category.find(params[:category_id])
    @exchange = Exchange.new
  end

  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.author = current_user
    @category = Category.find(params[:category_id])
    @category.exchanges << @exchange

    respond_to do |format|
      if @exchange.save
        format.html { redirect_to category_exchanges_path(@category), notice: 'Exchange was successfully created.' }
        format.json { render :show, status: :created, location: @exchange }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exchange
    @exchange = Exchange.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def exchange_params
    params.require(:exchange).permit(:name, :amount)
  end
end
