class ReviewsController < ApplicationController

  before_filter :authenticate

  def create

    @product = Product.find(params[:product_id])

    @review = @product.reviews.new(review_params)

    @review.user = current_user

    if @review.save
      redirect_to :back
    else
      @product.reviews.reload
      redirect_to '/products', notice: "You have to fuck off"
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @product.reviews.destroy(params[:id])
    redirect_to @product
  end

private

  def authenticate
    if !current_user
      redirect_to '/login'
    end
  end

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end
