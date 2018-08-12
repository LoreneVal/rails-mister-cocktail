class DosesController < ApplicationController

  def new
     @cocktail = Cocktail.find(params[:cocktail_id])
     @ingredients = Ingredient.all.order(:name)
     @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = Cocktail.find(params[:cocktail_id])
    @cocktail = @dose.cocktail
    if @dose.save
      redirect_to new_cocktail_dose_path(@dose.cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = @cocktail.doses.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description,  :ingredient_id)
  end
end
