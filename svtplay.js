// ==UserScript==
// @name         svtplay download
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.svtplay.se/video/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    var href = window.location.href;
    var title = document.title;
    console.log(href + ' - ' + title);
    document.body.innerHTML += `
<div id="dddd" style="background-color:#00e;position:fixed;top:100px;right:0;z-index:20;padding:5px;">
    <button title="Download using svtdownload (Docker)"
        onclick="window.open('http://localhost:8066/action?url=` + href + `','` + title + `')" style="margin:2px;">
        <img src='https://www.svtplay.se/favicon.ico' />
        svtplay download
    </button><br>
</div>
`;
})();
