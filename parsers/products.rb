nokogiri = Nokogiri.HTML(content)

product = {}


product['title'] = nokogiri.at_css('.prod-ProductTitle').text.strip


product['current_price'] = nokogiri.at_css('#price .hide-content span.visuallyhidden').text.strip.gsub('$', '').to_f

original_price = nokogiri.at_css('.price-old .visuallyhidden')
product['original_price'] = original_price ? original_price.text.strip.split.last.gsub('$', '').to_f : nil

rating_check = nokogiri.at_css('div.arranger span.button-wrapper span')[0]
rating = rating_check ? rating_check.text.strip.to_f : nil
product['rating'] = rating == 0 ? nil : rating

reviews_count_check = nokogiri.at_css('.seo-review-count')
reviews_count = reviews_count_check ? reviews_count_check.text.strip.to_i : nil
product['reviews_count'] = reviews_count == 0 ? nil : reviews_count

product['publisher'] = nokogiri.at_css('div.Grid-col > div.hf-Bot > a.prod-brandName > span').text.strip

product['walmart_number'] = nokogiri.at_css('div.prod-productsecondaryinformation.display-inline-block.prod-SecondaryInfo div.valign-middle.secondary-info-margin-right.copy-mini.display-inline-block.wm-item-number').text.split('#').last.strip

img_url = nokogiri.at_css('.prod-hero-image-image')['src'].split('?').first
product['img_url'] = "https:#{img_url}"

product['categories'] = nokogiri.css('li.breadcrumb a span').collect{|i| i.text.strip}

product['_collection'] = 'products'

outputs << product