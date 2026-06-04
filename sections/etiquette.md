[<<< Previous](concept.md) | [Next >>>](SWAPI.md)

# API Etiquette

APIs are powerful and helpful tools. It is important to follow some general principals when using them to avoid potential problems with the API provider and possibly your own colleagues.

+ **Look for API terms of service.** Most websites which offer public API access will provide some kind of statement about acceptable usage, and possibly even documentation on how to use it. Some may stipulate particular usage requirements or forbid it altogether. Others may provide keys for private access that require you to go through a request procedure. Some websites may make no statement one way or another on what is allowable. Whatever the case, you want to make certain that API usage is not explicitly forbidden. It is important to respect these terms, and to be a good Internet citizen.
+ **Follow copyright and fair use principles.** The information you gather and the uses to which you can put it may be governed by law, even if the website grants you permission to harvest data with an API. In general, facts are not copyrightable and are fair game, but intellectual property such as stories or images may be protected, and you will need to conduct a fair use analysis for what's allowable in your scholarship. (Pro tip: librarians are happy to consult on these kinds of questions!)
+ **Take time to construct careful API requests that take only the data you need.** It may be tempting to construct broad queries that take in lots and lots of data, "just in case." However, API requests do exert a computing cost on the hosting server, and large requests, especially repeated large requests, can tax the system. Moreover, some private API services calculate the data you use and may shut you off if you collect too much. For example, academic libraries frequently purchase API access for their patrons (ask your own librarian!), and request "overages" can end up racking up large over-usage bills for the library.
+ **Avoid making multiple requests in a short period of time.** If you need extensive amounts of data, or if you need to making many different requests, space them out over time. As just noted, API requests exert computing costs, and if hosting services see a lot of traffic, they may introduce some kind of rate limiting or even shutoff IP-address ranges, meaning that not only could you be shut out personally, but anyone else on your college campus may be denied as well.

# Example of Acceptable Usage Statement 

What does a usage statement look like? The Art Institute of Chicago offers [a pretty convenient set of guidelines for their API here](https://api.artic.edu/docs/#scraping-data): 

> Generally, we ask that you avoid extensive scraping of our API. The API is meant for direct integration into websites and applications. The data dumps are meant for backups and analysis. Scraping our API puts undue stress on our systems. Instead of scraping, please download the data dumps and filter them locally to obtain the data you need.

> That said, we don't mind small-scale scraping of our API. It can be convenient to use our search endpoint to filter records and retrieve only the fields you need. You can even use the aggregation functionality of our search endpoints to run some simple analyses. Just remember that you cannot paginate beyond 10,000 results in our search endpoints (see Pagination).

> If you do decide to scrape our resources, please throttle your requests to no more than one per second and avoid running multiple scrapers in parallel.

Having covered the etiquette of API usage, let's get started by looking at how API requests can be made in your browser, using a resource called the Star Wars API.

[<<< Previous](concept.md) | [Next >>>](browser.md)
