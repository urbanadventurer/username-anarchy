# Copyright
# Part of Username Anarchy

class Plugin
	attr_accessor :plugin_name
	@registered_plugins=[]

	class << self
		attr_reader :registered_plugins
		private :new
	end

	def self.define(name, &block)
		p = new
		p.instance_eval(&block)
		p.plugin_name= name
		Plugin.registered_plugins << p
	end

end


Plugin.define "first" do
	def generate(n)
		n.format("%f")
	end
end

Plugin.define "firstlast" do
	def generate(n)
		n.format_anna("annakey")
	end
end


Plugin.define "first.last" do
	def generate(n)
		#n.format("%f.%l")
		n.format_anna("anna.key")
	end
end

Plugin.define "firstlast[8]" do
	def generate(n)
		# fix this. truncated to 8
		(n.firstname + n.lastname).to_s[0..7] unless n.firstname.nil? or n.lastname.nil?		
	end
end


Plugin.define "firstl" do
	def generate(n)
		#n.format("%f.%l")
		n.format_anna("annak")
	end
end

Plugin.define "f.last" do
	def generate(n)
		#n.format("%i.F.%L")
		n.format_anna("a.key")
	end
end

Plugin.define "flast" do
	def generate(n)
		#n.format("%i.F.%L")
		n.format_anna("akey")
	end
end

Plugin.define "lfirst" do
	def generate(n)
		n.format_anna("kanna")
	end
end

Plugin.define "l.first" do
	def generate(n)
		n.format_anna("k.anna")
	end
end

Plugin.define "lastf" do
	def generate(n)
		n.format_anna("keya")
	end
end


Plugin.define "last" do
	def generate(n)
		n.format_anna("key")
	end
end

Plugin.define "last.f" do
	def generate(n)
		n.format_anna("key.a")
	end
end

Plugin.define "last.first" do
	def generate(n)
		n.format_anna("key.anna")
	end
end

Plugin.define "FLast" do
	def generate(n)
		#n.firstinitial + n.lastname
		n.format_anna("AKey")
	end
end

Plugin.define "first1" do
	def generate(n)
		n.format_anna("anna%D")
	end
end

Plugin.define "fl" do
	def generate(n)
		#n.firstinitial + n.lastname
		n.format_anna("ak")
	end
end

Plugin.define "fmlast" do
	def generate(n)
		#n.firstinitial + n.lastname
		n.format_anna("abkey")
	end
end


Plugin.define "firstmiddlelast" do
	def generate(n)
		#n.firstinitial + n.lastname
		n.format_anna("annaboomkey")
	end
end

Plugin.define "fml" do
	def generate(n)
		#n.firstinitial + n.lastname
		n.format_anna("abk")
	end
end

#Plugin.define "canterbury-uni" do
#	def generate(n)
#		#n.firstinitial + n.lastname
#		n.format_anna("abk%DD")
#	end
#end

Plugin.define "FL" do
	def generate(n)
		#n.firstinitial + n.lastname
		n.format_anna("AK")
	end
end


Plugin.define "FirstLast" do
	def generate(n)
		n.format_anna("%F%L")
	end
end

Plugin.define "First.Last" do
	def generate(n)
		n.format_anna("%F.%L")
	end
end

Plugin.define "Last" do
	def generate(n)
		n.format_anna("Key")
	end
end

Plugin.define "FML" do
	def generate(n)
=begin
		# this is the sort of code I want to avoid
		s=""
		s+=n.firstinitial.downcase

		if n.middleinitial
			s+=n.middleinitial
		else
			s+="~"
		end
		s+=n.lastinitial.downcase

		if s=~/~/
			names=('a'..'z').map {|letter| s.sub('~',letter) }
			s=names
		end
		s
=end
		n.format_anna("ABK")
	end
end

