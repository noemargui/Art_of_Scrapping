require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_names
	townhall_names = []
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	page.xpath("//p/a").each do |name|
		townhall_names << name.text
	end
	return townhall_names
end

def get_townhall_urls
	townhall_url = []
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	page.xpath("//p/a/@href").each do |hall|
		townhall_url << "http://annuaire-des-mairies.com" + hall.to_str[1..-1]
	end
	return townhall_url
end

def get_townhall_email(townhall_url)
 townhall_email = []
 townhall_url.each do |url_town|
   page = Nokogiri::HTML(open(url_town))
   page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each do |email|
     townhall_email << email.text
   end
 end
 return townhall_email
end

def hashes_transformation(townhall_names, townhall_email)
	array_names_emails = townhall_names.zip(townhall_email)
	array_of_hashes = []
 	array_names_emails.each {|town| array_of_hashes <<  {town[0] => town[1]}}
 	return array_of_hashes
end

def perform
	townhall_names = get_townhall_names
	townhall_url = get_townhall_urls
	townhall_email = get_townhall_email(townhall_url)
	puts hashes_transformation(townhall_names, townhall_email).inspect
end

perform


=begin

def perform
	townhall_url = get_townhall_urls
	townhall_email = get_townhall_email(townhall_url)
end

perform

def get_townhall_email(townhall_url)
	townhall_email = []
	page = Nokogiri::HTML(open("#{townhall_url}"))
	page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each do |email|
		townhall_email << email.txt
	end
	return townhall_email
end

def get_townhall_email
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/ableiges.html"))
	page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each do |email|
		puts email.text
	end
end

=end