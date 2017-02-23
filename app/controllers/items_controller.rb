class ItemsController < ApplicationController
  def index
    @items = Item.where(status: "active").paginate(:page => params[:page])
  end

  def new
  	@item = Item.new
  end

  def unavailable
  end

  def create
  	@item = Item.new(item_params)
    @item.status = "active"
    if @item.save
      flash[:success] = "#{@item.name} has been successfully added to the inventory."
      redirect_to root_path
    else
      flash[:alert] = "Could not add #{@item.name} to inventory! Please try again or contact your system administrator." unless @item.errors.any?
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "#{@item.name} has been updated and is available in the inventory."
      redirect_to root_path
    else
      flash[:alert] = "Could not edit #{@item.name}! Please try again or contact your system administrator." unless @item.errors.any?
      render 'edit'
    end
  end

  def delete
    @item = Item.find(params[:id])
    @item.status = "inactive"
    if @item.save
      flash[:success] = "#{@item.name} has been deleted from inventory."
    else
      flash[:alert] = "Could not delete #{@item.name}! Please try again or contact your system administrator." unless @item.errors.any?
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :quantity, :description, :image)
  end
end
