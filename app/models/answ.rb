class Answ
  include Mongoid::Document
  include Mongoid::Timestamps

  EDIT   = 1
  FINISH = 2




  field :company,    	 :type => String  #公司名称
  field :address,    	 :type => String  #地址
  field :tech_domain,	 :type => String  #技术领域
  field :company_type,	 :type => String  #公司类型
  field :company_size,   :type => String  #公司规模
  field :known_level,    :type => String  #知晓程度
  field :known_way,      :type => String  #知晓途径
  field :sense,          :type => String  #文件意义
  field :plan,           :type => Boolean #是否定制了长期发展创新计划
  field :innovate,       :type => Boolean #是否设立了技术创新管理部门
  field :devotion,       :type => String  #研发投入
  field :percent,        :type => Integer #2013年 研发投入占销售收入比例
  field :satisfy,        :type => Boolean # 研发投入是否满足企业创新年需求
  field :lead,           :type => Boolean # 企业是否曾牵头财政资助的科技项目
  field :support,        :type => Boolean # 企业是否支持科研项目经费后补政策
  field :suggest,        :type => String  #对政策实施的建议
  field :reason,         :type => String #企业不支持该政策原因
  field :seek,           :type => Boolean # 是否征求了企业有关专家的意见
  field :appraise,       :type => Boolean # 是否将雁塔投入视同利润纳入考核
  field :appra_suggest,  :type => String  # 对国有企业技术长信业绩好客制度的建议
  field :cash_support,   :type => String  # 企业在获得国有资本资金的支持状况
  field :have_innovate,  :type => Boolean # 企业是否建立了研发机构
  field :innovate_type,  :type => String  # 企业拥有哪些国家级或省级研发机构
  field :prefer_policy,  :type => String  # 企业是否享受了税收优惠政策
  field :policy_problem, :type => String  # 享受税收政策的时候存在的问题
  field :support_action, :type => String  # 企业获得相关政策的支持情况
  field :support_facet,  :type => String  # 企业希望获得政府部门哪些方面的支持
  field :innovate_union, :type => Boolean # 企业是否参与技术创新联盟
  field :union_support,  :type => String  # 联盟希望获得哪些方面的支持
  field :gov_union_prob, :type => String  # 政府倡导技术创新联盟运行中的问题及建议
  field :rely_company,   :type => Boolean # 企业是否依托单位
  field :what_support,   :type => String  # 得到了蒸功夫部门的哪些支持
  field :innovate_prob,  :type => String  # 在产业共性技术研发基地建设、运行和技术扩散服务方面，存在的主要问题及建议
  field :cooperate_type, :type => Array   # 企业与科研院所、高等学校开展技术创新合作，主要采取了哪些方式
  field :cooperate_prob, :type => String  # 企业在与科研院所、高等学校开展技术创新合作方面，存在的主要问题及建议
  field :service_support,:type => Boolean # 企业是否享受过技术创新服务平台或科技中介服务机构提供的服务
  field :no_supp_reason, :type => Array   # 企业没有享受过技术创新服务平台或科技中介服务机构提供的服务的原因
  field :service_content,:type => Array   # 面向企业技术创新需求，建议平台加强的服务内容
  field :adv_person,     :type => Boolean # 是否引进海外高级人才
  field :adv_p_support,  :type => Boolean # 企业在引进海外高层次人才时是否得到海外高层次人才引进计划、创新人才推进计划等政策支持
  field :no_adv_reason,  :type => String  # 企业在引进海外高层次人才时没有得到海外高层次人才引进计划、创新人才推进计划等政策支持的原因是
  field :adv_reward,     :type => String  # 贵企业为吸引和凝聚创新人才，是否实施了股权或分红激励措施 
  field :no_rew_reason,  :type => String  # 未实施了股权或分红激励措施原因
  field :reward_reason,  :type => String  # 实施股权或分红激励的主要原
  field :use_school,     :type => Boolean # 企业是否曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源
  field :no_use_school,  :type => String   # 企业不曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源的主要原因
  field :sent_out,       :type => Boolean # 企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是否曾使用过
  field :no_sent_out_res,:type => String  # 本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是不曾使用过的主要原因
  field :pub_tech_prob,  :type => String  # 目前公共科技资源开放共享方面存在的问题及建议
  field :innovate_world, :type => Boolean # 企业是否开展国际创新合作
  field :world_type,     :type => Array   # 开展国际创新合作采取了如下哪些形式
  field :world_problem,  :type => String  # 开展国际创新合作中，存在的问题和建议
  field :deduct_prolicy, :type => Boolean # 企业是否享受了企业研发费用加计扣除政策
  field :deduct_usage,   :type => String  # 该政策对促进贵企业加大研发投入的作用和影响
  field :no_deduct_rea,  :type => Array   # 企业没有享受了企业研发费用加计扣除政策的原因
  field :deduct_suggest, :type => String  # 您对进一步落实和完善企业研发费用加计扣除政策有何建议
  field :depreciation,   :type => Boolean # 企业是否享受了企业研发仪器设备加速折旧政策
  field :deprecia_usage, :type => String  # 该政策对促进贵企业增加科技开发、加快仪器设备更新换代的作用
  field :no_deprecia,    :type => String  # 企业没有享受企业研发仪器设备加速折旧政策的原因
  field :deprec_suggest, :type => String  # 您对进一步落实和完善企业研发仪器设备加速折旧政策有何建议
  field :adv_company,    :type => Boolean # 贵企业是否为高新技术企业
  field :adv_policy,     :type => Boolean # 企业是否享受了高新技术企业税收优惠
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
  field :status,         :type => Integer # 标示是否回答完毕


  field :know_way_other,         :type => String
  field :innovate_type_other,    :type => String
  field :support_facet_other,    :type => String
  field :union_support_other,    :type => String
  field :cooperate_type_other,   :type => String
  field :no_supp_reason_other,   :type => String
  field :service_content_other,  :type => String
  field :no_adv_reason_other,    :type => String
  field :no_use_school_other,    :type => String
  field :no_sent_out_res_other,  :type => String
  field :world_type_other,  	 :type => String
  field :no_deduct_rea_other,    :type => String
  field :no_deprecia_other,      :type => String





  def self.add_list
  	arr = []
  	arr << ['请选择',-1]
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


end
