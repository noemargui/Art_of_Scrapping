require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_representative_first_names
	representative_first_names = []
	page = Nokogiri::XML(open("https://www.nosdeputes.fr/deputes/enmandat/xml"))
	page.xpath("//deputes/depute/prenom").each do |first_name|
		representative_first_names << first_name.text
	end
	return representative_first_names
end

def get_representative_last_names
	representative_last_names = []
	page = Nokogiri::XML(open("https://www.nosdeputes.fr/deputes/enmandat/xml"))
	page.xpath("//deputes/depute/nom_de_famille").each do |last_name|
		representative_last_names << last_name.text
	end
	return representative_last_names
end

def get_representative_emails
	representative_emails = []
	page = Nokogiri::XML(open("https://www.nosdeputes.fr/deputes/enmandat/xml"))
	page.xpath("//deputes/depute/emails/email[1]").each do |email|
		representative_emails << email.text
	end
	return representative_emails
end

def hashes_transformation(representative_first_names, representative_last_names, representative_emails)
	array_names_email = representative_first_names.zip(representative_last_names, representative_emails)
	hash_representative = []
	array_names_email.each {|representative| hash_representative << {"Prénom" => representative[0], "Nom de famille" => representative[1], "email" => representative[2]}} 
 return hash_representative
end

def perform
	representative_first_names = get_representative_first_names
	representative_last_names = get_representative_last_names
	representative_emails = get_representative_emails
	puts hashes_transformation(representative_first_names, representative_last_names, representative_emails).inspect
end

perform