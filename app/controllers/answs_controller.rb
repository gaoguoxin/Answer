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
    if cookies[:ukey].present? 
      @answ = Answ.where(uid:cookies[:ukey]).first
      if @answ .present?
        redirect_to edit_answ_path(@answ ) and return 
      end
    end

    cookies[:ukey] = {
      :value => Time.now.to_i,
      :expires => 12.months.from_now,
      :domain => :all
    } 

    @answ = Answ.new       
  end

  # GET /answs/1/edit
  def edit
  end

  # POST /answs
  # POST /answs.json
  def create
    @answ = Answ.where(uid:cookies[:ukey]).first
    if @answ.present?
      if @answ.update(answ_params)
        render json: @answ, success: true
      else
        render json: @answ, success: false
      end
    else
      @answ = Answ.new(answ_params)
      @answ.uid = cookies[:ukey]
      if @answ.save
        render json: @answ, success: true
      else
        render json: @answ, success: false
      end
    end

    # @answ = Answ.new(answ_params)
    # respond_to do |format|
    #   if @answ.save
    #     format.html { redirect_to @answ, notice: 'Answ was successfully created.' }
    #     format.json { render :show, status: :created, location: @answ }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @answ.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /answs/1
  # PATCH/PUT /answs/1.json
  def update
    if @answ.update(answ_params)
      render json: @answ, success: true
    else
      render json: @answ, success: false
    end
  end

  # # DELETE /answs/1
  # # DELETE /answs/1.json
  # def destroy
  #   @answ.destroy
  #   respond_to do |format|
  #     format.html { redirect_to answs_url, notice: 'Answ was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

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
