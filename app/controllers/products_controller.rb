# frozen_string_literal: true

# Controlador para manejar lo relacionado a la creacion de productos
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: 'Product registrado' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    if @product.update(product_params)
      redirect_to product_url(@product), notice: 'Product actualizado.'
    else
      redirect_to products_path, notice: 'Falló la actualización del producto.'
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private # Use callbacks to share common setup or constraints between actions.

  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    @key = :product
    @permit_params = :name, :cost, :volum, :weight, :type
    if params.key?('bebestible')
      @key = :bebestible
      @permit_params = :name, :cost, :volum
    elsif params.key?('comestible')
      @key = :comestible
      @permit_params = :name, :cost, :weight
    elsif params.key?('souvenir')
      @key = :souvenir
      @permit_params = :name, :cost
    end
    params.require(@key).permit(@permit_params)
  end
end
