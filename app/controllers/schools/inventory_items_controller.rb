module Schools
  class InventoryItemsController < ApplicationController
    before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]

    def index
      @inventory_items = current_school.inventory_items
        .order(created_at: :desc)
        .page(params[:page])
        .per(10)
    end

    def show
    end

    def new
      @inventory_item = current_school.inventory_items.build
    end

    def create
      @inventory_item = current_school.inventory_items.build(inventory_item_params)

      if @inventory_item.save
        redirect_to schools_inventory_items_path, notice: 'Inventory item was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @inventory_item.update(inventory_item_params)
        redirect_to schools_inventory_items_path, notice: 'Inventory item was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @inventory_item.destroy
      redirect_to schools_inventory_items_path, notice: 'Inventory item was successfully deleted.'
    end

    private

    def set_inventory_item
      @inventory_item = current_school.inventory_items.find(params[:id])
    end

    def inventory_item_params
      params.require(:inventory_item).permit(
        :name,
        :category,
        :quantity,
        :unit,
        :minimum_quantity,
        :description
      )
    end
  end
end 