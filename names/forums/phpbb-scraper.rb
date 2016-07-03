#!/usr/bin/env ruby
require "net/http"
require "net/https"
require 'pp'

USERAGENT = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1'

#forum_url="http://djvu.org/forum/phpbb/"
#forum_url="http://cnyimcaracingfo.14.forumer.com/"
# some forums require registration

session_cookies = ''#'phpbb3_1fh61_sid=a11c59c59669bec6d809a606fdf525ba;'
#curl -b "phpbb3_1fh61_sid=a11c59c59669bec6d809a606fdf525ba" http://www.phpbb.com/community/memberlist.php

File.read("./find-forums/set2c-part2.log").each do |forum_url|
	begin
		forum_url.strip!
		puts forum_url
		puts "*" * 80
		members=[]
		members_per_page=0 # default

		(0..40).each do |n|
			page_offset = n * members_per_page
	
			unless page_offset == 0
				url_suffix = "?start=#{page_offset}" 
			else
				url_suffix = ""
			end

			url=URI.parse(forum_url + "memberlist.php" + url_suffix)

			req=Net::HTTP::Get.new(url.path + ( url.query ?  "/?" + url.query : ""), 
				{'Cookie'=> session_cookies })

			begin
				res = Net::HTTP.start(url.host,url.port) { |http| http.request(req) }
			rescue
				next
			rescue Timeout::Error
				next
			end
			body= res.body
		
			if n==0
				# check members per page
				# Goto page <b>1</b>, <a href="memberlist.php?mode=joined&amp;order=ASC&amp;start=30">2</a>
				# Goto page <b>1</b>, <a href="memberlist.php?mode=joined&amp;order=ASC&amp;start=25&amp;sid=654b38de3997bd589ae509830a96e3ef">2</a
				#Goto page <b>1</b>, <a href="memberlist.phtml?mode=joined&amp;order=ASC&amp;start=50&amp;sid=57bebc289a7fb955fabf793233a98ec5">2</a>

				members_per_page = body.scan(/Goto page <b>1<\/b>, <a href="[^"]+start=(\d+)/).flatten.first.to_i
				raise "Cannot find members per page" if members_per_page == 0			
			end

			# phpbb3 / phpbb2
			these_members= body.scan(/<td><span class=[^<]+<\/span><a[^>]+viewprofile[^>]+>([^<]+)<\/a><\/td>|<td class="row[^<]+<span[^<]+<a[^<]+profile[^<]+>([^<]+)<\/|<td class="row[\d]"[^>]+><a href="[^"]*profile[^"]+"[^>]*>([^<]+)/).flatten.compact
			puts "#{url} found " + these_members.size.to_s + " " + these_members[0..2].join(", ") + ", ..."

			break if these_members.empty? # have we got all the members or is this not a memberlist?

			members += these_members		
		end

		members.each_with_index {|m,i| puts [i,m].join(",") unless i > 5}

		fname = URI.parse(forum_url).to_s.split("/")[2..-1].join("_")
		fp=File.open("loot/" + fname,"w")
		fp.puts members
		fp.close
	rescue => err
		puts "Error: " + err
		puts "Continuing.."
		next
	end
end
