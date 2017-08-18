// ==UserScript==
// @name         svtplay download
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.svtplay.se/video/*
// @grant        none
// ==/UserScript==

function my_jQueryFunction(a) {
    console.log(a + "jQuery loaded with version:" + window.jQuery.fn.jquery);
    console.log("There are " + $('a').length + " links on this page.");
    var href = window.location.href;
    var title = document.title;
    console.log(href + ' - ' + title);
    if ($("#dddd").length <= 0) {
        $('html').append(`
         <div id="dddd" style="background-color:#00e;position:fixed;top:100px;right:0;z-index:20;padding:5px;">
        </div>`);
    }
    $('#dddd').append(`
    <button title="Download using svtdownload (Docker)" 
        onclick="window.location.href='http://localhost:8066/action?url=` + href+ `'" style="margin:2px;">
        <img src='https://www.svtplay.se/favicon.ico' />
        svtplay download
    </button>  
    <br>`);
}

(function() {
    'use strict';
    if (window.jQuery) {
        my_jQueryFunction('Already loaded ');
    } else {
        console.log("No jQuery");
        var head = document.getElementsByTagName("head")[0];
        var script = document.createElement("script");
        script.src = "//ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js";
        script.onload = function() {
            my_jQueryFunction('SmartExtraInfo - loaded ');
        };
        head.appendChild(script);
    }
})();

