class AnswsController < ApplicationController
  before_action :set_answ, only: [:show, :edit, :update, :destroy]

  # GET /answs
  # GET /answs.json
  def index
    @answs = Answ.all
  end

  # GET /answs/1
  # GET /answs/1.json
  def show
  end

  # GET /answs/new
  def new
    @answ = Answ.new
  end

  # GET /answs/1/edit
  def edit
  end

  # POST /answs
  # POST /answs.json
  def create
    @answ = Answ.new(answ_params)

    respond_to do |format|
      if @answ.save
        format.html { redirect_to @answ, notice: 'Answ was successfully created.' }
        format.json { render :show, status: :created, location: @answ }
      else
        format.html { render :new }
        format.json { render json: @answ.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answs/1
  # PATCH/PUT /answs/1.json
  def update
    respond_to do |format|
      if @answ.update(answ_params)
        format.html { redirect_to @answ, notice: 'Answ was successfully updated.' }
        format.json { render :show, status: :ok, location: @answ }
      else
        format.html { render :edit }
        format.json { render json: @answ.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answs/1
  # DELETE /answs/1.json
  def destroy
    @answ.destroy
    respond_to do |format|
      format.html { redirect_to answs_url, notice: 'Answ was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answ
      @answ = Answ.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answ_params
      params[:answ]
    end
end
