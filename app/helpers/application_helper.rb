module ApplicationHelper
	def selected?(att,str)
		res = false
		res = true if att.present? && att.include?(str)
	end
end
