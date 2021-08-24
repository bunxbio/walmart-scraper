nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('li.Grid-col')

products.each do |product|
	a_element = products.at_css('a.product-title-link')
	if a_element
		url = "https://www.walmart.com#{a_element['href']}"

		pages << {
			url: url,
			page_type: 'products',
			vars: {
				url: url
			}
		}
	end
end


limit_page = 11
current_page = nokogiri.at_css('.paginator-list > li.active > a.active')

=begin
if current_page
	current_page = current_page.text.to_i
end

if current_page && (current_page < limit_page)
	next_page = "https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases%3ALast+90+Days&page=#{current_page + 1}"
	if next_page
		pages << {
			url: next_page,
			page_type: 'listings',
			fetch_type: 'browser',
			force_fetch: true,
			method: 'GET'
		}
	end
end
=end