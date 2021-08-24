click_captha_code = " 
  await sleep(3000);
  if ( (await page.$('div#js-global-footer-wrapper form#hf-email-signup-form')) == null){
    await sleep(5412);
    if ( (await page.$('iframe[style*=\"display: block\"]')) !== null) {
      // do things with its content
      await page.hover('iframe[style*=\"display: block\"]'); await sleep(1428); 
      // click hold and wait loading new page
      await Promise.all([
        page.waitForNavigation(),
        page.click('iframe[style*=\"display: block\"]', {delay: 9547}),
      ]);
    };
  };
  await page.setPageLimitLoadingTime(3000);
"


pages << {
  url: 'https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases:Last+90+Days',
  page_type: "listings",
  fetch_type: 'browser',
  force_fetch: true,
  method: "GET",
  headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
  driver: {
    code: click_captha_code
  }
}