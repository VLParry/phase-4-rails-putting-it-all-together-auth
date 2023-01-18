class RecipesController < ApplicationController
#because we are inheriting from application controller, everything is authorized 

    def index 
        render json: Recipe.all 
    end 

    #below the ! is for the errors 
    def create 
    recipe = @current_user.recipes.create!(recipe_params)
    render json: recipe, status: :created
    end

    private 
    
    def recipe_params 
        params.permit(:title, :instructions, :minutes_to_complete)
    end 
end
