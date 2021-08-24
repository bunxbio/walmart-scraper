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

products.each do |item|

    link_node = item.at_css('.product-title-link')
    url = link_node['href'] ? "https://www.walmart.com#{link_node['href']}" : nil

    if url =~ /\Ahttps?:\/\//i
        pages << {
          page_type: "products",
          method: "GET",
          headers: { 
          "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
          url: url,
          fetch_type: "browser",
          driver: {
            code: click_captha_code},
          force_fetch: true
        }
    end
end