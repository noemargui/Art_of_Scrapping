require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def array_symbols(page)
	crypto_symbols = []
	page.css('.currency-name-container').each do |symbol|
		crypto_symbols << symbol.text
	end
	return crypto_symbols
end

def array_prices(page)
	crypto_prices = []
	page.css('.price').each do |price|
		crypto_prices << price.text
	end
	return crypto_prices
end

def hashes_transformation(crypto_symbols, crypto_prices)
	array_symbols_prices = crypto_symbols.zip(crypto_prices)
	array_of_hashes = []
 	array_symbols_prices.each {|crypto| array_of_hashes <<  {crypto[0] => crypto[1]}}
 	return array_of_hashes
end

def perform
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	crypto_symbols = array_symbols(page)
	crypto_prices = array_prices(page)
	puts hashes_transformation(crypto_symbols, crypto_prices).inspect
end

perform

=begin

require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"

def crypto_trader
	crypto_symbols = []
	crypto_prices = []
	crypto_hash = Hash.new
	page = Nokogiri::HTML(open(PAGE_URL))
	i = 0

	page.css('.currency-name-container').each do |symbol|
		crypto_symbols << symbol.text
	end

	page.css('.price').each do |price|
		crypto_prices << price.text
	end

	size = crypto_symbols.length

	while i < size do
		crypto_hash[crypto_symbols[i]] = crypto_prices[i]
		i += 1
	end
	puts crypto_hash
end

crypto_trader

=end