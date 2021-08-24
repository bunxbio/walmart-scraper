nokogiri = Nokogiri.HTML(content)

click_captha_code = " 
  await sleep(3000);
  if ( (await page.$('div#js-global-footer-wrapper form#hf-email-signup-form')) == null ) {
    await sleep(5412);
    if ( (await page.$('iframe[style*=\"display: block\"]')) !== null) {
      // do things with its content
      await page.hover('iframe[style*=\"display: block\"]'); await sleep(1428); 
      // click hold and wait loading new page
      await Promise.all([
        page.waitForNavigation({timeout: 30000}),
        page.click('iframe[style*=\"display: block\"]', {delay: 9547}),
      ]);          
    };
  };
"

cookies = page['response_cookie']
products = nokogiri.css('li.Grid-col')

products.each do |product|
	a_element = products.at_css('a.product-title-link')
	url = "https://www.walmart.com#{a_element['href']}"

	if url
		pages << {
			url: url,
			page_type: 'products',
			fetch_type: 'browser',
			force_fetch: true,
			method: "GET",
			headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
			driver: {code: click_captha_code},
			vars: {
				url: url
			}
		}
	end
end


LIMIT_PAGE = 10
current_page = nokogiri.at_css('.paginator-list > li.active > a.active')

if current_page
	current_page = current_page.text.to_i
	if current_page <= limit_page
		next_page = "https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases%3ALast+90+Days&page=#{current_page + 1}"
		if next_page
			pages << {
				url: next_page,
				page_type: 'listings',
				fetch_type: 'browser',
				force_fetch: true,
				method: "GET",
				headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
				driver: {
					code: click_captha_code
				}
			}
		end
	end
end