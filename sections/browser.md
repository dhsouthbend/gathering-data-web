[<<< Previous](etiquette.md) | [Next >>>](browsing-art.md)

# API Requests in Browser

At its core, whenever we make any request to an API, we are performing a Hypertext Transfer Protocol (HTTP) request method: making a call to a web address and asking it permission to do something, like **POST** new information to the location or **DELETE** an item stored there. Most frequently, we are wanting to (and only have permission to!) **GET** information from the location. In our earlier example of the art museum API, when you make an API request to "Please give me the artist name, date of creation, genre, filename, and download link for all paintings made in France between 1860 and 1890," you are making a GET request.  


Perhaps the simplest way to make a request to a public API is to use your web browser. This requires you to correctly construct a web address that corresponds to what you want to receive from the API. Typically, you will figure out how to construct this address by looking into the API's documentation. If the data returned by the API after a successful request is metadata (for example, that information about the 19th century paintings), it may show up in your browser as XML or JSON, both formats for storing structured data. Before we look at an API in-browser, let's use a test environment to get a sense of what JSON looks like.  

## The Star Wars API

The Star Wars API, or [SWAPI](https://swapi.dev/about), is "the world's first quantified and programmatically-formatted set of Star Wars data." It provides several endpoints, or points of entry, to access data about the Star Wars movies, including People, Films, Species, Starships, Vehicles and Planets—and that data is provided in JSON format. 

Here are several of the SWAPI endpoints:  
+ **Species**: [https://swapi.dev/api/species/](https://swapi.dev/api/species/)
+ **People**: [https://swapi.dev/api/people/](https://swapi.dev/api/people/)
+ **Planets**: [https://swapi.dev/api/planets/](https://swapi.dev/api/planets/)

When we head to one of these endpoints in our browser, either by clicking the hyperlink above or by copying and pasting the address into the browser's search bar, we make a GET request to the API, and the webpage shows the results in JSON.

## JSON

JSON, or JavaScript Object Notation, is "a lightweight format for storing and transporting data," as defined by [W3Schools](https://www.w3schools.com/whatis/whatis_json.asp). In JSON, data for a given object (for example, an author) is contained within curly brackets (`{}`) and is provided in key:value pairs. A single object might have any number of key:value pairs associated with or describing it. A given key (`booksWritten`) might have multiple values, which will be provided in an **array**, or a list of values, encased in square brackets (`[]`). A list of multiple objects is also presented as an array:

    {
        "authors": [
             {
                "name": "J.R.R. Tolkien",
                "booksWritten": [
                    "The Hobbit: or There and Back Again",
                    "The Fellowship of the Ring: being the first part of The Lord of the Rings",
                    "The Two Towers: being the second part of The Lord of the Rings",
                    "The Return of the King: being the third part of The Lord of the Rings"
                    ],
                "dateBirth": "1892-01-03"
            },
            {
                "name": "C.S. Lewis",
                "booksWritten": [
                    "The Lion, the Witch and the Wardrobe",
                    "Prince Caspian",
                    "The Voyage of the Dawn Treader",
                    "The Silver Chair",
                    "The Horse and His Boy",
                    "The Magician's Nephew",
                    "The Last Battle"
                    ],
                "dateBirth": "1898-11-22"
            }
        ]
    }

## Dictionary API

Now that we know how JSON works, let's make another API call in-browser. We'll use [Dictionary API](https://dictionaryapi.dev/), a free API that pulls from Wikimedia and Wiktionary to provide dictionary and pronunciation information. To make a GET request, we need to structure a URL following this template: `https://api.dictionaryapi.dev/api/v2/entries/en/<word>`. Feel free to try it yourself by copying and pasting that address and replacing `<word>` with whatever word you would like to look up. When your result loads, click on the `Pretty-print` box to format the JSON for better readability.

>**EXAMPLE REQUEST**: [haberdashery](https://api.dictionaryapi.dev/api/v2/entries/en/haberdashery)

Next, let's look at using browser API calls to analyze art.

[<<< Previous](etiquette.md) | [Next >>>](browsing-art.md)
