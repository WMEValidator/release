var bootstrap = document.createElement('script');
bootstrap.async = true;
bootstrap.src = chrome.extension.getURL("WME_Validator.user.js");
document.head.appendChild(bootstrap);
