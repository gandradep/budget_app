class TransacctionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
   # GET /foods/new
  def new
    @transaction = Transacction.new
    @category = Category.find(params[:category_id])
  end

  # POST /foods or /foods.json
  def create
    @author = current_user
    @transaction = Transacction.new(transaction_params)
    @transaction.author = @author

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to categories_url, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @transaction = Transacction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:transaction).permit(:name, :amount, :user_id)
  end
end
