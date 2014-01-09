require 'anemone'
require 'open-uri'
require 'nokogiri'

p = 0
File.open("urls.csv", 'a') { |file| file.puts "serial, year, department, image, page"	}
Anemone.crawl("http://www.artic.edu") do |anemone|
	anemone.skip_links_like /\.pdf/
	anemone.skip_links_like /\.jpg/
	anemone.on_pages_like(/\/collections\/artwork/) do |page|
  		if /search\_no/.match(page.url.to_s)
			p += 1
      		doc = Nokogiri::HTML(open(page.url))
      		puts p.to_s + ", " + doc.xpath('//div/p')[1].to_s.match(/[0-2]?[0-9][0-9][0-9]/).to_s + ", " + doc.xpath("//p[@id='dept-gallery']/a")[0].to_s.match(/department\/[0-9][0-9]?/).to_s.match(/[0-9][0-9]?/).to_s + ", " + URI.extract(doc.css('a.enlargement-link')[0].to_s)[0].to_s + ", " + page.url.to_s
			File.open("urls.csv", 'a') { |file| file.puts p.to_s + ", " + doc.xpath('//div/p')[1].to_s.match(/[0-2]?[0-9][0-9][0-9]/).to_s + ", " + doc.xpath("//p[@id='dept-gallery']/a")[0].to_s.match(/department\/[0-9][0-9]?/).to_s.match(/[0-9][0-9]?/).to_s + ", " + URI.extract(doc.css('a.enlargement-link')[0].to_s)[0].to_s + ", " + page.url.to_s	}
      	end
   	end
end