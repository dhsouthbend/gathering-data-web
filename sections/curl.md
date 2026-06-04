[<<< Previous](browsing-art.md)

# Using APIs from the Command Line

Using APIs from your browser is convenient for quick browsing, but APIs can be accessed by other methods that make it easier to download and work with data on your computer. A tool built for this purpose called `curl` (short for "Client URL") is built into all modern desktop operating systems. 

`curl` is built into the command line, or the text-based interface, of your operating system. In Windows, this is called **Command Prompt**, and you can open it by clicking the Windows button and starting to type `command`.

 In macOS, you open your Spotlight search and type in `terminal`. Similarly, in Linux you open your search bar and type in `terminal`.

> [!CAUTION]
> Windows contains another command line called Powershell, which shares some syntax with Command Prompt **but not all**. Notable `curl` works differently! If you use Powershell, you will need to enter `curl.exe` instead of just `curl` to avoid an error.

Your computer's command line usually opens to your user folder. You can see all the files and folders in your current location with a simple command. On Mac and Linux, the `ls` command will show you everything in this current folder, and on Windows, `dir` will do the same. You simply enter `ls` or `dir` and press enter. 

It is a good idea to "move" into folder where you can experiment, such as `Downloads` or  `Desktop`.In order to move locations, type `cd folder-name` where `folder-name` is the folder you want to be in. For example, we might enter `cd Downloads` then press enter to move into Downloads. 

From here, we can start playing with data! 

## Dictionary Download

The syntax for `curl` is `curl [options] [url]`, where `[options]` stands in for any optional flags that modify how `curl` behaves, and `[url]` is, in our case, the address for our API request. We will look at one of the optional flags in a moment, but first let's make a very basic API call to the Dictionary API by copying and pasting the below code into the command line:  

`curl https://api.dictionaryapi.dev/api/v2/entries/en/serendipity`

Once the command runs, we have made a successful API call using `curl`, and our output is JSON data defining the word *serendipity*. This is great, but in most cases we don't just want to see the results of an API request; we want to save those results to work with later. 

### The *-o* flag

In order to save our API response, we will add the optional flag *-o* to our command and specify the file name where we want it to be saved. Our syntax is now `curl -o [filename] [url]`. Remember that we should have moved to a good folder in which to experiment earlier (e.g., `Downloads` or `Desktop`). Unless we specify otherwise, any files we save in the command line using `curl -o` will be saved to that same folder. Try this:  

`curl -o serendipity.json https://api.dictionaryapi.dev/api/v2/entries/en/serendipity`  

## Image Download

Let's say we wanted to download an image of a cat to our computer, and we want to make sure it's an image in the public domain so we can use it for whatever purpose. Remember what we might do?

First, we need to get construct an appropriate query. We can try:
> https://api.artic.edu/api/v1/artworks/search?q=cats&query[term][is_public_domain]=true&limit=3

So we do a search for the term "cats", restrict the query to items in the public domain, and limit our results list to 3 since we don't need a lot of options.

![Results list](../images/cat-cushion-search.png)

Let's go with this result from earlier in the lesson, "Winter: Cat on a Cushion." Remember how to get more information about it? Look for the `api_link` value and plug that URL into the browser: [https://api.artic.edu/api/v1/artworks/51719](https://api.artic.edu/api/v1/artworks/51719).

Here, we get a lot more data as expected -- in fact, we're maybe overwhelmed by it. Where do we find the image? A `ctrl+f` search for "image" yields an `image_id` field:

![image_id field in the record](../images/cat-image-id.png)

What do we do with the `image_id`? The [Art Institute's image API documentation](https://api.artic.edu/docs/#images) includes good instructions, including this basic template for most use cases:

> `https://www.artic.edu/iiif/2/{identifier}/full/843,/0/default.jpg`

We now have the pieces we need to retrieve the image. Just replace the `{identifier}` in the template URL with the our `image_id` value. [Try it in your browser](https://www.artic.edu/iiif/2/e8e67721-bbb1-d007-82bd-c430ea73db70/full/843,/0/default.jpg). 

The last step is to use `curl` to download the image. Go back to your command line and enter the following command:

> `curl -o image.jpg https://www.artic.edu/iiif/2/e8e67721-bbb1-d007-82bd-c430ea73db70/full/843,/0/default.jpg`

Remember, the `-o` flag specifies that `curl` should "output" to a file, which we have chosen to name `image.jpg`. Next, we simply supply the API request for the image. You should now see an `image.jpg` file in your folder.

[<<< Previous](browsing-art.md)  
[<<< Return to Introduction](../README.md)
