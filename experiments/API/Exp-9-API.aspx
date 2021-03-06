﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Exp-9-API.aspx.cs" Inherits="experiments_API_Exp_9_API" %>

<%@ Import Namespace="edu.neu.ccis.rasala" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Experiment 9: Instagram API</title>
    <script src="jquery-1.11.1.min.js"></script>
    <script>
        var limit = 4;
        var setSize = "medium";
        var key = "<%= KeyTools.GetKey(this,"instagram") %>"
        var instagram = function () {
            return {
                init: function () {
                    instagram.loadImages();
                },
                loadImages: function () {
                    var getImagesURL = "https://api.instagram.com/v1/tags/" + "books" + "/media/recent?client_id=" + key;
                    $.ajax({
                        type: "GET",
                        dataType: "jsonp",
                        cache: false,
                        url: getImagesURL,
                        success: function (data) {
                            for (var i = 0; i < limit ; i += 1) {
                                if (setSize == "small") {
                                    var size = data.data[i].images.thumbnail.url;
                                } else if (setSize == "medium") {
                                    var size = data.data[i].images.low_resolution.url;
                                } else {
                                    var size = data.data[i].images.standard_resolution.url;
                                }
                                $(".instagram").append("<div  class='grid" + i + "'><a target='_blank' href='" + data.data[i].link + "'><img src='" + size + "' alt='" + data.data[i].caption.text + "'/><span>" + data.data[i].user.username + "</span></a></div>");
                            }
                        }
                    });
                }
            }
        }();

        $(document).ready(function () {
            instagram.init();

            $("#refresh").on("click", function () {
                $(".instagram").empty();
                instagram.init();
            });
        });
    </script>
    <link rel="stylesheet" href="InstagramAPIstyles.css" />
</head>
<body>
    <div class="d_heading">
        <h1>Experiment 9: Retrieving Data from a Public API</h1>
        <h2>Experiment Demo</h2>
        <h4><i>Below are some of the images retrieved from Instagram API</i></h4>
        <h4><i>Click refresh to retrieve a new set of images.</i></h4>
        <b>Disclaimer: I have written the Javascript in this aspx to get access to the Key utility provided by Prof.Rasala. In my project, I have written all Javascripts in seperate files as per standard coding practices.</b>
    </div>
    <div class="instagram">
    </div>
    <div style="text-align: center">
        <button id="refresh">Refresh</button>
    </div>
    <div class="d_doco">
        <h2><i>Documentation:</i></h2>
        <p><b>Purpose of the Experiment:</b>To learn to extract data from a public API by making ajax calls to it.</p>
        <p><b>What does this experiment do?</b> This Experiment connect to the Instagram API and fetches the 4 most recent images tagged under 'books'. This is achieved by issuing an ajax call to the website.</p>
        <p><b>Steps:</b></p>
        <p>
            1. To use Instagram API , we need to register our application with the API and retrieve a client Id. We cannot access all the features of Instagram with a client id as some of the features like posting a picture, will need a authentication. For our purposes , a client id would do, as we are just attempting to extract images from Instagram by placing some Ajax calls .
         Here is the Query that we are using in this experiment to fetch images from the Instagram API. The explanation of each portion of the query is given below.
        </p>
        <pre style="color: darkblue;">

URL: "https://api.instagram.com/v1/tags/" + "books" + "/media/recent?client_id="[Enter your Client Id Here]";

Lets examine the query in parts.

"https://api.instagram.com/v1/tags" - is the API provided by Instagram

"books" is the tagname that we pass to Instagram API to select and retrieve books that fall under the tab 'books'

"/media/recent?" - This specifies the path in the Instgram site from which the images have to be retrieved. (i.e) In the Instagram site , under the section 'media' and category 'recent', select the 4 most recent images that matach the tag 'books'.

"client id" - Enter the client id that was assigned to you when you registered for access to the Instagram API.
        </pre>
        <p>2. Next, we form the ajax call using Jquery. Below are the  attributes that we pass in the ajax call.</p>
        <p>Inline Comments have been written along with the code to explain the flow of the code.</p>
        <pre style="color: darkblue">
$.ajax({                                  //Start ajax call 
type: "GET",                              //Type of HTTPRequest
dataType: "jsonp",                        //Datatype with which my ajax call will request the API and return the results.
cache: false, 
url: getImagesURL,                        //The URL that we discussed under point 1 comes here.
success: function (data) {  //On successful reception of data, 
for (var i = 0; i < limit ; i += 1) {     // Loop through the results and load the images based on their size.
if (setSize == "small") {
var size = data.data[i].images.thumbnail.url;
} else if (setSize == "medium") {
var size = data.data[i].images.low_resolution.url;
} else {
var size = data.data[i].images.standard_resolution.url;
}
}
}
});

            //Adding the retrieved images to the div element .

$(".instagram").append("< div class='grid" + i + >"'< a target='_blank' href='" + data.data[i].link + "'> img src='" + size + "' alt='" + data.data[i].caption.text + "' />< span>" + data.data[i].user.username + "< /span>< /a>< /div>");
}
}
}();

        </pre>
    </div>
    <hr />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/API/Exp-9-API.aspx" target="_blank">Link to aspx file</a>
    <br />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/API/InstagramAPIstyles.css" target="_blank">Link to css file</a>
    <br />
    <a href="http://net4.ccs.neu.edu/home/arulselv/fileview/Default.aspx?~/experiments/API/exp9_instagram.js" target="_blank">Link to js file</a>
    <hr />
    <div class="d_ref">
        <br />
        <h2>References</h2>
        <a href="http://instagram.com/developer/api-console/" target="_blank">1. Instgram API developer documentation</a><br />
        <a href="https://help.instagram.com/554924547867832/" target="_blank">2.Instagram Help Center</a><br />
        <a href="http://stackoverflow.com/questions/12478772/how-do-i-use-instagrams-api-to-display-a-gallery-of-my-own-photos" target="_blank">3. Stackoverflow</a><br />
        <a href="http://codepen.io/" target="_blank">4.Codepen.io</a><br />
        <a href="http://w3schools.com" target="_blank">5.w3schools.com</a>
    </div>
</body>
</html>

