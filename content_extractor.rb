# All the gems you need for this crawler
require 'rubygems'
require 'open-uri'
require 'nokogiri'


# Global value for views and downloads
$views = Array.new
$downloads = Array.new

# Creates a new Data_crawler class
class Data_crawler
  def initialize
  end


# Finds pertinent information about a song  
def audio_page_search(url)

	# This collection holds all of the things we find
	extraction = Array.new

	# Opens the specified url
	song_page = Nokogiri::HTML(open(url))
	i = 0

	#Use the CSS selector to get some of the info
	song_page.css('p.last > strong').each do |f|
		extraction[i] = f.text
		i += 1
	end
	
	# For this particular page, the extraction we want
	# is the 2nd listing, so add it to the views array
	
	# We have to remove the , for it to add up
	extraction[1] = extraction[1].gsub(/[,]/, '')
	$views.push(extraction[1])
	
	# Downloads is the 3rd listing
	extraction[2] = extraction[2].gsub(/[,]/, '')
	$downloads.push(extraction[2])	
end

# ends the class
end

this = Data_crawler.new

# Demo

this.audio_page_search("http://www.newgrounds.com/audio/listen/398310")
this.audio_page_search("http://www.newgrounds.com/audio/listen/312316")
this.audio_page_search("http://www.newgrounds.com/audio/listen/284703")
this.audio_page_search("http://www.newgrounds.com/audio/listen/126162")

# Code for tallying up all of the downloads and views
# from each page that was accessed by the
# audio_page_search method.
len = $views.length
total_views = 0
total_dls = 0
while(len >= 0)
		
		# Converts the views and downloads to an int
		# and tallys them up for final output
		total_views += $views.at(len - 1).to_i(10)
		total_dls += $downloads.at(len - 1).to_i(10)
		len -= 1
	end


# Final output messages
print "Total views: " 
print total_views
print "\n"
print "Total downloads: "
print total_dls
