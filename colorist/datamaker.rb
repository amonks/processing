require 'open-uri'


colors = Hash.new



puts colors


def setup
	size 200,200
	colormode HSB, 16
	File.open("paintings.csv").each do |row|
	  colors[row.split(",")[0]] = row.split(",")[2]

	end 
end

def draw
	text "Hello World", 10,105
end