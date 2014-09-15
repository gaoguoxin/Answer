# encoding: utf-8
require 'spreadsheet'
require 'csv'

class Answ
  include Mongoid::Document
  include Mongoid::Timestamps

  EDIT   = 1
  FINISH = 2
  PRINT  = 3




  field :company,    	   :type => String  # 企业名称
  field :address,    	   :type => String  # 您企业所在的地区是
  field :tech_domain,	   :type => String  # 企业所属技术领域
  field :company_person_count,   :type => String  # 企业人数
  field :company_income, :type => String
  field :known_level,    :type => String  # 贵企业在收到此问卷之前对国办发8号文件的了解程度
  field :known_way,      :type => Array   # 通过哪些途径知晓
  field :sense,          :type => String  # 贵企业认为国办发8号文件的颁布实施，对强化我国企业技术创新主体地位、全面提升企业创新能力的意义和指导作用如何
  field :plan,           :type => String  # 企业是否制定了中长期技术创新发展规划
  field :innovate,       :type => String  # 企业是否设立了专门的技术创新管理部门

  field :devotion,       :type => String  # 近三年研发投入是否逐年增加
  field :percent,        :type => Float # 2013年本企业研发投入占销售收入的大致比例 
  field :satisfy,        :type => String  # 研发投入强度是否能够满足企业技术创新需求
  field :lead,           :type => String  # 企业是否曾牵头承担中央或地方财政资助的科技计划项目
  field :support,        :type => String  # 企业是否支持科研项目经费后补助政策
  field :suggest,        :type => String  # 您的企业支持该政策，对于政策实施有什么建议
  field :reason,         :type => String  # 您的企业不支持该政策，原因是
  field :seek,           :type => String  # 中央或地方科技计划项目的征集或指南编制时是否征求企业有关专家意见
  field :appraise,       :type => String  # 相关部门考核本企业技术创新的经营业绩时，是否将研发投入视同利润纳入考核
  field :appra_suggest,  :type => String  # 对建立健全国有企业技术创新的经营业绩考核制度的建议

  field :cash_support,   :type => String  # 贵企业在技术创新方面获得国有资本经营预算资金的支持情况
  field :have_innovate,  :type => String  # 贵企业是否建立了研发机构
  field :innovate_type,  :type => Array   # 贵企业拥有以下哪些国家级或省级的研发机构
  field :prefer_policy,  :type => String  # 如果本企业拥有国家重点实验、国家工程（技术）研究中心、国家认定的企业技术
  field :policy_problem, :type => String  # 在申请和享受该项税收优惠政策过程中，存在的主要问题及建议
  field :support_action, :type => String  # 贵企业在科技成果推广应用和产业化方面，获得国家或本地区相关政策支持情况
  field :support_facet,  :type => Array   # 贵企业更希望获得政府部门哪些方面的支持
  field :innovate_union, :type => String  # 贵企业是否牵头或参与本领域相关产业技术创新战略联盟
  field :union_support,  :type => Array  # 所在联盟更希望获得政府部门哪些方面的支持
  field :gov_union_prob, :type => String  # 贵企业认为政府部门倡导的以企业为主导发展产业技术创新联盟，其运行中存在的问题及建议


  field :rely_company,   :type => String  # 贵企业是否为相关产业共性技术研发基地的依托单位
  field :what_support,   :type => String  # 在加强共性技术研发和成果推广扩散方面，得到了政府部门的哪些支持
  field :innovate_prob,  :type => String  # 在产业共性技术研发基地建设、运行和技术扩散服务方面，存在的主要问题及建议
  field :cooperate_type, :type => Array   # 贵企业与科研院所、高等学校开展技术创新合作，主要采取了哪些方式
  field :cooperate_prob, :type => String  # 企业在与科研院所、高等学校开展技术创新合作方面，存在的主要问题及建议
  field :service_support,:type => String  # 贵企业是否享受过技术创新服务平台或科技中介服务机构提供的服务
  field :no_supp_reason, :type => Array   # 贵企业没有享受过技术创新服务平台或科技中介服务机构提供的服务的原因是
  field :service_content,:type => Array   # 面向企业技术创新需求，建议平台加强的服务内容为
  field :adv_person,     :type => String  # 贵企业是否曾引进海外高层次人才
  field :adv_p_support,  :type => String  # 企业在引进海外高层次人才时是否得到海外高层次人才引进计划、创新人才推进计划等政策支持
  
  field :no_adv_reason,  :type => String  # 企业在引进海外高层次人才时没有得到海外高层次人才引进计划、创新人才推进计划等政策支持的原因是
  field :adv_reward,     :type => String  # 贵企业为吸引和凝聚创新人才，是否实施了股权或分红激励措施 
  field :reward_reason,  :type => String  # 实施股权或分红激励的主要原
  field :use_school,     :type => String # 企业是否曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源
  field :no_use_school,  :type => String   # 企业不曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源的主要原因
  field :sent_out,       :type => String # 企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是否曾使用过
  field :no_sent_out_res,:type => String  # 本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是不曾使用过的主要原因
  field :pub_tech_prob,  :type => String  # 目前公共科技资源开放共享方面存在的问题及建议
  field :innovate_world, :type => String # 企业是否开展国际创新合作
  field :world_type,     :type => Array   # 开展国际创新合作采取了如下哪些形式

  field :world_problem,  :type => String  # 开展国际创新合作中，存在的问题和建议
  field :deduct_prolicy, :type => String # 企业是否享受了企业研发费用加计扣除政策
  field :deduct_usage,   :type => String  # 该政策对促进贵企业加大研发投入的作用和影响
  field :no_deduct_rea,  :type => Array   # 企业没有享受了企业研发费用加计扣除政策的原因
  field :deduct_suggest, :type => String  # 您对进一步落实和完善企业研发费用加计扣除政策有何建议
  field :depreciation,   :type => String # 企业是否享受了企业研发仪器设备加速折旧政策
  field :deprecia_usage, :type => String  # 该政策对促进贵企业增加科技开发、加快仪器设备更新换代的作用
  field :no_deprecia,    :type => Array  # 企业没有享受企业研发仪器设备加速折旧政策的原因
  field :deprec_suggest, :type => String  # 您对进一步落实和完善企业研发仪器设备加速折旧政策有何建议
  field :adv_company,    :type => String  # 贵企业是否为高新技术企业

  field :adv_policy,     :type => String  # 企业是否享受了高新技术企业税收优惠
  field :adv_suggest,    :type => String  # 您对高新技术企业认定工作，以及对改进和完善高企认定管理办法有何建议
  field :state_rate,     :type => String  # 企业对国办发8号文件目前贯彻落实情况的总体评价
  field :innovate_chan,  :type => String  # 您认为当前国有企业开展技术创新活动面临的主要问题和挑战
  field :eight_suggest,  :type => String  # 贯彻落实国办发8号文件存在的主要问题及有关建议
  field :uname,          :type => String  # 您的姓名
  field :u_company,      :type => String  # 您所在的单位名称
  field :position,       :type => String  # 您的职务
  field :tel,            :type => String  # 您的电话
  field :email,          :type => String  # 您的邮箱

  field :uid,            :type => String  # 回答问题的用户id
  field :status,         :type => Integer,:default => 1 # 标示是否回答完毕

  field :adv_reward_other,       :type => String  # 未实施了股权或分红激励措施原因
  field :known_way_other,        :type => String
  field :innovate_type_other,    :type => String
  field :support_facet_other,    :type => String
  field :union_support_other,    :type => String
  field :cooperate_type_other,   :type => String

  field :no_supp_reason_other,   :type => String
  field :service_content_other,  :type => String
  field :no_adv_reason_other,    :type => String
  field :no_use_school_other,    :type => String
  field :no_sent_out_res_other,  :type => String

  field :world_type_other,  	   :type => String
  field :no_deduct_rea_other,    :type => String
  field :no_deprecia_other,      :type => String

  def self.add_list
  	arr = []
  	arr << ['请选择','']
    arr << ['北京市','北京市']
    arr << ['天津市','天津市']
    arr << ['河北省','河北省']  	
    arr << ['山西省','山西省']  	
    arr << ['内蒙古自治区','内蒙古自治区']  	
    arr << ['辽宁省','辽宁省']  	
    arr << ['吉林省','吉林省']  	
    arr << ['黑龙江','黑龙江']  	
    arr << ['上海市','上海市']  
    arr << ['江苏省','江苏省']  	
    arr << ['浙江省','浙江省']  	
    arr << ['安徽省','安徽省']  		
    arr << ['福建省','福建省']  	
    arr << ['江西省','江西省']  	
    arr << ['山东省','山东省']  
    arr << ['河南省','河南省']  	
    arr << ['湖北省','湖北省']  		
    arr << ['湖南省','湖南省']  	
    arr << ['广东省','广东省']  	
    arr << ['广西自治区','广西自治区']  	
    arr << ['海南省','海南省']  	
    arr << ['重庆市','重庆市']  	
    arr << ['四川省','四川省']  	
    arr << ['贵州省','贵州省']  	
    arr << ['云南省','云南省']  	
    arr << ['西藏自治区','西藏自治区']  	
    arr << ['陕西省','陕西省'] 
    arr << ['甘肃省','甘肃省'] 
    arr << ['宁夏自治区','宁夏自治区'] 
    arr << ['青海省','青海省']  
    arr << ['新疆自治区','新疆自治区'] 
    arr << ['新疆生产建设兵团','新疆生产建设兵团'] 
    arr << ['大连市','大连市'] 
    arr << ['宁波市','宁波市'] 
    arr << ['厦门市','厦门市'] 
    arr << ['青岛市','青岛市'] 
    arr << ['深圳市','深圳市']
    return arr
  end


  def self.col
    arr = []
    brr = []
    arr << '企业名称'
    arr << '您企业所在的地区'
    arr << '企业所属技术领域'
    arr << '企业从业人数'
    arr << '企业年营业收入'
    arr << '贵企业在收到此问卷之前对国办发8号文件的了解程度'
    arr << '通过哪些途径知晓8号文件'
    arr << '企业认为国办发8号文件的颁布实施对强化我国企业技术创新主体地位、全面提升企业创新能力的意义和指导作用如何'
    arr << '企业是否制定了中长期技术创新发展规划'
    arr << '企业是否设立了专门的技术创新管理部门'

    arr << '近三年研发投入是否逐年增加'
    arr << '2013年本企业研发投入占销售收入的大致比例'
    arr << '研发投入强度是否能够满足企业技术创新需求'
    arr << '企业是否曾牵头承担中央或地方财政资助的科技计划项目'
    arr << '企业是否支持科研项目经费后补助政策'
    arr << '您的企业支持该政策对于政策实施有什么建议'
    arr << '您的企业不支持该政策原因是'
    arr << '中央或地方科技计划项目的征集或指南编制时是否征求企业有关专家意见'
    arr << '相关部门考核本企业技术创新的经营业绩时是否将研发投入视同利润纳入考核'
    arr << '对建立健全国有企业技术创新的经营业绩考核制度的建议'

    arr << '贵企业在技术创新方面获得国有资本经营预算资金的支持情况'
    arr << '贵企业是否建立了研发机构'
    arr << '贵企业拥有以下哪些国家级或省级的研发机构'
    arr << '如果本企业拥有国家重点实验、国家工程（技术）研究中心、国家认定的企业技术中心，是否享受了进口科技开发用品税收优惠政策'
    arr << '在申请和享受该项税收优惠政策过程中，存在的主要问题及建议'
    arr << '贵企业在科技成果推广应用和产业化方面，获得国家或本地区相关政策支持情况'
    arr << '贵企业更希望获得政府部门哪些方面的支持'
    arr << '贵企业是否牵头或参与本领域相关产业技术创新战略联盟'
    arr << '所在联盟更希望获得政府部门哪些方面的支持'
    arr << '贵企业认为政府部门倡导的以企业为主导发展产业技术创新联盟，其运行中存在的问题及建议'

    arr << '贵企业是否为相关产业共性技术研发基地的依托单位'
    arr << '在加强共性技术研发和成果推广扩散方面，得到了政府部门的哪些支持'
    arr << '在产业共性技术研发基地建设、运行和技术扩散服务方面，存在的主要问题及建议'
    arr << '贵企业与科研院所、高等学校开展技术创新合作，主要采取了哪些方式'
    arr << '企业在与科研院所、高等学校开展技术创新合作方面，存在的主要问题及建议'
    arr << '贵企业是否享受过技术创新服务平台或科技中介服务机构提供的服务'
    brr << '贵企业没有享受过技术创新服务平台或科技中介服务机构提供的服务的原因是'
    brr << '面向企业技术创新需求，建议平台加强的服务内容为'
    brr << '贵企业是否曾引进海外高层次人才'
    brr << '企业在引进海外高层次人才时是否得到海外高层次人才引进计划、创新人才推进计划等政策支持'

    brr << '企业在引进海外高层次人才时没有得到海外高层次人才引进计划、创新人才推进计划等政策支持的原因是'
    brr << '贵企业为吸引和凝聚创新人才，是否实施了股权或分红激励措施'
    brr << '实施股权或分红激励的主要原因是'
    brr << '本企业是否曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源'
    brr << '本企业不曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源的主要原因是'
    brr << '本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是否曾使用过'
    brr << '本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是不曾使用过的主要原因是'
    brr << '目前公共科技资源开放共享方面存在的问题及建议'
    brr << '企业是否开展国际创新合作'
    brr << '企业开展国际创新合作采取了如下哪些形式'

    brr << '企业在开展国际创新合作中，存在的问题和建议'
    brr << '贵企业是否享受了企业研发费用加计扣除政策'
    brr << '该政策对促进贵企业加大研发投入的作用和影响'
    brr << '贵企业没有享受了企业研发费用加计扣除政策的原因是'
    brr << '您对进一步落实和完善企业研发费用加计扣除政策有何建议'
    brr << '贵企业是否享受了企业研发仪器设备加速折旧政策'
    brr << '该政策对促进贵企业增加科技开发、加快仪器设备更新换代的作用'
    brr << '贵企业没有享受企业研发仪器设备加速折旧政策的原因是'
    brr << '您对进一步落实和完善企业研发仪器设备加速折旧政策有何建议'
    brr << '贵企业是否为高新技术企业'

    brr << '贵企业是否享受了高新技术企业税收优惠（按15%的企业所得税率）政策'
    brr << '您对高新技术企业认定工作，以及对改进和完善高企认定管理办法有何建议'
    brr << '贵企业对国办发8号文件目前贯彻落实情况的总体评价'
    brr << '您认为当前国有企业开展技术创新活动面临的主要问题和挑战'
    brr << '贯彻落实国办发8号文件存在的主要问题及有关建议'
    brr << '您的姓名'
    brr << '所在部门'
    brr << '您的职务'
    brr << '您的联系电话'
    brr << '您的常用的电子信箱'

    arr + brr

  end

  def ad
    arr = []
    arr << self.company
    arr << self.address
    arr << self.tech_domain
    arr << self.company_person_count
    arr << self.company_income
    arr << self.known_level
    if self.known_way.present?
      if self.known_way.include?('其他')
        arr << (self.known_way.join(' ') + ':' +  self.known_way_other.to_s)
      else
        arr << self.known_way.join('')
      end
    else
      arr   <<  ''
    end
    arr << self.sense
    arr << self.plan
    arr << self.innovate




    arr << self.devotion
    arr << (self.percent.to_s + '%')
    arr << self.satisfy
    arr << self.lead
    arr << self.support
    arr << self.suggest
    arr << self.reason
    arr << self.seek
    arr << self.appraise
    arr << self.appra_suggest





    arr << self.cash_support
    arr << self.have_innovate
    if self.innovate_type.present?
      if self.innovate_type.include?('其他')
        arr << (self.innovate_type.join(' ') + ':' + self.innovate_type_other.to_s)
      else
        arr << self.innovate_type.join(' ')
      end
    else
      arr << ''
    end
    arr << self.prefer_policy
    arr << self.policy_problem
    arr << self.support_action
    if self.support_facet.present?
      if self.support_facet.include?('其他')
        arr << (self.support_facet.join(' ') + ':' + self.support_facet_other.to_s)
      else
        arr << self.support_facet.join(' ')
      end
    else
      arr << ''
    end
    arr << self.innovate_union

    if self.union_support.present?
      if self.union_support.include?('其他')
        arr << (self.union_support.join(' ') + ':' + self.union_support_other.to_s)
      else
        arr << self.union_support.join(' ')
      end
    else
      arr << ''
    end

    arr << self.gov_union_prob
  





    arr << self.rely_company
    arr << self.what_support
    arr << self.innovate_prob
    if self.cooperate_type.present?
      if self.cooperate_type.include?('其他')
        arr << (self.cooperate_type.join(' ') + ':' + self.cooperate_type_other.to_s)
      else
        arr << self.cooperate_type.join(' ')
      end      
    else
      arr << ''
    end
    arr << self.cooperate_prob
    arr << self.service_support
    if self.no_supp_reason.present?
      if self.no_supp_reason.include?('其他')
        arr << (self.no_supp_reason.join(' ') + ':' + self.no_supp_reason_other.to_s)
      else
        arr << self.no_supp_reason.join(' ')
      end      
    else
      arr << ''
    end
    if self.service_content.present?
      if self.service_content.include?('其他')
        arr << (self.service_content.join(' ') + ':' + self.service_content_other.to_s)
      else
        arr << self.service_content.join(' ')
      end      
    else
      arr << ''
    end
    arr << self.adv_person
    arr << self.adv_p_support



    if self.no_adv_reason == '其他'
      arr << (self.no_adv_reason  + ':' + self.no_adv_reason_other.to_s)
    else
      arr << self.no_adv_reason
    end
    if self.adv_reward == '否'
      arr << ('否(原因:' + self.adv_reward_other + ')')
    else
      arr << '是'
    end
    arr << self.reward_reason
    arr << self.use_school
    if self.no_use_school == '其他'
      arr << (self.no_use_school + '(:' + self.no_use_school_other.to_s + ')')
    else
      arr << self.no_use_school
    end
    arr << self.sent_out
    if self.no_sent_out_res == '其他'
      arr << (self.no_sent_out_res + '(:' + self.no_sent_out_res_other.to_s + ')')
    else
      arr << self.no_sent_out_res
    end
    arr << self.pub_tech_prob
    arr << self.innovate_world
    if self.world_type.present?
      if self.world_type.include?('其他')
        arr << (self.world_type.join(' ') + ':' + self.world_type_other.to_s)
      else
        arr << self.world_type.join(' ')
      end      
    else
      arr << ''
    end

 



    arr << self.world_problem
    arr << self.deduct_prolicy
    arr << self.deduct_usage
    if self.no_deduct_rea.present?
      if self.no_deduct_rea.include?('其他')
        arr << (self.no_deduct_rea.join(' ') + ':' + self.no_deduct_rea_other.to_s)
      else
        arr << self.no_deduct_rea.join(' ')
      end      
    else
      arr << ''
    end
    arr << self.deduct_suggest
    arr << self.depreciation
    arr << self.deprecia_usage


    if self.no_deprecia.present?
      if self.no_deprecia.include?('其他')
        arr << (self.no_deprecia.join(' ') + ':' + self.no_deprecia_other.to_s)
      else
        arr << self.no_deprecia.join(' ')
      end      
    else
      arr << ''
    end

    arr << self.deprec_suggest
    arr << self.adv_company

    arr << self.adv_policy
    arr << self.adv_suggest
    arr << self.state_rate
    arr << self.innovate_chan
    arr << self.eight_suggest
    arr << self.uname
    arr << self.u_company
    arr << self.position
    arr << self.tel
    arr << self.email



  end

  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << self.col
  #     all.each do |product|
  #       csv << product.ad
  #     end
  #   end
  # end


  def self.to_csv
    file = Spreadsheet::Workbook.new
    Spreadsheet.client_encoding = 'UTF-8'
    sheet1 = file.create_worksheet
    sheet1.name = '数据导出报告'  
    sheet1.insert_row 0, self.col
    self.where(:status.ne => EDIT).each_with_index do |ans,idx|
      sheet1.insert_row idx+1, ans.ad
    end
    path = Rails.root.to_s + "/public/export_data.xls"
    file.write path
    return path
  end






end
