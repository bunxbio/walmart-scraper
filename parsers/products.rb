nokogiri = Nokogiri.HTML(content)

product = {}


product['title'] = nokogiri.at_css('.prod-ProductTitle').text.strip


product['current_price'] = nokogiri.at_css('#price > div:nth-child(1) > span:nth-child(1) > span:nth-child(1) > span:nth-child(1)').text.strip.gsub('$', '').to_f

original_price = nokogiri.at_css('span.xxs-margin-left:nth-child(1) > span:nth-child(1)')
product['original_price'] = original_price ? original_price.text.strip.split.last.gsub('$', '').to_f : nil

rating = nokogiri.at_css('button.average-rating > span:nth-child(1) > span:nth-child(1)').text.strip.to_f
product['rating'] = rating == 0 ? nil : rating

reviews_count = nokogiri.at_css('.seo-review-count').text.strip.to_i
product['reviews_count'] = reviews_count == 0 ? nil : reviews_count

product['publisher'] = nokogiri.at_css('tr.product-specification-row:nth-child(5) > td:nth-child(2) > div:nth-child(1)').text.strip

product['walmart_number'] = nokogiri.at_css('div.valign-middle:nth-child(5)').text.split('#').last.strip

img_url = nokogiri.at_css('.prod-hero-image-image')['src'].split('?').first
product['img_url'] = "https:#{img_url}"

product['genre'] = nokogiri.at_css('tr.product-specification-row:nth-child(1) > td:nth-child(2) > div:nth-child(1)').text.strip

product['_collection'] = 'products'

outputs << product