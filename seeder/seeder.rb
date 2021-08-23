pages << {
  url: 'https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases:Last+90+Days',
  page_type: "listings",
  fetch_type: 'browser',
  force_fetch: true,
  method: "GET",
  headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
  driver: {
    code: "await page.click('#GZxTNIAhngUAZwF', {delay: 5000}); await sleep(1000);"
  }
}