class CategoriesController < ApplicationController
	before_action :check_login, except: [:show]

	def show
		@category = Category.find_by(slug: params[:id])
	end

	def new

		@category = Category.new

	end

	def create

		@category = Category.new(category_params)

		if @category.save
			flash[:notice] = "Category successfully saved"
			redirect_to posts_path
		else
			render :new
		end

	end
	private

	def category_params
		params.require(:category).permit(:name)
	end

end