
class AnswsController < ApplicationController
  before_action :set_answ, only: [:show, :edit, :update, :destroy]

  # GET /answs/1
  # GET /answs/1.json
  def show  
    @class = 'show_print'
    @answ = Answ.where(uid:cookies[:ukey]).first  if @answ.uid != cookies[:ukey]

    if params[:down_pdf]
      generate_pdf
      download_pdf(@answ.id.to_s)
    end
    
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
    set_col
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

  def preview
    @answ = nil
    if cookies[:ukey].present?
      @answ = Answ.where(uid:cookies[:ukey]).first
    end
    #render json: @answ
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


  def upd_stat
    ans = Answ.find(params[:id])
    if ans.present?
      ans.update_attributes(:status => Answ::PRINT)
    end
    render json: ans, success: true
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

    def set_col
      (Answ.fields.keys - ['_id','updated_at','created_at','uid','status'] - answ_params.keys).each do |k|
        answ_params["#{k}"] = nil
      end
    end


    def generate_pdf
      pdf = Prawn::Document.new
      #pdf.font_families.update("MyTrueTypeFamily" => { :normal => "#{Rails.root.to_s}/public/msyh.ttf" })


      pdf.font_families.update("MyTrueTypeFamily" => {
        :msyh => "#{Rails.root.to_s}/public/msyh.ttf",
        :normal => "#{Rails.root.to_s}/public/simsun.ttf"
      })




      title = '“国办8号文件”落实情况企业调查问卷'
      describe_0 = '各有关企业：'
      describe_1 = '为跟踪了解《国务院办公厅关于强化企业技术创新主体地位全面提升企业创新能力的意见》'
      describe_2 = '（国办发〔2013〕8号，简称“国办8号文件”）及相应政策措施在企业的实施情况，分析政策实施中存在的问题与不足，完善相关政策及操作办法，方便企业更好、更便捷地享受到政策优惠，我们设计了本调查问卷。为提高工作效率，减轻企业负担，问卷采取网上填报的方式。请结合本企业实际情况认真、如实填写，于9月26日前登陆国家科技评估中心（科技部科技评估中心）主页（http://www.ncste.org）完成在线提交。企业提交问卷后，须下载（PDF版）打印纸质件，盖章确认后由各地省级科技主管部门将本地区企业填好的问卷纸质件统一寄送至国家科技评估中心。我们将妥善使用贵企业提供的宝贵信息，并保证不向任何无关机构或个人透漏。为确保问卷质量，建议由贵企业分管技术创新工作的人员填写。选择题部分，除另有说明外，均为单选。'
      
      contact = '联 系 人：姜玲  王再进'
      tel     = '联系电话：010-62169570  010-62169385'
      fax     = '传   真：010-88232615'
      address = '邮寄地址：北京市海淀区皂君庙乙7号（邮编：100081），姜玲（收）'
      thx     = '衷心感谢您的支持与配合！'
      
      company = '科技部科技评估中心'
      date    = '2014年9月5日'
      
      basic_info = '一、基本信息'
      
      sec_info   = '二、国办8号文件相关政策措施落实情况'
      
      
      pdf.default_leading = 10
      pdf.font("MyTrueTypeFamily") do
          pdf.text title, :align => :center,:size => 16
          pdf.text describe_0
          pdf.indent(20) do
            pdf.text describe_1
          end
          pdf.text describe_2
          pdf.indent(20) do
            pdf.text contact
            pdf.text tel
            pdf.text fax
            pdf.text address
            pdf.text thx
          end
      
          pdf.indent(400) do 
            pdf.text company
            pdf.text date
          end 
      
          pdf.text basic_info,:size => 14
          pdf.text '1.企业名称（盖企业公章）：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.company}")
          end
      
          pdf.text '2.企业所在地区（省、自治区、直辖市、计划单列市或新疆生产建设兵团）：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.address}") 
          end    
      
          pdf.text '3.企业所属技术领域：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.tech_domain}") 
          end        
      
          pdf.text '4.企业从业人数：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.company_person_count}") 
          end 
      
          pdf.text '5.企业年营业收入：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.company_income}") 
          end 
      
          pdf.text '6.贵企业在收到此问卷之前对国办8号文件的了解程度：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.known_level}") 
          end     
      
          if @answ.known_way.present?
            pdf.text '6.1 通过哪些途径知晓国办8号文件'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.known_way.join(' ') + '：' + @answ.known_way_other}") 
            end           
          end
      
          pdf.text '7.贵企业认为国办8号文件的颁布实施，对强化我国企业技术创新主体地位、全面提升企业创新能力的意义和指导作用如何？'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.sense}") 
          end         
          pdf.text sec_info,:size => 14
      
          pdf.text '（一）进一步完善引导企业加大技术创新投入的机制',:size => 13
      
          pdf.text '1.企业是否制定了中长期技术创新发展规划：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.plan}") 
          end       
          pdf.text '2.企业是否设立了专门的技术创新管理部门：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.innovate}") 
          end       
          pdf.text '3.近三年研发投入是否逐年增加：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.devotion}") 
          end  
          pdf.text '3.1 2013年本企业研发投入占销售收入的大致比例'
          pdf.indent(20) do 
             convert_font_msyh(pdf,"#{@answ.percent}%") 
          end  
          pdf.text '3.2 研发投入强度是否能够满足企业技术创新需求：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.satisfy}") 
          end  
          pdf.text '4.企业是否曾牵头承担中央或地方财政资助的科技计划项目：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.lead}") 
          end  
          pdf.text '5.企业是否支持科研项目经费后补助政策：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.support}") 
          end  
          if @answ.suggest.present?
            pdf.text '5.1 您的企业支持该政策，对于政策实施有什么建议'
            pdf.indent(20) do 
              convert_font_msyh(pdf,"#{@answ.suggest}") 
            end       
          end
      
          if @answ.reason.present?
            pdf.text '5.2您的企业不支持该政策，原因是：'
            pdf.indent(20) do 
              convert_font_msyh(pdf,"#{@answ.reason}") 
            end       
          end
      
      
          pdf.text '6.中央或地方科技计划项目的征集或指南编制时是否征求企业有关专家意见：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.seek}") 
          end  
          pdf.text '7.相关部门考核本企业技术创新的经营业绩时，是否将研发投入视同利润纳入考核：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.appraise}") 
          end  
          pdf.text '7.1对建立健全国有企业技术创新的经营业绩考核制度的建议：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.appra_suggest}") 
          end  
          pdf.text '8.贵企业在技术创新方面获得国有资本经营预算资金的支持情况'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.cash_support}") 
          end 
      
          pdf.text '（二）支持企业建立研发机构',:size => 13
      
          pdf.text '9.贵企业是否建立了研发机构：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.have_innovate}") 
          end
          if @answ.innovate_type.present?
            pdf.text '9.1 贵企业拥有以下哪些国家级或省级的研发机构'
            pdf.indent(20) do 
              convert_font_msyh(pdf,"#{@answ.innovate_type.join(' ') + '：' + @answ.innovate_type_other}") 
            end
          end
      
          if @answ.prefer_policy.present?
            pdf.text '9.2 如果本企业拥有国家重点实验、国家工程（技术）研究中心、国家认定的企业技术中心，'
            pdf.text '是否享受了进口科技开发用品税收优惠政策：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.prefer_policy}")    
            end
          end
      
      
          if @answ.policy_problem.present?
            pdf.text '9.3 在申请和享受该项税收优惠政策过程中，存在的主要问题及建议：'
            pdf.indent(20) do 
              convert_font_msyh(pdf,"#{@answ.policy_problem}")  
            end
          end
      
          pdf.text '（三）支持企业推进重大科技成果产业化',:size => 13
      
          pdf.text '10.贵企业在科技成果推广应用和产业化方面，获得国家或本地区相关政策支持情况：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.support_action}") 
          end
          pdf.text '11.贵企业更希望获得政府部门哪些方面的支持：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.support_facet.join(' ') + '：' + @answ.support_facet_other}") 
          end
          pdf.text '（四）以企业为主导发展产业技术创新战略联盟',:size => 13
      
          pdf.text '12.贵企业是否牵头或参与本领域相关产业技术创新战略联盟：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.innovate_union}")
          end
          
          if @answ.union_support.present?
            pdf.text '12.1 所在联盟更希望获得政府部门哪些方面的支持（可多选）：'
            pdf.indent(20) do 
              convert_font_msyh(pdf,"#{@answ.union_support.join(' ') + '：' + @answ.union_support_other}")
            end
            
          end
      
          pdf.text '12.2 贵企业认为政府部门倡导的以企业为主导发展产业技术创新联盟，其运行中存在的问题及建议'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.gov_union_prob}")
          end
          pdf.text '（五）依托转制院所和行业领军企业构建产业共性技术研发基地',:size => 13
          pdf.text '13.贵企业是否为相关产业共性技术研发基地的依托单位：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.rely_company}")
          end
          
          pdf.text '13.1 在加强共性技术研发和成果推广扩散方面，得到了政府部门的哪些支持：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.what_support}")
          end
          
          pdf.text '13.2 在产业共性技术研发基地建设、运行和技术扩散服务方面，存在的主要问题及建议：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.innovate_prob}")
          end
      
          pdf.text '（六）强化科研院所和高等学校对企业技术创新的源头支持',:size => 13
      
          pdf.text '14.贵企业与科研院所、高等学校开展技术创新合作，主要采取了哪些方式'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.cooperate_type.join(' ') + '：' + @answ.cooperate_type_other}")
          end
          pdf.text '14.1 企业在与科研院所、高等学校开展技术创新合作方面，存在的主要问题及建议'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.cooperate_prob}")
          end
             
          pdf.text '（七）完善面向企业的技术创新服务平台',:size => 13
      
          pdf.text '15.贵企业是否享受过技术创新服务平台或科技中介服务机构提供的服务：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.service_support}")
          end    
          
          if @answ.no_supp_reason.present?
            pdf.text '15.1 贵企业没有享受过技术创新服务平台或科技中介服务机构提供的服务的原因是'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.no_supp_reason.join(' ') + '：' + @answ.no_supp_reason_other}")
            end     
            
          end
      
          pdf.text '16.面向企业技术创新需求，建议平台加强的服务内容为:'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.service_content.join(' ') + '：' + @answ.service_content_other}")
          end  
          
          pdf.text '（八）加强企业创新人才队伍建设',:size => 13
      
          pdf.text '17.贵企业是否曾引进海外高层次人才：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.adv_person}")
          end      
          
          if @answ.adv_p_support.present?
            pdf.text '17.1 企业在引进海外高层次人才时是否得到海外高层次人才引进计划、创新人才推进'
            pdf.text '计划等政策支持：' 
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.adv_p_support}")
            end         
          end
      
          if @answ.no_adv_reason.present?
            pdf.text '17.2 企业在引进海外高层次人才时没有得到海外高层次人才引进计划、创新人才推进计划等政策支持'
            pdf.text '的原因是：' 
            pdf.indent(20) do
              if @answ.no_adv_reason == '其他'
                convert_font_msyh(pdf,"#{@answ.no_adv_reason}:#{@answ.no_adv_reason_other}")
              else
                convert_font_msyh(pdf,"#{@answ.no_adv_reason}")
              end
            end         
          end
      
          pdf.text '18.贵企业为吸引和凝聚创新人才，是否实施了股权或分红激励措施：'
          pdf.indent(20) do
            if @answ.adv_reward == '否'
              convert_font_msyh(pdf,"#{@answ.adv_reward}:#{@answ.adv_reward_other}")
            else
              convert_font_msyh(pdf,"#{@answ.adv_reward}")
            end
            
          end         
          
            
          if @answ.reward_reason.present?
            pdf.text '18.1 实施股权或分红激励的主要原因是：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.reward_reason}")
            end       
          end
          
          pdf.text '（九）推动科技资源开放共享',:size => 13
          
          pdf.text '19.本企业是否曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.use_school}")
          end       
          
          if @answ.no_use_school.present?
            pdf.text '19.1 本企业不曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源的主要原因是：'
            pdf.indent(20) do
              if @answ.no_use_school == '其他'
                convert_font_msyh(pdf,"其他:#{@answ.no_use_school_other}")
              else
                convert_font_msyh(pdf,"#{@answ.no_use_school}")
              end
              
            end         
          end
      
          pdf.text '20.本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是否曾使用过：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.sent_out}")
          end     
            
          if @answ.no_sent_out_res.present?
            pdf.text '20.1 本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位不曾使用过的'
            pdf.text '主要原因是：'
            pdf.indent(20) do
              if @answ.no_sent_out_res == '其他'
                convert_font_msyh(pdf,"其他:#{@answ.no_sent_out_res_other}")
              else
                convert_font_msyh(pdf,"#{@answ.no_sent_out_res}")
              end
              
            end       
          end
      
      
          pdf.text '20.2 目前公共科技资源开放共享方面存在的问题及建议：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.pub_tech_prob}")
          end      
      
          pdf.text '（十）提升企业技术创新开放合作水平',:size => 13
      
          pdf.text '21.企业是否开展国际创新合作：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.innovate_world}")
          end        
          
          if @answ.world_type.present?
            pdf.text '21.1 企业开展国际创新合作采取了如下哪些形式：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.world_type.join(' ') + '：' + @answ.world_type_other}")
            end   
          end
          
          pdf.text '企业在开展国际创新合作中，存在的问题及建议：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.world_problem}")
          end       
      
          pdf.text '（十一）完善支持企业技术创新的财税金融等政策',:size => 13
      
          pdf.text '22.贵企业是否享受了企业研发费用加计扣除政策：'
          pdf.indent(20) do 
            convert_font_msyh(pdf,"#{@answ.deduct_prolicy}")
          end
          if @answ.deduct_usage.present?
            pdf.text '22.1 该政策对促进贵企业加大研发投入的作用和影响：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.deduct_usage}")
            end         
          end
      
          if @answ.no_deduct_rea.present?
            pdf.text '22.2 贵企业没有享受企业研发费用加计扣除政策的原因是：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.no_deduct_rea.join(' ') + '：' + @answ.no_deduct_rea_other}")
            end         
          end
      
          pdf.text '22.3 您对进一步落实和完善企业研发费用加计扣除政策有何建议：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.deduct_suggest}")
          end       
      
          pdf.text '23.贵企业是否享受了企业研发仪器设备加速折旧政策：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.depreciation}")
          end         
      
          if @answ.deprecia_usage.present?
            pdf.text '23.1 该政策对促进贵企业增加科技开发、加快仪器设备更新换代的作用：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.deprecia_usage}")
            end       
          end
      
          if @answ.no_deprecia.present?
            pdf.text '23.2 贵企业没有享受企业研发仪器设备加速折旧政策的原因是：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.no_deprecia.join(' ') + '：' + @answ.no_deprecia_other}")
            end         
          end
      
          pdf.text '23.3 您对进一步落实和完善企业研发仪器设备加速折旧政策有何建议：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.deprec_suggest}")
          end      
          
          pdf.text '24.贵企业是否为高新技术企业：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.adv_company}")
          end        
          
          if @answ.adv_policy.present?
            pdf.text '24.1 贵企业是否享受了高新技术企业税收优惠（按15%的企业所得税率）政策：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.adv_policy}")
            end         
          end
      
          pdf.text '24.2 您对高新技术企业认定工作，以及对改进和完善高企认定管理办法有何建议：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.adv_suggest}")
          end      
          
      
          pdf.text '（十二）总体评价和建议',:size =>  13
      
          pdf.text '25.贵企业对国办8号文件目前贯彻落实情况的总体评价：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.state_rate}")
          end         
      
          pdf.text '26.您认为当前国有企业开展技术创新活动面临的主要问题和挑战：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.innovate_chan}")
          end   
          pdf.text '27.贯彻落实国办8号文件存在的主要问题及有关建议：'
          pdf.indent(20) do
            convert_font_msyh(pdf,"#{@answ.eight_suggest}")
          end  
      
          pdf.text '如方便请留下问卷填写人的联络信息，以便我们与您联系',:size => 13
      
          if @answ.uname.present?
            pdf.text '姓名：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.uname}")
            end       
          end
      
          if @answ.u_company.present?
            pdf.text '所在部门：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.u_company}")
            end       
          end
          if @answ.position.present?
            pdf.text '职务：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.position}")
            end       
          end
          if @answ.tel.present?
            pdf.text '联系电话：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.tel}")
            end       
          end
      
          if @answ.email.present?
            pdf.text '电子信箱：'
            pdf.indent(20) do
              convert_font_msyh(pdf,"#{@answ.email}")
            end       
          end
      
      end
      pdf.render_file "#{Rails.root.to_s}/public/pdfs/#{@answ.id.to_s}.pdf"      
    end

    def convert_font_msyh(pdf,txt)
      pdf.text txt,:style => :msyh
    end

    def download_pdf(id)
      pdf_filename = File.join(Rails.root.to_s, "/public/pdfs/#{id}.pdf")
      if File.exist?(pdf_filename)
        send_file(pdf_filename, :filename => "#{id}.pdf", :type => "application/pdf", :diposition => "inline")
      end
    end


end
