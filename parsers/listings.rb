nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('li.Grid-col')
cookies = page['response_cookie']

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

products.each do |i|
    link_node = i.at_css('.product-title-link')
    url = link_node['href'] ? "https://www.walmart.com#{link_node['href']}" : nil

    if url =~ /\Ahttps?:\/\//i
        pages << {
          url: url,
          page_type: "products",
          fetch_type: "browser",
          method: "GET",
          force_fetch: true,
          headers: { 
          "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
          driver: {
            code: click_captha_code
          }
        }
    end
end


LIMIT_PAGE = 10
current_page = nokogiri.at_css('.paginator-list > li.active > a.active').text

if current_page
  current_page = current_page.to_i
  if current_page <= LIMIT_PAGE
    next_page = current_page ? "https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases:Last+90+Days&page=#{current_page + 1}" : nil
    if next_page =~ /\Ahttps?:\/\//i
      pages << {
        url: next_page,
        page_type: "listings",
        fetch_type: "browser",
        method: "GET",
        force_fetch: true,
        headers: {
          "User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
        },
        driver: {
          code: click_captha_code
        }
      }
    end
  end
end