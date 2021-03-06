class CocktailsController < ApplicationController
  def index
    @cocktails = if params[:term]
      Cocktail.where('name LIKE ?', "%#{params[:term]}%")
    else
      Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
    @cocktail.doses.build
    @ingredients = Ingredient.all.order(:name)
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :term)
  end
end
