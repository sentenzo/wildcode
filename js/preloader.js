// preloader.show() - show awesome preloader
// preloader.hide() - hide awesome preloader

(function () {
    "use strict";
    
    var animationUrl, popupId, outerDivClassName, innerDivClassName;
    
    animationUrl = "/path/to/preloader/animation.gif";
    popupId = "popup1";
    outerDivClassName = "b-popup";
    innerDivClassName = "b-popup-content";
    
    function setAnimationUrl(newUrl) {
        animationUrl = newUrl;
    }
    
    
    if (!this.hasOwnProperty("preloader")) {
        this.preloader = {};
    }
    
    // CSS
    (function () {
        var css = document.createElement("style");
        css.type = "text/css";
        
        css.innerHTML += "." + outerDivClassName + `
{ 
    width: 100%;
    min-height: 100%;
    background-color: rgba(0,0,0,0.5);
    overflow: hidden;
    position: fixed;
    top: 0px;
    z-index: 100;
}
            `;
        css.innerHTML += "." + innerDivClassName + `
{ 
    margin: 200px auto 0px auto;
    width: 128px;
    height: 128px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0px 0px 10px #000;
}
            `;
        
        document.body.appendChild(css);
    }).call(this);
    
    function createPopup() {
        var outerDiv, innerDiv, img;
        
        outerDiv = document.createElement('div');
        outerDiv.id = popupId;
        outerDiv.className = outerDivClassName;
        outerDiv.style.display = "none";
        
        innerDiv = document.createElement('div');
        innerDiv.className = innerDivClassName;
        
        img = document.createElement('img');
        img.src = animationUrl;
        
        innerDiv.appendChild(img);
        outerDiv.appendChild(innerDiv);
        document.body.appendChild(outerDiv);
        
        return outerDiv;
    }
    
    function getPopup() {
        var ret;
        ret = document.getElementById(popupId);
        if (ret) {
            return ret;
        }
        return createPopup();
    }
    
    function showPopup() {
        (getPopup()).style.display = "block";
    }
    function hidePopup() {
        (getPopup()).style.display = "none";
    }
    
    this.preloader.show = showPopup;
    this.preloader.hide = hidePopup;
    
}).call(this);