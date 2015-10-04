!function(){function e(e,t,n,o){var i=chrome.notifications.create(e+h++,{type:"basic",title:t,iconUrl:n,message:o},function(e){var t=setTimeout(function(){chrome.notifications.clear(e,function(t){t&&delete m[e]})},u);m[e]=t});null!=i&&i.show()}function t(){var e=Object.keys(m);e.forEach(function(e){chrome.notifications.clear(e,function(){}),clearTimeout(m[e]),delete m[e]})}function n(){f(!1),f(),chrome.proxy.settings.set({value:v,scope:"regular"},function(){})}function o(){f(!1),chrome.proxy.settings.set({value:{mode:"system"},scope:"regular"},function(){})}function i(){var e="https://www.veilduck.com/status.html";chrome.tabs.create({url:e,active:!0})}function c(){chrome.storage.sync.get("end-at",function(t){var n=t["end-at"];if(n){var o=new Date(n)-new Date;if(0>=o)e(g,"Session is expired.","assets/icons/icon_will_off.png","Click here to go to get a new ticket.");else{var i=o-O;1e3>i?i=1e3:i>k&&(i=k),void 0!==p&&clearTimeout(p),p=setTimeout(function(){e(g,"Session will be expired soon.","assets/icons/icon_will_off.png","Click here to go to get a new ticket."),E.toWillOff()},i)}}})}function r(){void 0!==p&&(clearTimeout(p),p=void 0)}function s(){chrome.storage.sync.get("end-at",function(t){var n=t["end-at"];if(n){var o=new Date(n)-new Date;0>=o&&(o=1),void 0!==_&&clearTimeout(_),_=setTimeout(function(){e(g,"Session is expired.","assets/icons/icon_will_off.png","Click here to go to get a new ticket."),E.toOff()},o)}})}function a(){void 0!==_&&(clearTimeout(_),_=void 0)}function l(e){chrome.browserAction.setIcon({path:"assets/icons/"+e})}function f(e){function t(e){if(console.log("PROXY: onAuthRequired"),e.isProxy===!0){if(e.challenger.host.indexOf("veilduck.com")<0)return;return E.state==y?(console.log("PROXY: Veilduck is off. Cancel auth-required-request."),{cancel:!0}):(console.log("PROXY : "+JSON.stringify(e)),"string"!=typeof w||void 0!==n[e.requestId]?(E.toOff(),n={},console.log("PROXY: authentication may failed. ",w),i(),{cancel:!0}):(n[e.requestId]=parseFloat(e.timeStamp),{authCredentials:{username:w,password:w}}))}}e===!1?chrome.webRequest.onAuthRequired.removeListener(t,{urls:["<all_urls>"]},["blocking"]):chrome.webRequest.onAuthRequired.addListener(t,{urls:["<all_urls>"]},["blocking"]);var n={}}var u=5e3,d="proxy_noti_",g="expire_noti_",h=1,m={},v={mode:"pac_script",pacScript:{data:'function FindProxyForURL(url, host){\n  if (isPlainHostName(host) ||\n      shExpMatch(host, "*.local") ||\n      isInNet(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||\n      isInNet(dnsResolve(host), "172.16.0.0",  "255.240.0.0") ||\n      isInNet(dnsResolve(host), "192.168.0.0",  "255.255.0.0") ||\n      isInNet(dnsResolve(host), "127.0.0.0", "255.255.255.0"))\n      return "DIRECT";\n  var direct = [\n    "veilduck.com", "lvh.me", "localtest.me", "vcap.me", "127.0.0.1.xip.io"\n  ];\n  for(var i=0; i < direct.length; i++)\n    if(dnsDomainIs(host, direct[i]))\n      return "DIRECT";\n  if (shExpMatch(url, "https:*")) return "DIRECT";  return "HTTPS proxy.veilduck.com:44300";\n}'}},p=void 0,_=void 0,O=3e4,k=2147483647;chrome.notifications.onClicked.addListener(function(e){null!=e.match("^"+g)&&i()});var w=void 0;chrome.storage.sync.get("ticketid",function(e){w=e.ticketid});var y=0,R=2,x=4,I={state:y,icon_filename:"icon_off.png",get:function(){return o(),l(this.icon_filename),this},toOff:function(){console.log("already off")},toOn:function(){E=T.get()},toWillOff:function(){console.log("OFF -> WILL_OFF: invalid transition")}},T={state:R,icon_filename:"icon_free.png",get:function(){return n(),c(),l(this.icon_filename),this},toOff:function(){r(),E=I.get()},toOn:function(){n(),c()},toWillOff:function(){r(),E=C.get()}},C={state:x,icon_filename:"icon_free.png",get:function(){return r(),s(),l(this.icon_filename),this},toOff:function(){a(),E=I.get()},toOn:function(){a(),E=T.get()},toWillOff:function(){console.log("already will_off")}},E=I.get();chrome.browserAction.onClicked.addListener(function(){E.state==y?chrome.storage.sync.get("end-at",function(t){var n=t["end-at"];if(n){var o=new Date(n)-new Date;if(o>1e3)return void E.toOn()}e(g,"Session is expired.","assets/icons/icon_will_off.png","Click here to go to get a new ticket.")}):E.toOff()}),chrome.proxy.onProxyError.addListener(function(t){console.log("Service is on error:",t),t.fatal&&"net::ERR_PROXY_CONNECTION_FAILED"==t.error&&(E.toOff(),e(d,"Service is not available","assets/icons/icon_error.png",t.error))}),chrome.runtime.onMessageExternal.addListener(function(e,n,o){console.log("Got external message:",e),"ticketId"==e.intent?o({ticketId:w}):"changeTicketId"==e.intent&&(w=e.id,chrome.storage.sync.set({ticketid:w,"end-at":e["end-at"]},function(){chrome.runtime.lastError?console.log("Setting ticket id failed:",chrome.runtime.lastError.message):(console.log("Setting ticket id succeeded"),t(),E.toOn())}))})}();