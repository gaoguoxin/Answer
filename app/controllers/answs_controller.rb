
class AnswsController < ApplicationController
  before_action :set_answ, only: [:show, :edit, :update, :destroy]

  # GET /answs/1
  # GET /answs/1.json
  def show
    @answ = Answ.where(uid:cookies[:ukey]).first  if @answ.uid != cookies[:ukey]
  end

  # GET /answs/new
  def new
    if cookies[:ukey].present? 
      @answ = Answ.where(uid:cookies[:ukey]).first
      if @answ .present?
        if @answ.status == Answ::FINISH
          redirect_to answ_path(@answ)
        else
          redirect_to edit_answ_path(@answ )
        end
      end
    else
      cookies[:ukey] = {
        :value => Time.now.to_i,
        :expires => 12.months.from_now,
        :domain => :all
      }       
    end
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

  def review
    answ = nil
    if cookies[:ukey].present?
      answ = Answ.where(uid:cookies[:ukey]).first
    end
    render json: answ, success: false
  end

  def report
    path = Rails.root.to_s + "/public/export_data.xls"
    File.delete("#{path}") if File.exist?(path)
    Answ.to_csv
  end

  # def down
  #   @answs = Answ.all
  #   #res = @answs.to_csv(col_sep: "\t")
  #   res = @answs.to_csv
  #   send_data(res.encode("GBK"),:type => 'text/csv;header=present', :filename => "data.csv")
  # end

  def down
    path = Rails.root.to_s + "/public/export_data.xls"
    send_file "#{path}", :type => "application/vnd.ms-excel", :filename => "export_data.xls", :stream => false
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answ
      begin
        @answ = Answ.find(params[:id])
      rescue
        render_404
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answ_params
      params.require(:answ).permit!
    end
end
