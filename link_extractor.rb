# All the gems you need for this crawler

require 'rubygems'
require 'open-uri'
require 'nokogiri'


# Global value for links
$links = Array.new

# Creates a new Data_mine class
class Data_crawl
  def initialize
  end

def link_extractor

	
	# Allows input for this method.
	# Should come in the form of a client GET reques
	puts "Enter the audio artist on Newgrounds that you want to search"
	STDOUT.flush
	artist = gets.chomp

	url_string = "http://"
	url_string << artist
	url_string << ".newgrounds.com/audio/"

	# Nokogiri gem opens up the proper (audio) artist pag
	artist_page = Nokogiri::HTML(open(url_string))
	
	# Find all the links from the artist page
	# and add them to the $Links collection
	#
	# **NOTE!**
	#
	# The approach thus far only gets the links
	# of the most popular songs from each year
	j = 0
	artist_page.css('a').each do |p|

		song = p.first
		song = song.to_s
		if(song.include?("newgrounds.com/audio/listen"))	
			
			# puts song - shows original format
			# Split into two arrays, we want the 2nd
			splitter = song.split(" ")
			reformat = splitter[1]

			# Remove the ] bracket and the new line character
			final = reformat[0..-2]

			# Add it to the collection
			$links[j] = final

			# Output is for display purposes only
			puts final
			j += 1
			end

		end
	end


# ends the class
end

this = Data_crawl.new


this.link_extractor



# Goal = have links in a collection so we can
# loop through calling audio_page_search(links[i])

#num_links = $links.length
#while(num_links >= 0)
#	new_url = $links.at(num_links - 1)
#	new_url = new_url.to_s
#	puts new_url
#	num_links -= 1
#
#end


