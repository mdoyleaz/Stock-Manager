class InvestmentsController < ApplicationController
  before_action :set_investment, only: %i[show edit update destroy]

  # GET /investments
  # GET /investments.json
  def index
    @investments = Investment.all
  end

  # GET /investments/1
  # GET /investments/1.json
  def show; end

  # GET /investments/new
  def new
  end

  # GET /investments/1/edit
  def edit; end

  # POST /investments
  # POST /investments.json
  def create
    @investment = Investment.new

    respond_to do |format|
      if investment_params[:stock]
        @investment.stock = Stock.find(investment_params[:stock])
        @investment.portfolio = Portfolio.find(investment_params[:portfolio])
        @investment.shares = investment_params[:shares]

        current_stock_value = helpers.get_stock_price(@investment.stock.symbol)['price']

        @investment.initial_cost = current_stock_value

      end
      if @investment.save
        format.html { redirect_to "/portfolios/#{investment_params[:portfolio]}", notice: 'Investment was successfully created.' }
        format.json { render :show, status: :created, location: @investment }
      else
        format.html { render :new }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investments/1
  # PATCH/PUT /investments/1.json
  def update
    respond_to do |format|
      if @portfolio.investment.update(investment_params)
        format.html { redirect_to @investment, notice: 'Investment was successfully updated.' }
        format.json { render :show, status: :ok, location: @investment }
      else
        format.html { render :edit }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investments/1
  # DELETE /investments/1.json
  def destroy
    @investment.destroy
    respond_to do |format|
      format.html { redirect_to investments_url, notice: 'Investment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_investment
    @investment = Investment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def investment_params
    params.fetch(:investment, {})
  end
end
