class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    @user = current_user
    @categories = @user.categories
  end

  def show
    @category = Category.find(params[:id])
    trans = @category.transacctions
    @transacctions = trans.order(created_at: :desc)
  end

  # GET /foods/new
  def new
    @category = Category.new
  end

  # POST /foods or /foods.json
  def create
    @author = current_user
    @category = Category.new(category_params)
    @category.author = @author

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Category was successfully created.' }
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
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
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
    params.require(:category).permit(:name, :icon_url, :user_id)
  end
end
