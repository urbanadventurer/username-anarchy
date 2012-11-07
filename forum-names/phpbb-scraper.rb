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

File.read("./find-forums/phpbb-forums5.txt").each do |forum_url|

	forum_url.strip!
	puts forum_url
	puts "*" * 80
	members=[]
	members_per_page=25 # default

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
		end
		body= res.body

		# phpbb3 / phpbb2
		these_members= body.scan(/<td><span class=[^<]+<\/span><a[^>]+viewprofile[^>]+>([^<]+)<\/a><\/td>|<td class="row[^<]+<span[^<]+<a[^<]+viewprofile[^<]+>([^<]+)<\//).flatten.compact

		puts "#{url} found " + these_members.size.to_s + " " + these_members[0..2].join(", ") + ", ..."

		members_per_page = these_members.size if these_members.size !=25

		break if these_members.empty? # have we got all the members or is this not a memberlist?
		members += these_members
	end

	members.each_with_index {|m,i| puts [i,m].join(",") }

	fname = URI.parse(forum_url).to_s.split("/")[2..-1].join("_")
	fp=File.open("loot/" + fname,"w")
	fp.puts members
	fp.close

end
