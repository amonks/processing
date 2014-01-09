require 'anemone'
require 'open-uri'
require 'nokogiri'

log = File.open("urls.csv", 'a') 
log.puts "year, department, image, page"

for i in 0..99999 do
	doc = Nokogiri::HTML(open("http://www.artic.edu/aic/collections/artwork/" + i.to_s))
	if doc.to_s.length > 31000
    	facts = doc.to_s.length.to_s + ", " + doc.xpath('//div/p')[1].to_s.match(/[0-2]?[0-9][0-9][0-9]/).to_s + ", " + doc.xpath("//p[@id='dept-gallery']/a")[0].to_s.match(/department\/[0-9][0-9]?/).to_s.match(/[0-9][0-9]?/).to_s + ", " + URI.extract(doc.css('a.enlargement-link')[0].to_s)[0].to_s + ", " + i.to_s
    	puts facts
 		log.puts facts
 	end
end