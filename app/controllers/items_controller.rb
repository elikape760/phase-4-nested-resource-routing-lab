class ItemsController < ApplicationController
rescue_from ActiveRecord::REcordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = find_item
  end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: status: :created
  end

  private

  def find_user
    User.find(params[:id])
  end

  def find_item
    Item.find(params[:id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

end
