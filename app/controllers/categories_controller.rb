class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    @user = current_user
    @category = @user.categories
  end

  # GET /foods/new
  def new
    @category = Category.new

  end

  # POST /foods or /foods.json
  def create
    @user = current_user
    @category = Category.new(category_params)
    @category.user = @user

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @Category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
