@answ = Answ.find(params[:id])


pdf.font_families.update("MyTrueTypeFamily" => { :normal => "#{Rails.root.to_s}/public/msyh.ttf" })

title = '国有企业贯彻落实“国办发8号文件”情况调查问卷'
describe_0 = '各有关企业：'
describe_1 = '为跟踪了解《国务院办公厅关于强化企业技术创新主体地位全面提升企业创新能力的意见》'
describe_2 = '（国办发〔2013〕8号，简称“国办发8号文件”）及相应政策措施在企业的落实情况，分析政策实施中存在的问题与不足，完善相关政策及操作办法，方便企业更好、更便捷地享受到政策优惠，我们设计了本问卷。请结合本企业实际情况认真、如实填写，于8月15日前登陆国家科技评估中心主页（http://www.ncste.org）在线提交。我们将妥善使用贵企业提供的宝贵信息，并保证不向任何无关机构或个人透漏。为确保问卷质量，建议由贵企业分管技术创新工作的人员填写。选择题部分，除另有说明外，均为单选。'

contact = '联 系 人：李睆玲'
tel     = '联系电话：010-62169570'
fax     = '传真号码：010-88232615'
address = '通讯地址：北京市海淀区皂君庙乙7号(邮编:100081)'
thx     = '衷心感谢您的支持与配合！'

company = '国家科技评估中心'
date    = '2014年9月19日'

basic_info = '一、基本信息'

sec_info   = '二、国办发8号文件相关政策措施落实情况'


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
    pdf.text '1.企业名称：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.company}"
    end

    pdf.text '2.企业所在的地区是：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.address}"
    end    

    pdf.text '3.企业所属技术领域：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.tech_domain}"
    end        

    pdf.text '4.企业类型：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.company_type}"
    end 

    pdf.text '5.企业规模：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.company_size}"
    end 

    pdf.text '6.贵企业在收到此问卷之前对国办发8号文件的了解程度：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.known_level}"
    end     

    if @answ.known_way.present?
    	pdf.text '6.1 通过哪些途径知晓8号文件'
    	pdf.indent(20) do
    		pdf.text "#{@answ.known_way.join(' ') + @answ.known_way_other}"
    	end         	
    end

    pdf.text '7.贵企业认为国办发8号文件的颁布实施，对强化我国企业技术创新主体地位、全面提升企业创新能力的意义和指导作用如何？'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.sense}"
    end         
    pdf.text sec_info,:size => 14

    pdf.text '（一）进一步完善引导企业加大技术创新投入的机制',:size => 13

    pdf.text '1.企业是否制定了中长期技术创新发展规划：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.plan}"
    end       
    pdf.text '2.企业是否设立了专门的技术创新管理部门：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.innovate}"
    end       
    pdf.text '3.近三年研发投入是否逐年增加：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.devotion}"
    end  
    pdf.text '3.1 2013年本企业研发投入占销售收入的大致比例'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.percent}"
    end  
    pdf.text '3.2 研发投入强度是否能够满足企业技术创新需求：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.satisfy}"
    end  
    pdf.text '4.企业是否曾牵头承担中央或地方财政资助的科技计划项目：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.lead}"
    end  
    pdf.text '5.企业是否支持科研项目经费后补助政策：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.support}"
    end  
    if @answ.suggest.present?
    	pdf.text '5.1 您的企业支持该政策，对于政策实施有什么建议'
    	pdf.indent(20) do 
    		 pdf.text "#{@answ.suggest}"
    	end      	
    end

    if @answ.reason.present?
    	pdf.text '5.2您的企业不支持该政策，原因是：'
    	pdf.indent(20) do 
    		 pdf.text "#{@answ.reason}"
    	end      	
    end


    pdf.text '6.中央或地方科技计划项目的征集或指南编制时是否征求企业有关专家意见：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.seek}"
    end  
    pdf.text '7.相关部门考核本企业技术创新的经营业绩时，是否将研发投入视同利润纳入考核：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.appraise}"
    end  
    pdf.text '7.1对建立健全国有企业技术创新的经营业绩考核制度的建议：'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.appra_suggest}"
    end  
    pdf.text '8.贵企业在技术创新方面获得国有资本经营预算资金的支持情况'
    pdf.indent(20) do 
    	 pdf.text "#{@answ.cash_support}"
    end 

    pdf.text '（二）支持企业建立研发机构',:size => 13

    pdf.text '9.贵企业是否建立了研发机构：'
    pdf.indent(20) do 
    	pdf.text "#{@answ.have_innovate}"
    end
    if @answ.innovate_type.present?
    	pdf.text '9.1 贵企业拥有以下哪些国家级或省级的研发机构'
    	pdf.indent(20) do 
    		pdf.text "#{@answ.innovate_type.join(' ') + @answ.innovate_type_other}"
    	end
    end

    if @answ.prefer_policy.present?
    	pdf.text '9.2 如果本企业拥有国家重点实验、国家工程（技术）研究中心、国家认定的企业技术中心，是否享受了进口科技开发用品税收优惠政策：'
    	pdf.indent(20) do 	
    		pdf.text "#{@answ.prefer_policy}"
    	end
    end


    if @answ.policy_problem.present?
    	pdf.text '9.3 在申请和享受该项税收优惠政策过程中，存在的主要问题及建议：'
    	pdf.indent(20) do 
    		pdf.text "#{@answ.policy_problem}"
    	end
    end

    pdf.text '（三）支持企业推进重大科技成果产业化',:size => 13

    pdf.text '10.贵企业在科技成果推广应用和产业化方面，获得国家或本地区相关政策支持情况：'
    pdf.indent(20) do 
    	pdf.text "#{@answ.support_action}"
    end
    pdf.text '11.贵企业更希望获得政府部门哪些方面的支持：'
    pdf.indent(20) do 
    	pdf.text "#{@answ.support_facet.join(' ') + @answ.support_facet_other}"
    end
    pdf.text '（四）以企业为主导发展产业技术创新战略联盟',:size => 13

    pdf.text '12.贵企业是否牵头或参与本领域相关产业技术创新战略联盟：'
    pdf.indent(20) do 
    	pdf.text "#{@answ.innovate_union}"
    end
    
    if @answ.union_support.present?
    	pdf.text '12.1 所在联盟更希望获得政府部门哪些方面的支持'
    	pdf.indent(20) do 
    		pdf.text "#{@answ.union_support.join(' ') + @answ.union_support_other}"
    	end
    	
    end

    pdf.text '12.2 贵企业认为政府部门倡导的以企业为主导发展产业技术创新联盟，其运行中存在的问题及建议'
    pdf.indent(20) do
    	pdf.text "#{@answ.gov_union_prob}"
    end
    pdf.text '（五）依托转制院所和行业领军企业构建产业共性技术研发基地',:size => 13
    pdf.text '13.贵企业是否为相关产业共性技术研发基地的依托单位：'
    pdf.indent(20) do
    	pdf.text "#{@answ.rely_company}"
    end
    
    pdf.text '13.1 在加强共性技术研发和成果推广扩散方面，得到了政府部门的哪些支持：'
    pdf.indent(20) do
    	pdf.text "#{@answ.what_support}"
    end
    
    pdf.text '13.2 在产业共性技术研发基地建设、运行和技术扩散服务方面，存在的主要问题及建议：'
    pdf.indent(20) do
    	pdf.text "#{@answ.innovate_prob}"
    end

    pdf.text '（六）强化科研院所和高等学校对企业技术创新的源头支持',:size => 13

    pdf.text '14.贵企业与科研院所、高等学校开展技术创新合作，主要采取了哪些方式'
    pdf.indent(20) do
    	pdf.text "#{@answ.cooperate_type.join(' ') + @answ.cooperate_type_other}"
    end
    pdf.text '14.1 企业在与科研院所、高等学校开展技术创新合作方面，存在的主要问题及建议'
    pdf.text "#{@answ.cooperate_prob}"
    pdf.indent(20) do
    	pdf.text "#{@answ.cooperate_prob}"
    end    
    pdf.text '（七）完善面向企业的技术创新服务平台',:size => 13

    pdf.text '15.贵企业是否享受过技术创新服务平台或科技中介服务机构提供的服务：'
    pdf.indent(20) do
    	pdf.text "#{@answ.service_support}"
    end    
    
    if @answ.no_supp_reason.present?
    	pdf.text '15.1 贵企业没有享受过技术创新服务平台或科技中介服务机构提供的服务的原因是'
    	pdf.indent(20) do
    		pdf.text "#{@answ.no_supp_reason.join(' ') + @answ.no_supp_reason_other}"
    	end    	
    	
    end

    pdf.text '16.面向企业技术创新需求，建议平台加强的服务内容为:'
    pdf.indent(20) do
    	pdf.text "#{@answ.service_content.join(' ') + @answ.service_content_other}"
    end  
    
    pdf.text '（八）加强企业创新人才队伍建设',:size => 13

    pdf.text '17.贵企业是否曾引进海外高层次人才：'
    pdf.indent(20) do
    	pdf.text "#{@answ.adv_person}"
    end      
    
    if @answ.adv_p_support.present?
    	pdf.text '17.1 企业在引进海外高层次人才时是否得到海外高层次人才引进计划、创新人才推进计划等政策支持：' 
    	pdf.indent(20) do
    		pdf.text "#{@answ.adv_p_support}"
    	end       	
    end

    if @answ.no_adv_reason.present?
    	pdf.text '17.2 企业在引进海外高层次人才时没有得到海外高层次人才引进计划、创新人才推进计划等政策支持的原因是：' 
    	pdf.indent(20) do
    		if @answ.no_adv_reason == '其他'
    			@answ.no_adv_reason + ":" + @answ.no_adv_reason_other
    		else

    		end
    	end       	
    end

    pdf.text '18.贵企业为吸引和凝聚创新人才，是否实施了股权或分红激励措施：'
    pdf.indent(20) do
    	if @answ.adv_reward == '否'
    		pdf.text "#{@answ.adv_reward}:#{@answ.adv_reward_other}"
    	else
    		pdf.text "#{@answ.adv_reward}"
    	end
    	
    end         
    
    	
    if @answ.reward_reason.present?
    	pdf.text '18.1 实施股权或分红激励的主要原因是：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.reward_reason}"
    	end      	
    end
    
    pdf.text '（九）推动科技资源开放共享',:size => 13
    
    pdf.text '19.本企业是否曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源：'
    pdf.indent(20) do
    	pdf.text "#{@answ.use_school}"
    end       
    
    if @answ.no_use_school.present?
    	pdf.text '19.1 本企业不曾使用科研院所、高校、其他企业的科研设施和仪器设备等科技资源的主要原因是：'
    	pdf.indent(20) do
    		if @answ.no_use_school == '其他'
    			pdf.text "其他:#{@answ.no_use_school_other}"
    		else
    			pdf.text "#{@answ.no_use_school}"
    		end
    		
    	end       	
    end

    pdf.text '20.本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位是否曾使用过：'
    pdf.indent(20) do
    	pdf.text "#{@answ.sent_out}"
    end     
    	
    if @answ.no_sent_out_res.present?
    	pdf.text '20.1 本企业拥有的主要以政府资金投资建设的科研设施和仪器设备等科技资源，外单位不曾使用过的主要原因是：'
    	pdf.indent(20) do
    		if @answ.no_sent_out_res == '其他'
    			pdf.text "其他:#{@answ.no_sent_out_res}"
    		else
    			pdf.text "#{@answ.no_sent_out_res}"
    		end
    		
    	end      	
    end


    pdf.text '20.2 目前公共科技资源开放共享方面存在的问题及建议：'
    pdf.indent(20) do
    	pdf.text "#{@answ.pub_tech_prob}"
    end      

    pdf.text '（十）提升企业技术创新开放合作水平',:size => 13

    pdf.text '21.企业是否开展国际创新合作：'
    pdf.indent(20) do
    	pdf.text "#{@answ.innovate_world}"
    end        
    
    if @answ.world_type.present?
    	pdf.text '21.1 企业开展国际创新合作采取了如下哪些形式：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.world_type.join(' ') + @answ.world_type_other}"
    	end   
    end
    
    pdf.text '21.2 企业在开展国际创新合作中，存在的问题和建议：'
    pdf.indent(20) do
    	pdf.text "#{@answ.world_problem}"
    end       

    pdf.text '（十一）完善支持企业技术创新的财税金融等政策',:size => 13

    pdf.text '22.贵企业是否享受了企业研发费用加计扣除政策：'

    if @answ.deduct_usage.present?
    	pdf.text '22.1 该政策对促进贵企业加大研发投入的作用和影响：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.deduct_usage}"
    	end       	
    end

    if @answ.no_deduct_rea.present?
    	pdf.text '22.2 贵企业没有享受企业研发费用加计扣除政策的原因是：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.no_deduct_rea.join(' ') + @answ.no_deduct_rea_other}"
    	end       	
    end

    pdf.text '22.3 您对进一步落实和完善企业研发费用加计扣除政策有何建议：'
    pdf.indent(20) do
    	pdf.text "#{@answ.deduct_suggest}"
    end       

    pdf.text '23.贵企业是否享受了企业研发仪器设备加速折旧政策：'
    pdf.indent(20) do
    	pdf.text "#{@answ.depreciation}"
    end         

    if @answ.deprecia_usage.present?
    	pdf.text '23.1 该政策对促进贵企业增加科技开发、加快仪器设备更新换代的作用：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.deprecia_usage}"
    	end      	
    end

    if @answ.no_deprecia.present?
    	pdf.text '23.2 贵企业没有享受企业研发仪器设备加速折旧政策的原因是：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.no_deprecia.join(' ') + @answ.no_deprecia_other}"
    	end       	
    end

    pdf.text '23.3 您对进一步落实和完善企业研发仪器设备加速折旧政策有何建议：'
    pdf.indent(20) do
    	pdf.text "#{@answ.deprec_suggest}"
    end      
    
    pdf.text '24.贵企业是否为高新技术企业：'
    pdf.indent(20) do
    	pdf.text "#{@answ.adv_company}"
    end        
    
    if @answ.adv_policy.present?
    	pdf.text '24.1 贵企业是否享受了高新技术企业税收优惠（按15%的企业所得税率）政策：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.adv_policy}"
    	end        	
    end

    pdf.text '24.2 您对高新技术企业认定工作，以及对改进和完善高企认定管理办法有何建议：'
    pdf.indent(20) do
    	pdf.text "#{@answ.adv_suggest}"
    end      
    

    pdf.text '（十二）总体评价和建议',:size =>  13

    pdf.text '25.贵企业对国办发8号文件目前贯彻落实情况的总体评价：'
    pdf.indent(20) do
    	pdf.text "#{@answ.state_rate}"
    end         

    pdf.text '26.您认为当前国有企业开展技术创新活动面临的主要问题和挑战：'
    pdf.indent(20) do
    	pdf.text "#{@answ.innovate_chan}"
    end   
    pdf.text '27.贯彻落实国办发8号文件存在的主要问题及有关建议：'
    pdf.indent(20) do
    	pdf.text "#{@answ.eight_suggest}"
    end  

    pdf.text '如方便请留下问卷填写人的联络信息，以便我们与您联系',:size => 13

    if @answ.uname.present?
    	pdf.text '姓名：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.uname}"
    	end      	
    end

    if @answ.u_company.present?
    	pdf.text '所在单位：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.u_company}"
    	end      	
    end
    if @answ.position.present?
    	pdf.text '职务：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.position}"
    	end      	
    end
    if @answ.tel.present?
    	pdf.text '联系电话：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.tel}"
    	end      	
    end

    if @answ.email.present?
    	pdf.text '电子信箱：'
    	pdf.indent(20) do
    		pdf.text "#{@answ.email}"
    	end      	
    end

end








