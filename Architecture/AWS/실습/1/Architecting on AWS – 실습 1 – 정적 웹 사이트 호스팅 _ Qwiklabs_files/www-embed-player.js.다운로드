(function(){/*

 Copyright The Closure Library Authors.
 SPDX-License-Identifier: Apache-2.0
*/
var n;function aa(a){var b=0;return function(){return b<a.length?{done:!1,value:a[b++]}:{done:!0}}}
var ba="function"==typeof Object.defineProperties?Object.defineProperty:function(a,b,c){if(a==Array.prototype||a==Object.prototype)return a;a[b]=c.value;return a};
function ca(a){a=["object"==typeof globalThis&&globalThis,a,"object"==typeof window&&window,"object"==typeof self&&self,"object"==typeof global&&global];for(var b=0;b<a.length;++b){var c=a[b];if(c&&c.Math==Math)return c}throw Error("Cannot find global object");}
var da=ca(this);function t(a,b){if(b)a:{for(var c=da,d=a.split("."),e=0;e<d.length-1;e++){var f=d[e];if(!(f in c))break a;c=c[f]}d=d[d.length-1];e=c[d];f=b(e);f!=e&&null!=f&&ba(c,d,{configurable:!0,writable:!0,value:f})}}
t("Symbol",function(a){function b(e){if(this instanceof b)throw new TypeError("Symbol is not a constructor");return new c("jscomp_symbol_"+(e||"")+"_"+d++,e)}
function c(e,f){this.f=e;ba(this,"description",{configurable:!0,writable:!0,value:f})}
if(a)return a;c.prototype.toString=function(){return this.f};
var d=0;return b});
t("Symbol.iterator",function(a){if(a)return a;a=Symbol("Symbol.iterator");for(var b="Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array".split(" "),c=0;c<b.length;c++){var d=da[b[c]];"function"===typeof d&&"function"!=typeof d.prototype[a]&&ba(d.prototype,a,{configurable:!0,writable:!0,value:function(){return ea(aa(this))}})}return a});
function ea(a){a={next:a};a[Symbol.iterator]=function(){return this};
return a}
function u(a){var b="undefined"!=typeof Symbol&&Symbol.iterator&&a[Symbol.iterator];return b?b.call(a):{next:aa(a)}}
function fa(a){for(var b,c=[];!(b=a.next()).done;)c.push(b.value);return c}
var ha="function"==typeof Object.create?Object.create:function(a){function b(){}
b.prototype=a;return new b},ia=function(){function a(){function c(){}
new c;Reflect.construct(c,[],function(){});
return new c instanceof c}
if("undefined"!=typeof Reflect&&Reflect.construct){if(a())return Reflect.construct;var b=Reflect.construct;return function(c,d,e){c=b(c,d);e&&Reflect.setPrototypeOf(c,e.prototype);return c}}return function(c,d,e){void 0===e&&(e=c);
e=ha(e.prototype||Object.prototype);return Function.prototype.apply.call(c,e,d)||e}}(),ja;
if("function"==typeof Object.setPrototypeOf)ja=Object.setPrototypeOf;else{var ka;a:{var la={a:!0},ma={};try{ma.__proto__=la;ka=ma.a;break a}catch(a){}ka=!1}ja=ka?function(a,b){a.__proto__=b;if(a.__proto__!==b)throw new TypeError(a+" is not extensible");return a}:null}var na=ja;
function v(a,b){a.prototype=ha(b.prototype);a.prototype.constructor=a;if(na)na(a,b);else for(var c in b)if("prototype"!=c)if(Object.defineProperties){var d=Object.getOwnPropertyDescriptor(b,c);d&&Object.defineProperty(a,c,d)}else a[c]=b[c];a.J=b.prototype}
function oa(){this.l=!1;this.h=null;this.A=void 0;this.g=1;this.i=this.j=0;this.o=this.f=null}
function pa(a){if(a.l)throw new TypeError("Generator is already running");a.l=!0}
oa.prototype.m=function(a){this.A=a};
function qa(a,b){a.f={Ma:b,xa:!0};a.g=a.j||a.i}
oa.prototype["return"]=function(a){this.f={"return":a};this.g=this.i};
function ra(a,b){a.g=5;return{value:b}}
oa.prototype.qa=function(a){this.g=a};
function sa(a){a.j=2;a.i=3}
function ta(a){a.j=0;a.f=null}
function ua(a){a.o=[a.f];a.j=0;a.i=0}
function va(a){var b=a.o.splice(0)[0];(b=a.f=a.f||b)?b.xa?a.g=a.j||a.i:void 0!=b.qa&&a.i<b.qa?(a.g=b.qa,a.f=null):a.g=a.i:a.g=4}
function wa(a){this.f=new oa;this.g=a}
function xa(a,b){pa(a.f);var c=a.f.h;if(c)return ya(a,"return"in c?c["return"]:function(d){return{value:d,done:!0}},b,a.f["return"]);
a.f["return"](b);return za(a)}
function ya(a,b,c,d){try{var e=b.call(a.f.h,c);if(!(e instanceof Object))throw new TypeError("Iterator result "+e+" is not an object");if(!e.done)return a.f.l=!1,e;var f=e.value}catch(g){return a.f.h=null,qa(a.f,g),za(a)}a.f.h=null;d.call(a.f,f);return za(a)}
function za(a){for(;a.f.g;)try{var b=a.g(a.f);if(b)return a.f.l=!1,{value:b.value,done:!1}}catch(c){a.f.A=void 0,qa(a.f,c)}a.f.l=!1;if(a.f.f){b=a.f.f;a.f.f=null;if(b.xa)throw b.Ma;return{value:b["return"],done:!0}}return{value:void 0,done:!0}}
function Aa(a){this.next=function(b){pa(a.f);a.f.h?b=ya(a,a.f.h.next,b,a.f.m):(a.f.m(b),b=za(a));return b};
this["throw"]=function(b){pa(a.f);a.f.h?b=ya(a,a.f.h["throw"],b,a.f.m):(qa(a.f,b),b=za(a));return b};
this["return"]=function(b){return xa(a,b)};
this[Symbol.iterator]=function(){return this}}
function Ba(a,b){var c=new Aa(new wa(b));na&&a.prototype&&na(c,a.prototype);return c}
t("Reflect",function(a){return a?a:{}});
t("Reflect.construct",function(){return ia});
t("Reflect.setPrototypeOf",function(a){return a?a:na?function(b,c){try{return na(b,c),!0}catch(d){return!1}}:null});
function Ca(a,b,c){if(null==a)throw new TypeError("The 'this' value for String.prototype."+c+" must not be null or undefined");if(b instanceof RegExp)throw new TypeError("First argument to String.prototype."+c+" must not be a regular expression");return a+""}
t("String.prototype.endsWith",function(a){return a?a:function(b,c){var d=Ca(this,b,"endsWith");b+="";void 0===c&&(c=d.length);for(var e=Math.max(0,Math.min(c|0,d.length)),f=b.length;0<f&&0<e;)if(d[--e]!=b[--f])return!1;return 0>=f}});
t("String.prototype.startsWith",function(a){return a?a:function(b,c){var d=Ca(this,b,"startsWith");b+="";for(var e=d.length,f=b.length,g=Math.max(0,Math.min(c|0,d.length)),h=0;h<f&&g<e;)if(d[g++]!=b[h++])return!1;return h>=f}});
t("Object.setPrototypeOf",function(a){return a||na});
function w(a,b){return Object.prototype.hasOwnProperty.call(a,b)}
var Da="function"==typeof Object.assign?Object.assign:function(a,b){for(var c=1;c<arguments.length;c++){var d=arguments[c];if(d)for(var e in d)w(d,e)&&(a[e]=d[e])}return a};
t("Object.assign",function(a){return a||Da});
t("Promise",function(a){function b(g){this.f=0;this.h=void 0;this.g=[];this.m=!1;var h=this.i();try{g(h.resolve,h.reject)}catch(k){h.reject(k)}}
function c(){this.f=null}
function d(g){return g instanceof b?g:new b(function(h){h(g)})}
if(a)return a;c.prototype.g=function(g){if(null==this.f){this.f=[];var h=this;this.h(function(){h.j()})}this.f.push(g)};
var e=da.setTimeout;c.prototype.h=function(g){e(g,0)};
c.prototype.j=function(){for(;this.f&&this.f.length;){var g=this.f;this.f=[];for(var h=0;h<g.length;++h){var k=g[h];g[h]=null;try{k()}catch(l){this.i(l)}}}this.f=null};
c.prototype.i=function(g){this.h(function(){throw g;})};
b.prototype.i=function(){function g(l){return function(m){k||(k=!0,l.call(h,m))}}
var h=this,k=!1;return{resolve:g(this.H),reject:g(this.j)}};
b.prototype.H=function(g){if(g===this)this.j(new TypeError("A Promise cannot resolve to itself"));else if(g instanceof b)this.R(g);else{a:switch(typeof g){case "object":var h=null!=g;break a;case "function":h=!0;break a;default:h=!1}h?this.G(g):this.l(g)}};
b.prototype.G=function(g){var h=void 0;try{h=g.then}catch(k){this.j(k);return}"function"==typeof h?this.S(h,g):this.l(g)};
b.prototype.j=function(g){this.A(2,g)};
b.prototype.l=function(g){this.A(1,g)};
b.prototype.A=function(g,h){if(0!=this.f)throw Error("Cannot settle("+g+", "+h+"): Promise already settled in state"+this.f);this.f=g;this.h=h;2===this.f&&this.I();this.o()};
b.prototype.I=function(){var g=this;e(function(){if(g.B()){var h=da.console;"undefined"!==typeof h&&h.error(g.h)}},1)};
b.prototype.B=function(){if(this.m)return!1;var g=da.CustomEvent,h=da.Event,k=da.dispatchEvent;if("undefined"===typeof k)return!0;"function"===typeof g?g=new g("unhandledrejection",{cancelable:!0}):"function"===typeof h?g=new h("unhandledrejection",{cancelable:!0}):(g=da.document.createEvent("CustomEvent"),g.initCustomEvent("unhandledrejection",!1,!0,g));g.promise=this;g.reason=this.h;return k(g)};
b.prototype.o=function(){if(null!=this.g){for(var g=0;g<this.g.length;++g)f.g(this.g[g]);this.g=null}};
var f=new c;b.prototype.R=function(g){var h=this.i();g.ga(h.resolve,h.reject)};
b.prototype.S=function(g,h){var k=this.i();try{g.call(h,k.resolve,k.reject)}catch(l){k.reject(l)}};
b.prototype.then=function(g,h){function k(q,r){return"function"==typeof q?function(A){try{l(q(A))}catch(B){m(B)}}:r}
var l,m,p=new b(function(q,r){l=q;m=r});
this.ga(k(g,l),k(h,m));return p};
b.prototype["catch"]=function(g){return this.then(void 0,g)};
b.prototype.ga=function(g,h){function k(){switch(l.f){case 1:g(l.h);break;case 2:h(l.h);break;default:throw Error("Unexpected state: "+l.f);}}
var l=this;null==this.g?f.g(k):this.g.push(k);this.m=!0};
b.resolve=d;b.reject=function(g){return new b(function(h,k){k(g)})};
b.race=function(g){return new b(function(h,k){for(var l=u(g),m=l.next();!m.done;m=l.next())d(m.value).ga(h,k)})};
b.all=function(g){var h=u(g),k=h.next();return k.done?d([]):new b(function(l,m){function p(A){return function(B){q[A]=B;r--;0==r&&l(q)}}
var q=[],r=0;do q.push(void 0),r++,d(k.value).ga(p(q.length-1),m),k=h.next();while(!k.done)})};
return b});
function Ea(a,b){a instanceof String&&(a+="");var c=0,d=!1,e={next:function(){if(!d&&c<a.length){var f=c++;return{value:b(f,a[f]),done:!1}}d=!0;return{done:!0,value:void 0}}};
e[Symbol.iterator]=function(){return e};
return e}
t("Array.prototype.entries",function(a){return a?a:function(){return Ea(this,function(b,c){return[b,c]})}});
t("Array.prototype.keys",function(a){return a?a:function(){return Ea(this,function(b){return b})}});
t("Array.prototype.values",function(a){return a?a:function(){return Ea(this,function(b,c){return c})}});
t("Object.is",function(a){return a?a:function(b,c){return b===c?0!==b||1/b===1/c:b!==b&&c!==c}});
t("Array.prototype.includes",function(a){return a?a:function(b,c){var d=this;d instanceof String&&(d=String(d));var e=d.length,f=c||0;for(0>f&&(f=Math.max(f+e,0));f<e;f++){var g=d[f];if(g===b||Object.is(g,b))return!0}return!1}});
t("String.prototype.includes",function(a){return a?a:function(b,c){return-1!==Ca(this,b,"includes").indexOf(b,c||0)}});
t("Object.entries",function(a){return a?a:function(b){var c=[],d;for(d in b)w(b,d)&&c.push([d,b[d]]);return c}});
t("WeakMap",function(a){function b(k){this.f=(h+=Math.random()+1).toString();if(k){k=u(k);for(var l;!(l=k.next()).done;)l=l.value,this.set(l[0],l[1])}}
function c(){}
function d(k){var l=typeof k;return"object"===l&&null!==k||"function"===l}
function e(k){if(!w(k,g)){var l=new c;ba(k,g,{value:l})}}
function f(k){var l=Object[k];l&&(Object[k]=function(m){if(m instanceof c)return m;Object.isExtensible(m)&&e(m);return l(m)})}
if(function(){if(!a||!Object.seal)return!1;try{var k=Object.seal({}),l=Object.seal({}),m=new a([[k,2],[l,3]]);if(2!=m.get(k)||3!=m.get(l))return!1;m["delete"](k);m.set(l,4);return!m.has(k)&&4==m.get(l)}catch(p){return!1}}())return a;
var g="$jscomp_hidden_"+Math.random();f("freeze");f("preventExtensions");f("seal");var h=0;b.prototype.set=function(k,l){if(!d(k))throw Error("Invalid WeakMap key");e(k);if(!w(k,g))throw Error("WeakMap key fail: "+k);k[g][this.f]=l;return this};
b.prototype.get=function(k){return d(k)&&w(k,g)?k[g][this.f]:void 0};
b.prototype.has=function(k){return d(k)&&w(k,g)&&w(k[g],this.f)};
b.prototype["delete"]=function(k){return d(k)&&w(k,g)&&w(k[g],this.f)?delete k[g][this.f]:!1};
return b});
t("Map",function(a){function b(){var h={};return h.previous=h.next=h.head=h}
function c(h,k){var l=h.f;return ea(function(){if(l){for(;l.head!=h.f;)l=l.previous;for(;l.next!=l.head;)return l=l.next,{done:!1,value:k(l)};l=null}return{done:!0,value:void 0}})}
function d(h,k){var l=k&&typeof k;"object"==l||"function"==l?f.has(k)?l=f.get(k):(l=""+ ++g,f.set(k,l)):l="p_"+k;var m=h.g[l];if(m&&w(h.g,l))for(var p=0;p<m.length;p++){var q=m[p];if(k!==k&&q.key!==q.key||k===q.key)return{id:l,list:m,index:p,C:q}}return{id:l,list:m,index:-1,C:void 0}}
function e(h){this.g={};this.f=b();this.size=0;if(h){h=u(h);for(var k;!(k=h.next()).done;)k=k.value,this.set(k[0],k[1])}}
if(function(){if(!a||"function"!=typeof a||!a.prototype.entries||"function"!=typeof Object.seal)return!1;try{var h=Object.seal({x:4}),k=new a(u([[h,"s"]]));if("s"!=k.get(h)||1!=k.size||k.get({x:4})||k.set({x:4},"t")!=k||2!=k.size)return!1;var l=k.entries(),m=l.next();if(m.done||m.value[0]!=h||"s"!=m.value[1])return!1;m=l.next();return m.done||4!=m.value[0].x||"t"!=m.value[1]||!l.next().done?!1:!0}catch(p){return!1}}())return a;
var f=new WeakMap;e.prototype.set=function(h,k){h=0===h?0:h;var l=d(this,h);l.list||(l.list=this.g[l.id]=[]);l.C?l.C.value=k:(l.C={next:this.f,previous:this.f.previous,head:this.f,key:h,value:k},l.list.push(l.C),this.f.previous.next=l.C,this.f.previous=l.C,this.size++);return this};
e.prototype["delete"]=function(h){h=d(this,h);return h.C&&h.list?(h.list.splice(h.index,1),h.list.length||delete this.g[h.id],h.C.previous.next=h.C.next,h.C.next.previous=h.C.previous,h.C.head=null,this.size--,!0):!1};
e.prototype.clear=function(){this.g={};this.f=this.f.previous=b();this.size=0};
e.prototype.has=function(h){return!!d(this,h).C};
e.prototype.get=function(h){return(h=d(this,h).C)&&h.value};
e.prototype.entries=function(){return c(this,function(h){return[h.key,h.value]})};
e.prototype.keys=function(){return c(this,function(h){return h.key})};
e.prototype.values=function(){return c(this,function(h){return h.value})};
e.prototype.forEach=function(h,k){for(var l=this.entries(),m;!(m=l.next()).done;)m=m.value,h.call(k,m[1],m[0],this)};
e.prototype[Symbol.iterator]=e.prototype.entries;var g=0;return e});
t("Set",function(a){function b(c){this.f=new Map;if(c){c=u(c);for(var d;!(d=c.next()).done;)this.add(d.value)}this.size=this.f.size}
if(function(){if(!a||"function"!=typeof a||!a.prototype.entries||"function"!=typeof Object.seal)return!1;try{var c=Object.seal({x:4}),d=new a(u([c]));if(!d.has(c)||1!=d.size||d.add(c)!=d||1!=d.size||d.add({x:4})!=d||2!=d.size)return!1;var e=d.entries(),f=e.next();if(f.done||f.value[0]!=c||f.value[1]!=c)return!1;f=e.next();return f.done||f.value[0]==c||4!=f.value[0].x||f.value[1]!=f.value[0]?!1:e.next().done}catch(g){return!1}}())return a;
b.prototype.add=function(c){c=0===c?0:c;this.f.set(c,c);this.size=this.f.size;return this};
b.prototype["delete"]=function(c){c=this.f["delete"](c);this.size=this.f.size;return c};
b.prototype.clear=function(){this.f.clear();this.size=0};
b.prototype.has=function(c){return this.f.has(c)};
b.prototype.entries=function(){return this.f.entries()};
b.prototype.values=function(){return this.f.values()};
b.prototype.keys=b.prototype.values;b.prototype[Symbol.iterator]=b.prototype.values;b.prototype.forEach=function(c,d){var e=this;this.f.forEach(function(f){return c.call(d,f,f,e)})};
return b});
t("Object.values",function(a){return a?a:function(b){var c=[],d;for(d in b)w(b,d)&&c.push(b[d]);return c}});
var x=this||self;function y(a,b,c){a=a.split(".");c=c||x;a[0]in c||"undefined"==typeof c.execScript||c.execScript("var "+a[0]);for(var d;a.length&&(d=a.shift());)a.length||void 0===b?c[d]&&c[d]!==Object.prototype[d]?c=c[d]:c=c[d]={}:c[d]=b}
function Fa(a){if(a&&a!=x)return Ga(a.document);null===Ha&&(Ha=Ga(x.document));return Ha}
var Ia=/^[\w+/_-]+[=]{0,2}$/,Ha=null;function Ga(a){return(a=a.querySelector&&a.querySelector("script[nonce]"))&&(a=a.nonce||a.getAttribute("nonce"))&&Ia.test(a)?a:""}
function z(a,b){for(var c=a.split("."),d=b||x,e=0;e<c.length;e++)if(d=d[c[e]],null==d)return null;return d}
function Ja(){}
function Ka(a){a.oa=void 0;a.getInstance=function(){return a.oa?a.oa:a.oa=new a}}
function La(a){var b=typeof a;return"object"!=b?b:a?Array.isArray(a)?"array":b:"null"}
function Ma(a){var b=La(a);return"array"==b||"object"==b&&"number"==typeof a.length}
function C(a){var b=typeof a;return"object"==b&&null!=a||"function"==b}
function Na(a){return Object.prototype.hasOwnProperty.call(a,Oa)&&a[Oa]||(a[Oa]=++Pa)}
var Oa="closure_uid_"+(1E9*Math.random()>>>0),Pa=0;function Qa(a,b,c){return a.call.apply(a.bind,arguments)}
function Ra(a,b,c){if(!a)throw Error();if(2<arguments.length){var d=Array.prototype.slice.call(arguments,2);return function(){var e=Array.prototype.slice.call(arguments);Array.prototype.unshift.apply(e,d);return a.apply(b,e)}}return function(){return a.apply(b,arguments)}}
function D(a,b,c){Function.prototype.bind&&-1!=Function.prototype.bind.toString().indexOf("native code")?D=Qa:D=Ra;return D.apply(null,arguments)}
function Sa(a,b){var c=Array.prototype.slice.call(arguments,1);return function(){var d=c.slice();d.push.apply(d,arguments);return a.apply(this,d)}}
function E(){return Date.now()}
function F(a,b){y(a,b,void 0)}
function G(a,b){function c(){}
c.prototype=b.prototype;a.J=b.prototype;a.prototype=new c;a.prototype.constructor=a;a.dk=function(d,e,f){for(var g=Array(arguments.length-2),h=2;h<arguments.length;h++)g[h-2]=arguments[h];return b.prototype[e].apply(d,g)}}
function Ta(a){return a}
;function Ua(a){if(Error.captureStackTrace)Error.captureStackTrace(this,Ua);else{var b=Error().stack;b&&(this.stack=b)}a&&(this.message=String(a))}
G(Ua,Error);Ua.prototype.name="CustomError";function Va(a){a=a.url;var b=/[?&]dsh=1(&|$)/.test(a);this.h=!b&&/[?&]ae=1(&|$)/.test(a);this.i=!b&&/[?&]ae=2(&|$)/.test(a);if((this.f=/[?&]adurl=([^&]*)/.exec(a))&&this.f[1]){try{var c=decodeURIComponent(this.f[1])}catch(d){c=null}this.g=c}}
;function Wa(a){var b=!1,c;return function(){b||(c=a(),b=!0);return c}}
;var Xa=Array.prototype.indexOf?function(a,b){return Array.prototype.indexOf.call(a,b,void 0)}:function(a,b){if("string"===typeof a)return"string"!==typeof b||1!=b.length?-1:a.indexOf(b,0);
for(var c=0;c<a.length;c++)if(c in a&&a[c]===b)return c;return-1},H=Array.prototype.forEach?function(a,b,c){Array.prototype.forEach.call(a,b,c)}:function(a,b,c){for(var d=a.length,e="string"===typeof a?a.split(""):a,f=0;f<d;f++)f in e&&b.call(c,e[f],f,a)},Za=Array.prototype.filter?function(a,b){return Array.prototype.filter.call(a,b,void 0)}:function(a,b){for(var c=a.length,d=[],e=0,f="string"===typeof a?a.split(""):a,g=0;g<c;g++)if(g in f){var h=f[g];
b.call(void 0,h,g,a)&&(d[e++]=h)}return d},$a=Array.prototype.map?function(a,b){return Array.prototype.map.call(a,b,void 0)}:function(a,b){for(var c=a.length,d=Array(c),e="string"===typeof a?a.split(""):a,f=0;f<c;f++)f in e&&(d[f]=b.call(void 0,e[f],f,a));
return d},ab=Array.prototype.reduce?function(a,b,c){return Array.prototype.reduce.call(a,b,c)}:function(a,b,c){var d=c;
H(a,function(e,f){d=b.call(void 0,d,e,f,a)});
return d};
function bb(a,b){a:{var c=a.length;for(var d="string"===typeof a?a.split(""):a,e=0;e<c;e++)if(e in d&&b.call(void 0,d[e],e,a)){c=e;break a}c=-1}return 0>c?null:"string"===typeof a?a.charAt(c):a[c]}
function cb(a,b){var c=Xa(a,b),d;(d=0<=c)&&Array.prototype.splice.call(a,c,1);return d}
function db(a){var b=a.length;if(0<b){for(var c=Array(b),d=0;d<b;d++)c[d]=a[d];return c}return[]}
function eb(a,b){for(var c=1;c<arguments.length;c++){var d=arguments[c];if(Ma(d)){var e=a.length||0,f=d.length||0;a.length=e+f;for(var g=0;g<f;g++)a[e+g]=d[g]}else a.push(d)}}
;function fb(a,b){for(var c in a)b.call(void 0,a[c],c,a)}
function gb(a,b){var c=Ma(b),d=c?b:arguments;for(c=c?0:1;c<d.length;c++){if(null==a)return;a=a[d[c]]}return a}
function hb(a){var b=ib,c;for(c in b)if(a.call(void 0,b[c],c,b))return c}
function jb(a){for(var b in a)return!1;return!0}
function kb(a,b){if(null!==a&&b in a)throw Error('The object already contains the key "'+b+'"');a[b]=!0}
function lb(a,b){for(var c in a)if(!(c in b)||a[c]!==b[c])return!1;for(var d in b)if(!(d in a))return!1;return!0}
function mb(a){var b={},c;for(c in a)b[c]=a[c];return b}
function nb(a){if(!a||"object"!==typeof a)return a;if("function"===typeof a.clone)return a.clone();var b=Array.isArray(a)?[]:"function"!==typeof ArrayBuffer||"function"!==typeof ArrayBuffer.isView||!ArrayBuffer.isView(a)||a instanceof DataView?{}:new a.constructor(a.length),c;for(c in a)b[c]=nb(a[c]);return b}
var ob="constructor hasOwnProperty isPrototypeOf propertyIsEnumerable toLocaleString toString valueOf".split(" ");function pb(a,b){for(var c,d,e=1;e<arguments.length;e++){d=arguments[e];for(c in d)a[c]=d[c];for(var f=0;f<ob.length;f++)c=ob[f],Object.prototype.hasOwnProperty.call(d,c)&&(a[c]=d[c])}}
;var qb;function rb(){if(void 0===qb){var a=null,b=x.trustedTypes;if(b&&b.createPolicy){try{a=b.createPolicy("goog#html",{createHTML:Ta,createScript:Ta,createScriptURL:Ta})}catch(c){x.console&&x.console.error(c.message)}qb=a}else qb=a}return qb}
;function sb(a,b){this.f=b===tb?a:""}
sb.prototype.U=!0;sb.prototype.T=function(){return this.f.toString()};
sb.prototype.na=!0;sb.prototype.ka=function(){return 1};
function ub(a){if(a instanceof sb&&a.constructor===sb)return a.f;La(a);return"type_error:TrustedResourceUrl"}
var tb={};var vb=String.prototype.trim?function(a){return a.trim()}:function(a){return/^[\s\xa0]*([\s\S]*?)[\s\xa0]*$/.exec(a)[1]};
function wb(a,b){if(b)a=a.replace(xb,"&amp;").replace(yb,"&lt;").replace(zb,"&gt;").replace(Ab,"&quot;").replace(Bb,"&#39;").replace(Cb,"&#0;");else{if(!Db.test(a))return a;-1!=a.indexOf("&")&&(a=a.replace(xb,"&amp;"));-1!=a.indexOf("<")&&(a=a.replace(yb,"&lt;"));-1!=a.indexOf(">")&&(a=a.replace(zb,"&gt;"));-1!=a.indexOf('"')&&(a=a.replace(Ab,"&quot;"));-1!=a.indexOf("'")&&(a=a.replace(Bb,"&#39;"));-1!=a.indexOf("\x00")&&(a=a.replace(Cb,"&#0;"))}return a}
var xb=/&/g,yb=/</g,zb=/>/g,Ab=/"/g,Bb=/'/g,Cb=/\x00/g,Db=/[\x00&<>"']/;function Eb(a,b){return a<b?-1:a>b?1:0}
;function I(a,b){this.f=b===Fb?a:""}
I.prototype.U=!0;I.prototype.T=function(){return this.f.toString()};
I.prototype.na=!0;I.prototype.ka=function(){return 1};
function Gb(a){if(a instanceof I&&a.constructor===I)return a.f;La(a);return"type_error:SafeUrl"}
var Hb=/^(?:audio\/(?:3gpp2|3gpp|aac|L16|midi|mp3|mp4|mpeg|oga|ogg|opus|x-m4a|x-matroska|x-wav|wav|webm)|font\/\w+|image\/(?:bmp|gif|jpeg|jpg|png|tiff|webp|x-icon)|video\/(?:mpeg|mp4|ogg|webm|quicktime|x-matroska))(?:;\w+=(?:\w+|"[\w;,= ]+"))*$/i,Ib=/^data:(.*);base64,[a-z0-9+\/]+=*$/i,Jb=/^(?:(?:https?|mailto|ftp):|[^:/?#]*(?:[/?#]|$))/i;function Kb(a){if(a instanceof I)return a;a="object"==typeof a&&a.U?a.T():String(a);Jb.test(a)||(a="about:invalid#zClosurez");return new I(a,Fb)}
var Fb={},Lb=new I("about:invalid#zClosurez",Fb);var Mb;a:{var Nb=x.navigator;if(Nb){var Ob=Nb.userAgent;if(Ob){Mb=Ob;break a}}Mb=""}function J(a){return-1!=Mb.indexOf(a)}
;function Pb(a,b,c){this.f=c===Qb?a:"";this.g=b}
Pb.prototype.na=!0;Pb.prototype.ka=function(){return this.g};
Pb.prototype.U=!0;Pb.prototype.T=function(){return this.f.toString()};
var Qb={};function Rb(a,b){var c=rb();c=c?c.createHTML(a):a;return new Pb(c,b,Qb)}
;function Sb(a,b){var c=b instanceof I?b:Kb(b);a.href=Gb(c)}
function Tb(a,b){a.src=ub(b);var c=Fa(a.ownerDocument&&a.ownerDocument.defaultView);c&&a.setAttribute("nonce",c)}
;function Ub(a){return a=wb(a,void 0)}
function Vb(a){for(var b=0,c=0;c<a.length;++c)b=31*b+a.charCodeAt(c)>>>0;return b}
;var Wb=/^(?:([^:/?#.]+):)?(?:\/\/(?:([^\\/?#]*)@)?([^\\/?#]*?)(?::([0-9]+))?(?=[\\/?#]|$))?([^?#]+)?(?:\?([^#]*))?(?:#([\s\S]*))?$/;function Xb(a){return a?decodeURI(a):a}
function Yb(a){return Xb(a.match(Wb)[3]||null)}
function Zb(a,b,c){if(Array.isArray(b))for(var d=0;d<b.length;d++)Zb(a,String(b[d]),c);else null!=b&&c.push(a+(""===b?"":"="+encodeURIComponent(String(b))))}
function $b(a){var b=[],c;for(c in a)Zb(c,a[c],b);return b.join("&")}
function ac(a,b){var c=$b(b);if(c){var d=a.indexOf("#");0>d&&(d=a.length);var e=a.indexOf("?");if(0>e||e>d){e=d;var f=""}else f=a.substring(e+1,d);d=[a.substr(0,e),f,a.substr(d)];e=d[1];d[1]=c?e?e+"&"+c:c:e;c=d[0]+(d[1]?"?"+d[1]:"")+d[2]}else c=a;return c}
var bc=/#|$/;function cc(a,b){var c=void 0;return new (c||(c=Promise))(function(d,e){function f(k){try{h(b.next(k))}catch(l){e(l)}}
function g(k){try{h(b["throw"](k))}catch(l){e(l)}}
function h(k){k.done?d(k.value):(new c(function(l){l(k.value)})).then(f,g)}
h((b=b.apply(a,void 0)).next())})}
;function dc(a){dc[" "](a);return a}
dc[" "]=Ja;var ec=J("Opera"),fc=J("Trident")||J("MSIE"),gc=J("Edge"),hc=J("Gecko")&&!(-1!=Mb.toLowerCase().indexOf("webkit")&&!J("Edge"))&&!(J("Trident")||J("MSIE"))&&!J("Edge"),ic=-1!=Mb.toLowerCase().indexOf("webkit")&&!J("Edge");function jc(){var a=x.document;return a?a.documentMode:void 0}
var lc;a:{var mc="",nc=function(){var a=Mb;if(hc)return/rv:([^\);]+)(\)|;)/.exec(a);if(gc)return/Edge\/([\d\.]+)/.exec(a);if(fc)return/\b(?:MSIE|rv)[: ]([^\);]+)(\)|;)/.exec(a);if(ic)return/WebKit\/(\S+)/.exec(a);if(ec)return/(?:Version)[ \/]?(\S+)/.exec(a)}();
nc&&(mc=nc?nc[1]:"");if(fc){var oc=jc();if(null!=oc&&oc>parseFloat(mc)){lc=String(oc);break a}}lc=mc}var pc=lc,qc={},rc;if(x.document&&fc){var sc=jc();rc=sc?sc:parseInt(pc,10)||void 0}else rc=void 0;var tc=rc;var uc=J("Firefox")||J("FxiOS"),vc=J("iPhone")&&!J("iPod")&&!J("iPad")||J("iPod"),wc=J("iPad");var xc={},yc=null;
function zc(a){var b=3;Ma(a);void 0===b&&(b=0);if(!yc){yc={};for(var c="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".split(""),d=["+/=","+/","-_=","-_.","-_"],e=0;5>e;e++){var f=c.concat(d[e].split(""));xc[e]=f;for(var g=0;g<f.length;g++){var h=f[g];void 0===yc[h]&&(yc[h]=g)}}}b=xc[b];c=[];for(d=0;d<a.length;d+=3){var k=a[d],l=(e=d+1<a.length)?a[d+1]:0;h=(f=d+2<a.length)?a[d+2]:0;g=k>>2;k=(k&3)<<4|l>>4;l=(l&15)<<2|h>>6;h&=63;f||(h=64,e||(l=64));c.push(b[g],b[k],b[l]||"",b[h]||"")}return c.join("")}
;var K=window;function Ac(a){var b=z("window.location.href");null==a&&(a='Unknown Error of type "null/undefined"');if("string"===typeof a)return{message:a,name:"Unknown error",lineNumber:"Not available",fileName:b,stack:"Not available"};var c=!1;try{var d=a.lineNumber||a.line||"Not available"}catch(g){d="Not available",c=!0}try{var e=a.fileName||a.filename||a.sourceURL||x.$googDebugFname||b}catch(g){e="Not available",c=!0}b=Bc(a);if(!(!c&&a.lineNumber&&a.fileName&&a.stack&&a.message&&a.name)){c=a.message;if(null==
c){if(a.constructor&&a.constructor instanceof Function){if(a.constructor.name)c=a.constructor.name;else if(c=a.constructor,Cc[c])c=Cc[c];else{c=String(c);if(!Cc[c]){var f=/function\s+([^\(]+)/m.exec(c);Cc[c]=f?f[1]:"[Anonymous]"}c=Cc[c]}c='Unknown Error of type "'+c+'"'}else c="Unknown Error of unknown type";"function"===typeof a.toString&&Object.prototype.toString!==a.toString&&(c+=": "+a.toString())}return{message:c,name:a.name||"UnknownError",lineNumber:d,fileName:e,stack:b||"Not available"}}a.stack=
b;return a}
function Bc(a,b){b||(b={});b[Dc(a)]=!0;var c=a.stack||"",d=a.ek;d&&!b[Dc(d)]&&(c+="\nCaused by: ",d.stack&&0==d.stack.indexOf(d.toString())||(c+="string"===typeof d?d:d.message+"\n"),c+=Bc(d,b));return c}
function Dc(a){var b="";"function"===typeof a.toString&&(b=""+a);return b+a.stack}
var Cc={};function Ec(a){this.f=a||{cookie:""}}
n=Ec.prototype;n.isEnabled=function(){return navigator.cookieEnabled};
n.set=function(a,b,c){var d=!1;if("object"===typeof c){var e=c.nk;d=c.secure||!1;var f=c.domain||void 0;var g=c.path||void 0;var h=c.ya}if(/[;=\s]/.test(a))throw Error('Invalid cookie name "'+a+'"');if(/[;\r\n]/.test(b))throw Error('Invalid cookie value "'+b+'"');void 0===h&&(h=-1);this.f.cookie=a+"="+b+(f?";domain="+f:"")+(g?";path="+g:"")+(0>h?"":0==h?";expires="+(new Date(1970,1,1)).toUTCString():";expires="+(new Date(Date.now()+1E3*h)).toUTCString())+(d?";secure":"")+(null!=e?";samesite="+e:"")};
n.get=function(a,b){for(var c=a+"=",d=(this.f.cookie||"").split(";"),e=0,f;e<d.length;e++){f=vb(d[e]);if(0==f.lastIndexOf(c,0))return f.substr(c.length);if(f==a)return""}return b};
n.remove=function(a,b,c){var d=void 0!==this.get(a);this.set(a,"",{ya:0,path:b,domain:c});return d};
n.isEmpty=function(){return!this.f.cookie};
n.clear=function(){for(var a=(this.f.cookie||"").split(";"),b=[],c=[],d,e,f=0;f<a.length;f++)e=vb(a[f]),d=e.indexOf("="),-1==d?(b.push(""),c.push(e)):(b.push(e.substring(0,d)),c.push(e.substring(d+1)));for(a=b.length-1;0<=a;a--)this.remove(b[a])};
var Fc=new Ec("undefined"==typeof document?null:document);var Gc=!fc||9<=Number(tc);function Hc(a,b){this.x=void 0!==a?a:0;this.y=void 0!==b?b:0}
n=Hc.prototype;n.clone=function(){return new Hc(this.x,this.y)};
n.equals=function(a){return a instanceof Hc&&(this==a?!0:this&&a?this.x==a.x&&this.y==a.y:!1)};
n.ceil=function(){this.x=Math.ceil(this.x);this.y=Math.ceil(this.y);return this};
n.floor=function(){this.x=Math.floor(this.x);this.y=Math.floor(this.y);return this};
n.round=function(){this.x=Math.round(this.x);this.y=Math.round(this.y);return this};function Ic(a,b){this.width=a;this.height=b}
n=Ic.prototype;n.clone=function(){return new Ic(this.width,this.height)};
n.aspectRatio=function(){return this.width/this.height};
n.isEmpty=function(){return!(this.width*this.height)};
n.ceil=function(){this.width=Math.ceil(this.width);this.height=Math.ceil(this.height);return this};
n.floor=function(){this.width=Math.floor(this.width);this.height=Math.floor(this.height);return this};
n.round=function(){this.width=Math.round(this.width);this.height=Math.round(this.height);return this};function Jc(a){var b=document;return"string"===typeof a?b.getElementById(a):a}
function Kc(a,b){fb(b,function(c,d){c&&"object"==typeof c&&c.U&&(c=c.T());"style"==d?a.style.cssText=c:"class"==d?a.className=c:"for"==d?a.htmlFor=c:Lc.hasOwnProperty(d)?a.setAttribute(Lc[d],c):0==d.lastIndexOf("aria-",0)||0==d.lastIndexOf("data-",0)?a.setAttribute(d,c):a[d]=c})}
var Lc={cellpadding:"cellPadding",cellspacing:"cellSpacing",colspan:"colSpan",frameborder:"frameBorder",height:"height",maxlength:"maxLength",nonce:"nonce",role:"role",rowspan:"rowSpan",type:"type",usemap:"useMap",valign:"vAlign",width:"width"};
function Mc(a,b,c){var d=arguments,e=document,f=String(d[0]),g=d[1];if(!Gc&&g&&(g.name||g.type)){f=["<",f];g.name&&f.push(' name="',Ub(g.name),'"');if(g.type){f.push(' type="',Ub(g.type),'"');var h={};pb(h,g);delete h.type;g=h}f.push(">");f=f.join("")}f=Nc(e,f);g&&("string"===typeof g?f.className=g:Array.isArray(g)?f.className=g.join(" "):Kc(f,g));2<d.length&&Oc(e,f,d);return f}
function Oc(a,b,c){function d(h){h&&b.appendChild("string"===typeof h?a.createTextNode(h):h)}
for(var e=2;e<c.length;e++){var f=c[e];if(!Ma(f)||C(f)&&0<f.nodeType)d(f);else{a:{if(f&&"number"==typeof f.length){if(C(f)){var g="function"==typeof f.item||"string"==typeof f.item;break a}if("function"===typeof f){g="function"==typeof f.item;break a}}g=!1}H(g?db(f):f,d)}}}
function Nc(a,b){b=String(b);"application/xhtml+xml"===a.contentType&&(b=b.toLowerCase());return a.createElement(b)}
function Pc(a,b){for(var c=0;a;){if(b(a))return a;a=a.parentNode;c++}return null}
;function Qc(a){var b=Rc;if(b)for(var c in b)Object.prototype.hasOwnProperty.call(b,c)&&a.call(void 0,b[c],c,b)}
function Sc(){var a=[];Qc(function(b){a.push(b)});
return a}
var Rc={Fb:"allow-forms",Gb:"allow-modals",Hb:"allow-orientation-lock",Ib:"allow-pointer-lock",Jb:"allow-popups",Kb:"allow-popups-to-escape-sandbox",Lb:"allow-presentation",Mb:"allow-same-origin",Nb:"allow-scripts",Ob:"allow-top-navigation",Pb:"allow-top-navigation-by-user-activation"},Tc=Wa(function(){return Sc()});
function Uc(){var a=Nc(document,"IFRAME"),b={};H(Tc(),function(c){a.sandbox&&a.sandbox.supports&&a.sandbox.supports(c)&&(b[c]=!0)});
return b}
;function L(){this.g=this.g;this.A=this.A}
L.prototype.g=!1;L.prototype.dispose=function(){this.g||(this.g=!0,this.u())};
function Vc(a,b){a.g?b():(a.A||(a.A=[]),a.A.push(b))}
L.prototype.u=function(){if(this.A)for(;this.A.length;)this.A.shift()()};
function Wc(a){a&&"function"==typeof a.dispose&&a.dispose()}
function Xc(a){for(var b=0,c=arguments.length;b<c;++b){var d=arguments[b];Ma(d)?Xc.apply(null,d):Wc(d)}}
;var Yc={};function Zc(){}
function $c(a,b){if(b!==Yc)throw Error("Bad secret");this.f=a}
v($c,Zc);$c.prototype.toString=function(){return this.f};new $c("about:blank",Yc);new $c("about:invalid#zTSz",Yc);function ad(a){bd();var b=rb();a=b?b.createScriptURL(a):a;return new sb(a,tb)}
var bd=Ja;function cd(a){"number"==typeof a&&(a=Math.round(a)+"px");return a}
;var dd=(new Date).getTime();function ed(a){if(!a)return"";a=a.split("#")[0].split("?")[0];a=a.toLowerCase();0==a.indexOf("//")&&(a=window.location.protocol+a);/^[\w\-]*:\/\//.test(a)||(a=window.location.href);var b=a.substring(a.indexOf("://")+3),c=b.indexOf("/");-1!=c&&(b=b.substring(0,c));a=a.substring(0,a.indexOf("://"));if("http"!==a&&"https"!==a&&"chrome-extension"!==a&&"moz-extension"!==a&&"file"!==a&&"android-app"!==a&&"chrome-search"!==a&&"chrome-untrusted"!==a&&"chrome"!==a&&"app"!==a&&"devtools"!==a)throw Error("Invalid URI scheme in origin: "+
a);c="";var d=b.indexOf(":");if(-1!=d){var e=b.substring(d+1);b=b.substring(0,d);if("http"===a&&"80"!==e||"https"===a&&"443"!==e)c=":"+e}return a+"://"+b+c}
;function fd(){function a(){e[0]=1732584193;e[1]=4023233417;e[2]=2562383102;e[3]=271733878;e[4]=3285377520;m=l=0}
function b(p){for(var q=g,r=0;64>r;r+=4)q[r/4]=p[r]<<24|p[r+1]<<16|p[r+2]<<8|p[r+3];for(r=16;80>r;r++)p=q[r-3]^q[r-8]^q[r-14]^q[r-16],q[r]=(p<<1|p>>>31)&4294967295;p=e[0];var A=e[1],B=e[2],V=e[3],Fd=e[4];for(r=0;80>r;r++){if(40>r)if(20>r){var Ya=V^A&(B^V);var kc=1518500249}else Ya=A^B^V,kc=1859775393;else 60>r?(Ya=A&B|V&(A|B),kc=2400959708):(Ya=A^B^V,kc=3395469782);Ya=((p<<5|p>>>27)&4294967295)+Ya+Fd+kc+q[r]&4294967295;Fd=V;V=B;B=(A<<30|A>>>2)&4294967295;A=p;p=Ya}e[0]=e[0]+p&4294967295;e[1]=e[1]+
A&4294967295;e[2]=e[2]+B&4294967295;e[3]=e[3]+V&4294967295;e[4]=e[4]+Fd&4294967295}
function c(p,q){if("string"===typeof p){p=unescape(encodeURIComponent(p));for(var r=[],A=0,B=p.length;A<B;++A)r.push(p.charCodeAt(A));p=r}q||(q=p.length);r=0;if(0==l)for(;r+64<q;)b(p.slice(r,r+64)),r+=64,m+=64;for(;r<q;)if(f[l++]=p[r++],m++,64==l)for(l=0,b(f);r+64<q;)b(p.slice(r,r+64)),r+=64,m+=64}
function d(){var p=[],q=8*m;56>l?c(h,56-l):c(h,64-(l-56));for(var r=63;56<=r;r--)f[r]=q&255,q>>>=8;b(f);for(r=q=0;5>r;r++)for(var A=24;0<=A;A-=8)p[q++]=e[r]>>A&255;return p}
for(var e=[],f=[],g=[],h=[128],k=1;64>k;++k)h[k]=0;var l,m;a();return{reset:a,update:c,digest:d,Ka:function(){for(var p=d(),q="",r=0;r<p.length;r++)q+="0123456789ABCDEF".charAt(Math.floor(p[r]/16))+"0123456789ABCDEF".charAt(p[r]%16);return q}}}
;function gd(a,b,c){var d=[],e=[];if(1==(Array.isArray(c)?2:1))return e=[b,a],H(d,function(h){e.push(h)}),hd(e.join(" "));
var f=[],g=[];H(c,function(h){g.push(h.key);f.push(h.value)});
c=Math.floor((new Date).getTime()/1E3);e=0==f.length?[c,b,a]:[f.join(":"),c,b,a];H(d,function(h){e.push(h)});
a=hd(e.join(" "));a=[c,a];0==g.length||a.push(g.join(""));return a.join("_")}
function hd(a){var b=fd();b.update(a);return b.Ka().toLowerCase()}
;function id(a){var b=ed(String(x.location.href)),c;(c=x.__SAPISID||x.__APISID||x.__OVERRIDE_SID)?c=!0:(c=new Ec(document),c=c.get("SAPISID")||c.get("APISID")||c.get("__Secure-3PAPISID")||c.get("SID"),c=!!c);if(c&&(c=(b=0==b.indexOf("https:")||0==b.indexOf("chrome-extension:")||0==b.indexOf("moz-extension:"))?x.__SAPISID:x.__APISID,c||(c=new Ec(document),c=c.get(b?"SAPISID":"APISID")||c.get("__Secure-3PAPISID")),c)){b=b?"SAPISIDHASH":"APISIDHASH";var d=String(x.location.href);return d&&c&&b?[b,gd(ed(d),
c,a||null)].join(" "):null}return null}
;function jd(){this.g=[];this.f=-1}
jd.prototype.set=function(a,b){b=void 0===b?!0:b;0<=a&&52>a&&0===a%1&&this.g[a]!=b&&(this.g[a]=b,this.f=-1)};
jd.prototype.get=function(a){return!!this.g[a]};
function kd(a){-1==a.f&&(a.f=ab(a.g,function(b,c,d){return c?b+Math.pow(2,d):b},0));
return a.f}
;function ld(a,b){this.h=a;this.i=b;this.g=0;this.f=null}
ld.prototype.get=function(){if(0<this.g){this.g--;var a=this.f;this.f=a.next;a.next=null}else a=this.h();return a};
function md(a,b){a.i(b);100>a.g&&(a.g++,b.next=a.f,a.f=b)}
;function nd(a){x.setTimeout(function(){throw a;},0)}
var od;
function pd(){var a=x.MessageChannel;"undefined"===typeof a&&"undefined"!==typeof window&&window.postMessage&&window.addEventListener&&!J("Presto")&&(a=function(){var e=Nc(document,"IFRAME");e.style.display="none";document.documentElement.appendChild(e);var f=e.contentWindow;e=f.document;e.open();e.close();var g="callImmediate"+Math.random(),h="file:"==f.location.protocol?"*":f.location.protocol+"//"+f.location.host;e=D(function(k){if(("*"==h||k.origin==h)&&k.data==g)this.port1.onmessage()},this);
f.addEventListener("message",e,!1);this.port1={};this.port2={postMessage:function(){f.postMessage(g,h)}}});
if("undefined"!==typeof a&&!J("Trident")&&!J("MSIE")){var b=new a,c={},d=c;b.port1.onmessage=function(){if(void 0!==c.next){c=c.next;var e=c.ua;c.ua=null;e()}};
return function(e){d.next={ua:e};d=d.next;b.port2.postMessage(0)}}return function(e){x.setTimeout(e,0)}}
;function qd(){this.g=this.f=null}
var sd=new ld(function(){return new rd},function(a){a.reset()});
qd.prototype.add=function(a,b){var c=sd.get();c.set(a,b);this.g?this.g.next=c:this.f=c;this.g=c};
qd.prototype.remove=function(){var a=null;this.f&&(a=this.f,this.f=this.f.next,this.f||(this.g=null),a.next=null);return a};
function rd(){this.next=this.scope=this.f=null}
rd.prototype.set=function(a,b){this.f=a;this.scope=b;this.next=null};
rd.prototype.reset=function(){this.next=this.scope=this.f=null};function td(a,b){ud||vd();wd||(ud(),wd=!0);xd.add(a,b)}
var ud;function vd(){if(x.Promise&&x.Promise.resolve){var a=x.Promise.resolve(void 0);ud=function(){a.then(yd)}}else ud=function(){var b=yd;
"function"!==typeof x.setImmediate||x.Window&&x.Window.prototype&&!J("Edge")&&x.Window.prototype.setImmediate==x.setImmediate?(od||(od=pd()),od(b)):x.setImmediate(b)}}
var wd=!1,xd=new qd;function yd(){for(var a;a=xd.remove();){try{a.f.call(a.scope)}catch(b){nd(b)}md(sd,a)}wd=!1}
;function zd(){this.g=-1}
;function Ad(){this.g=64;this.f=[];this.l=[];this.m=[];this.i=[];this.i[0]=128;for(var a=1;a<this.g;++a)this.i[a]=0;this.j=this.h=0;this.reset()}
G(Ad,zd);Ad.prototype.reset=function(){this.f[0]=1732584193;this.f[1]=4023233417;this.f[2]=2562383102;this.f[3]=271733878;this.f[4]=3285377520;this.j=this.h=0};
function Bd(a,b,c){c||(c=0);var d=a.m;if("string"===typeof b)for(var e=0;16>e;e++)d[e]=b.charCodeAt(c)<<24|b.charCodeAt(c+1)<<16|b.charCodeAt(c+2)<<8|b.charCodeAt(c+3),c+=4;else for(e=0;16>e;e++)d[e]=b[c]<<24|b[c+1]<<16|b[c+2]<<8|b[c+3],c+=4;for(e=16;80>e;e++){var f=d[e-3]^d[e-8]^d[e-14]^d[e-16];d[e]=(f<<1|f>>>31)&4294967295}b=a.f[0];c=a.f[1];var g=a.f[2],h=a.f[3],k=a.f[4];for(e=0;80>e;e++){if(40>e)if(20>e){f=h^c&(g^h);var l=1518500249}else f=c^g^h,l=1859775393;else 60>e?(f=c&g|h&(c|g),l=2400959708):
(f=c^g^h,l=3395469782);f=(b<<5|b>>>27)+f+k+l+d[e]&4294967295;k=h;h=g;g=(c<<30|c>>>2)&4294967295;c=b;b=f}a.f[0]=a.f[0]+b&4294967295;a.f[1]=a.f[1]+c&4294967295;a.f[2]=a.f[2]+g&4294967295;a.f[3]=a.f[3]+h&4294967295;a.f[4]=a.f[4]+k&4294967295}
Ad.prototype.update=function(a,b){if(null!=a){void 0===b&&(b=a.length);for(var c=b-this.g,d=0,e=this.l,f=this.h;d<b;){if(0==f)for(;d<=c;)Bd(this,a,d),d+=this.g;if("string"===typeof a)for(;d<b;){if(e[f]=a.charCodeAt(d),++f,++d,f==this.g){Bd(this,e);f=0;break}}else for(;d<b;)if(e[f]=a[d],++f,++d,f==this.g){Bd(this,e);f=0;break}}this.h=f;this.j+=b}};
Ad.prototype.digest=function(){var a=[],b=8*this.j;56>this.h?this.update(this.i,56-this.h):this.update(this.i,this.g-(this.h-56));for(var c=this.g-1;56<=c;c--)this.l[c]=b&255,b/=256;Bd(this,this.l);for(c=b=0;5>c;c++)for(var d=24;0<=d;d-=8)a[b]=this.f[c]>>d&255,++b;return a};var Cd="StopIteration"in x?x.StopIteration:{message:"StopIteration",stack:""};function Dd(){}
Dd.prototype.next=function(){throw Cd;};
Dd.prototype.K=function(){return this};
function Ed(a){if(a instanceof Dd)return a;if("function"==typeof a.K)return a.K(!1);if(Ma(a)){var b=0,c=new Dd;c.next=function(){for(;;){if(b>=a.length)throw Cd;if(b in a)return a[b++];b++}};
return c}throw Error("Not implemented");}
function Gd(a,b){if(Ma(a))try{H(a,b,void 0)}catch(c){if(c!==Cd)throw c;}else{a=Ed(a);try{for(;;)b.call(void 0,a.next(),void 0,a)}catch(c){if(c!==Cd)throw c;}}}
function Hd(a){if(Ma(a))return db(a);a=Ed(a);var b=[];Gd(a,function(c){b.push(c)});
return b}
;function Id(a,b){this.h={};this.f=[];this.N=this.g=0;var c=arguments.length;if(1<c){if(c%2)throw Error("Uneven number of arguments");for(var d=0;d<c;d+=2)this.set(arguments[d],arguments[d+1])}else if(a)if(a instanceof Id)for(c=Jd(a),d=0;d<c.length;d++)this.set(c[d],a.get(c[d]));else for(d in a)this.set(d,a[d])}
function Jd(a){Kd(a);return a.f.concat()}
n=Id.prototype;n.equals=function(a,b){if(this===a)return!0;if(this.g!=a.g)return!1;var c=b||Ld;Kd(this);for(var d,e=0;d=this.f[e];e++)if(!c(this.get(d),a.get(d)))return!1;return!0};
function Ld(a,b){return a===b}
n.isEmpty=function(){return 0==this.g};
n.clear=function(){this.h={};this.N=this.g=this.f.length=0};
n.remove=function(a){return Object.prototype.hasOwnProperty.call(this.h,a)?(delete this.h[a],this.g--,this.N++,this.f.length>2*this.g&&Kd(this),!0):!1};
function Kd(a){if(a.g!=a.f.length){for(var b=0,c=0;b<a.f.length;){var d=a.f[b];Object.prototype.hasOwnProperty.call(a.h,d)&&(a.f[c++]=d);b++}a.f.length=c}if(a.g!=a.f.length){var e={};for(c=b=0;b<a.f.length;)d=a.f[b],Object.prototype.hasOwnProperty.call(e,d)||(a.f[c++]=d,e[d]=1),b++;a.f.length=c}}
n.get=function(a,b){return Object.prototype.hasOwnProperty.call(this.h,a)?this.h[a]:b};
n.set=function(a,b){Object.prototype.hasOwnProperty.call(this.h,a)||(this.g++,this.f.push(a),this.N++);this.h[a]=b};
n.forEach=function(a,b){for(var c=Jd(this),d=0;d<c.length;d++){var e=c[d],f=this.get(e);a.call(b,f,e,this)}};
n.clone=function(){return new Id(this)};
n.K=function(a){Kd(this);var b=0,c=this.N,d=this,e=new Dd;e.next=function(){if(c!=d.N)throw Error("The map has changed since the iterator was created");if(b>=d.f.length)throw Cd;var f=d.f[b++];return a?f:d.h[f]};
return e};function Md(a){return"string"==typeof a.className?a.className:a.getAttribute&&a.getAttribute("class")||""}
function Nd(a,b){"string"==typeof a.className?a.className=b:a.setAttribute&&a.setAttribute("class",b)}
function Od(a,b){if(a.classList)var c=a.classList.contains(b);else c=a.classList?a.classList:Md(a).match(/\S+/g)||[],c=0<=Xa(c,b);return c}
function Pd(){var a=document.body;a.classList?a.classList.remove("inverted-hdpi"):Od(a,"inverted-hdpi")&&Nd(a,Za(a.classList?a.classList:Md(a).match(/\S+/g)||[],function(b){return"inverted-hdpi"!=b}).join(" "))}
;var Qd=!fc||9<=Number(tc),Rd;
if(Rd=fc){var Sd;if(Object.prototype.hasOwnProperty.call(qc,"9"))Sd=qc["9"];else{for(var Td=0,Ud=vb(String(pc)).split("."),Vd=vb("9").split("."),Wd=Math.max(Ud.length,Vd.length),Xd=0;0==Td&&Xd<Wd;Xd++){var Yd=Ud[Xd]||"",Zd=Vd[Xd]||"";do{var $d=/(\d*)(\D*)(.*)/.exec(Yd)||["","","",""],ae=/(\d*)(\D*)(.*)/.exec(Zd)||["","","",""];if(0==$d[0].length&&0==ae[0].length)break;Td=Eb(0==$d[1].length?0:parseInt($d[1],10),0==ae[1].length?0:parseInt(ae[1],10))||Eb(0==$d[2].length,0==ae[2].length)||Eb($d[2],ae[2]);
Yd=$d[3];Zd=ae[3]}while(0==Td)}Sd=qc["9"]=0<=Td}Rd=!Sd}var be=Rd,ce=function(){if(!x.addEventListener||!Object.defineProperty)return!1;var a=!1,b=Object.defineProperty({},"passive",{get:function(){a=!0}});
try{x.addEventListener("test",Ja,b),x.removeEventListener("test",Ja,b)}catch(c){}return a}();function de(a,b){this.type=a;this.f=this.target=b;this.defaultPrevented=this.g=!1}
de.prototype.stopPropagation=function(){this.g=!0};
de.prototype.preventDefault=function(){this.defaultPrevented=!0};function ee(a,b){de.call(this,a?a.type:"");this.relatedTarget=this.f=this.target=null;this.button=this.screenY=this.screenX=this.clientY=this.clientX=0;this.key="";this.charCode=this.keyCode=0;this.metaKey=this.shiftKey=this.altKey=this.ctrlKey=!1;this.state=null;this.pointerId=0;this.pointerType="";this.h=null;a&&this.init(a,b)}
G(ee,de);var fe={2:"touch",3:"pen",4:"mouse"};
ee.prototype.init=function(a,b){var c=this.type=a.type,d=a.changedTouches&&a.changedTouches.length?a.changedTouches[0]:null;this.target=a.target||a.srcElement;this.f=b;var e=a.relatedTarget;if(e){if(hc){a:{try{dc(e.nodeName);var f=!0;break a}catch(g){}f=!1}f||(e=null)}}else"mouseover"==c?e=a.fromElement:"mouseout"==c&&(e=a.toElement);this.relatedTarget=e;d?(this.clientX=void 0!==d.clientX?d.clientX:d.pageX,this.clientY=void 0!==d.clientY?d.clientY:d.pageY,this.screenX=d.screenX||0,this.screenY=d.screenY||
0):(this.clientX=void 0!==a.clientX?a.clientX:a.pageX,this.clientY=void 0!==a.clientY?a.clientY:a.pageY,this.screenX=a.screenX||0,this.screenY=a.screenY||0);this.button=a.button;this.keyCode=a.keyCode||0;this.key=a.key||"";this.charCode=a.charCode||("keypress"==c?a.keyCode:0);this.ctrlKey=a.ctrlKey;this.altKey=a.altKey;this.shiftKey=a.shiftKey;this.metaKey=a.metaKey;this.pointerId=a.pointerId||0;this.pointerType="string"===typeof a.pointerType?a.pointerType:fe[a.pointerType]||"";this.state=a.state;
this.h=a;a.defaultPrevented&&this.preventDefault()};
ee.prototype.stopPropagation=function(){ee.J.stopPropagation.call(this);this.h.stopPropagation?this.h.stopPropagation():this.h.cancelBubble=!0};
ee.prototype.preventDefault=function(){ee.J.preventDefault.call(this);var a=this.h;if(a.preventDefault)a.preventDefault();else if(a.returnValue=!1,be)try{if(a.ctrlKey||112<=a.keyCode&&123>=a.keyCode)a.keyCode=-1}catch(b){}};var ge="closure_listenable_"+(1E6*Math.random()|0),he=0;function ie(a,b,c,d,e){this.listener=a;this.f=null;this.src=b;this.type=c;this.capture=!!d;this.ha=e;this.key=++he;this.V=this.fa=!1}
function je(a){a.V=!0;a.listener=null;a.f=null;a.src=null;a.ha=null}
;function ke(a){this.src=a;this.listeners={};this.f=0}
ke.prototype.add=function(a,b,c,d,e){var f=a.toString();a=this.listeners[f];a||(a=this.listeners[f]=[],this.f++);var g=le(a,b,d,e);-1<g?(b=a[g],c||(b.fa=!1)):(b=new ie(b,this.src,f,!!d,e),b.fa=c,a.push(b));return b};
ke.prototype.remove=function(a,b,c,d){a=a.toString();if(!(a in this.listeners))return!1;var e=this.listeners[a];b=le(e,b,c,d);return-1<b?(je(e[b]),Array.prototype.splice.call(e,b,1),0==e.length&&(delete this.listeners[a],this.f--),!0):!1};
function me(a,b){var c=b.type;c in a.listeners&&cb(a.listeners[c],b)&&(je(b),0==a.listeners[c].length&&(delete a.listeners[c],a.f--))}
function le(a,b,c,d){for(var e=0;e<a.length;++e){var f=a[e];if(!f.V&&f.listener==b&&f.capture==!!c&&f.ha==d)return e}return-1}
;var ne="closure_lm_"+(1E6*Math.random()|0),oe={},pe=0;function qe(a,b,c,d,e){if(d&&d.once)re(a,b,c,d,e);else if(Array.isArray(b))for(var f=0;f<b.length;f++)qe(a,b[f],c,d,e);else c=se(c),a&&a[ge]?a.f.add(String(b),c,!1,C(d)?!!d.capture:!!d,e):te(a,b,c,!1,d,e)}
function te(a,b,c,d,e,f){if(!b)throw Error("Invalid event type");var g=C(e)?!!e.capture:!!e,h=ue(a);h||(a[ne]=h=new ke(a));c=h.add(b,c,d,g,f);if(!c.f){d=ve();c.f=d;d.src=a;d.listener=c;if(a.addEventListener)ce||(e=g),void 0===e&&(e=!1),a.addEventListener(b.toString(),d,e);else if(a.attachEvent)a.attachEvent(we(b.toString()),d);else if(a.addListener&&a.removeListener)a.addListener(d);else throw Error("addEventListener and attachEvent are unavailable.");pe++}}
function ve(){var a=xe,b=Qd?function(c){return a.call(b.src,b.listener,c)}:function(c){c=a.call(b.src,b.listener,c);
if(!c)return c};
return b}
function re(a,b,c,d,e){if(Array.isArray(b))for(var f=0;f<b.length;f++)re(a,b[f],c,d,e);else c=se(c),a&&a[ge]?a.f.add(String(b),c,!0,C(d)?!!d.capture:!!d,e):te(a,b,c,!0,d,e)}
function ye(a,b,c,d,e){if(Array.isArray(b))for(var f=0;f<b.length;f++)ye(a,b[f],c,d,e);else(d=C(d)?!!d.capture:!!d,c=se(c),a&&a[ge])?a.f.remove(String(b),c,d,e):a&&(a=ue(a))&&(b=a.listeners[b.toString()],a=-1,b&&(a=le(b,c,d,e)),(c=-1<a?b[a]:null)&&ze(c))}
function ze(a){if("number"!==typeof a&&a&&!a.V){var b=a.src;if(b&&b[ge])me(b.f,a);else{var c=a.type,d=a.f;b.removeEventListener?b.removeEventListener(c,d,a.capture):b.detachEvent?b.detachEvent(we(c),d):b.addListener&&b.removeListener&&b.removeListener(d);pe--;(c=ue(b))?(me(c,a),0==c.f&&(c.src=null,b[ne]=null)):je(a)}}}
function we(a){return a in oe?oe[a]:oe[a]="on"+a}
function Ae(a,b,c,d){var e=!0;if(a=ue(a))if(b=a.listeners[b.toString()])for(b=b.concat(),a=0;a<b.length;a++){var f=b[a];f&&f.capture==c&&!f.V&&(f=Be(f,d),e=e&&!1!==f)}return e}
function Be(a,b){var c=a.listener,d=a.ha||a.src;a.fa&&ze(a);return c.call(d,b)}
function xe(a,b){if(a.V)return!0;if(!Qd){var c=b||z("window.event"),d=new ee(c,this),e=!0;if(!(0>c.keyCode||void 0!=c.returnValue)){a:{var f=!1;if(0==c.keyCode)try{c.keyCode=-1;break a}catch(k){f=!0}if(f||void 0==c.returnValue)c.returnValue=!0}c=[];for(f=d.f;f;f=f.parentNode)c.push(f);f=a.type;for(var g=c.length-1;!d.g&&0<=g;g--){d.f=c[g];var h=Ae(c[g],f,!0,d);e=e&&h}for(g=0;!d.g&&g<c.length;g++)d.f=c[g],h=Ae(c[g],f,!1,d),e=e&&h}return e}return Be(a,new ee(b,this))}
function ue(a){a=a[ne];return a instanceof ke?a:null}
var Ce="__closure_events_fn_"+(1E9*Math.random()>>>0);function se(a){if("function"===typeof a)return a;a[Ce]||(a[Ce]=function(b){return a.handleEvent(b)});
return a[Ce]}
;function De(){L.call(this);this.f=new ke(this);this.j=this;this.i=null}
G(De,L);De.prototype[ge]=!0;De.prototype.addEventListener=function(a,b,c,d){qe(this,a,b,c,d)};
De.prototype.removeEventListener=function(a,b,c,d){ye(this,a,b,c,d)};
De.prototype.dispatchEvent=function(a){var b=this.i;if(b){var c=[];for(var d=1;b;b=b.i)c.push(b),++d}b=this.j;d=a.type||a;if("string"===typeof a)a=new de(a,b);else if(a instanceof de)a.target=a.target||b;else{var e=a;a=new de(d,b);pb(a,e)}e=!0;if(c)for(var f=c.length-1;!a.g&&0<=f;f--){var g=a.f=c[f];e=Ee(g,d,!0,a)&&e}a.g||(g=a.f=b,e=Ee(g,d,!0,a)&&e,a.g||(e=Ee(g,d,!1,a)&&e));if(c)for(f=0;!a.g&&f<c.length;f++)g=a.f=c[f],e=Ee(g,d,!1,a)&&e;return e};
De.prototype.u=function(){De.J.u.call(this);if(this.f){var a=this.f,b=0,c;for(c in a.listeners){for(var d=a.listeners[c],e=0;e<d.length;e++)++b,je(d[e]);delete a.listeners[c];a.f--}}this.i=null};
function Ee(a,b,c,d){b=a.f.listeners[String(b)];if(!b)return!0;b=b.concat();for(var e=!0,f=0;f<b.length;++f){var g=b[f];if(g&&!g.V&&g.capture==c){var h=g.listener,k=g.ha||g.src;g.fa&&me(a.f,g);e=!1!==h.call(k,d)&&e}}return e&&!d.defaultPrevented}
;function Fe(a){var b=[];Ge(new He,a,b);return b.join("")}
function He(){}
function Ge(a,b,c){if(null==b)c.push("null");else{if("object"==typeof b){if(Array.isArray(b)){var d=b;b=d.length;c.push("[");for(var e="",f=0;f<b;f++)c.push(e),Ge(a,d[f],c),e=",";c.push("]");return}if(b instanceof String||b instanceof Number||b instanceof Boolean)b=b.valueOf();else{c.push("{");e="";for(d in b)Object.prototype.hasOwnProperty.call(b,d)&&(f=b[d],"function"!=typeof f&&(c.push(e),Ie(d,c),c.push(":"),Ge(a,f,c),e=","));c.push("}");return}}switch(typeof b){case "string":Ie(b,c);break;case "number":c.push(isFinite(b)&&
!isNaN(b)?String(b):"null");break;case "boolean":c.push(String(b));break;case "function":c.push("null");break;default:throw Error("Unknown type: "+typeof b);}}}
var Je={'"':'\\"',"\\":"\\\\","/":"\\/","\b":"\\b","\f":"\\f","\n":"\\n","\r":"\\r","\t":"\\t","\x0B":"\\u000b"},Ke=/\uffff/.test("\uffff")?/[\\"\x00-\x1f\x7f-\uffff]/g:/[\\"\x00-\x1f\x7f-\xff]/g;function Ie(a,b){b.push('"',a.replace(Ke,function(c){var d=Je[c];d||(d="\\u"+(c.charCodeAt(0)|65536).toString(16).substr(1),Je[c]=d);return d}),'"')}
;function Le(a){if(!a)return!1;try{return!!a.$goog_Thenable}catch(b){return!1}}
;function M(a){this.f=0;this.m=void 0;this.i=this.g=this.h=null;this.j=this.l=!1;if(a!=Ja)try{var b=this;a.call(void 0,function(c){Me(b,2,c)},function(c){Me(b,3,c)})}catch(c){Me(this,3,c)}}
function Ne(){this.next=this.context=this.onRejected=this.g=this.f=null;this.h=!1}
Ne.prototype.reset=function(){this.context=this.onRejected=this.g=this.f=null;this.h=!1};
var Oe=new ld(function(){return new Ne},function(a){a.reset()});
function Pe(a,b,c){var d=Oe.get();d.g=a;d.onRejected=b;d.context=c;return d}
function Qe(a){return new M(function(b,c){c(a)})}
function Re(a,b,c){Se(a,b,c,null)||td(Sa(b,a))}
function Te(a){return new M(function(b,c){var d=a.length,e=[];if(d)for(var f=function(l,m){d--;e[l]=m;0==d&&b(e)},g=function(l){c(l)},h=0,k;h<a.length;h++)k=a[h],Re(k,Sa(f,h),g);
else b(e)})}
M.prototype.then=function(a,b,c){return Ue(this,"function"===typeof a?a:null,"function"===typeof b?b:null,c)};
M.prototype.$goog_Thenable=!0;function Ve(a,b){return Ue(a,null,b,void 0)}
M.prototype.cancel=function(a){if(0==this.f){var b=new We(a);td(function(){Xe(this,b)},this)}};
function Xe(a,b){if(0==a.f)if(a.h){var c=a.h;if(c.g){for(var d=0,e=null,f=null,g=c.g;g&&(g.h||(d++,g.f==a&&(e=g),!(e&&1<d)));g=g.next)e||(f=g);e&&(0==c.f&&1==d?Xe(c,b):(f?(d=f,d.next==c.i&&(c.i=d),d.next=d.next.next):Ye(c),Ze(c,e,3,b)))}a.h=null}else Me(a,3,b)}
function $e(a,b){a.g||2!=a.f&&3!=a.f||af(a);a.i?a.i.next=b:a.g=b;a.i=b}
function Ue(a,b,c,d){var e=Pe(null,null,null);e.f=new M(function(f,g){e.g=b?function(h){try{var k=b.call(d,h);f(k)}catch(l){g(l)}}:f;
e.onRejected=c?function(h){try{var k=c.call(d,h);void 0===k&&h instanceof We?g(h):f(k)}catch(l){g(l)}}:g});
e.f.h=a;$e(a,e);return e.f}
M.prototype.o=function(a){this.f=0;Me(this,2,a)};
M.prototype.B=function(a){this.f=0;Me(this,3,a)};
function Me(a,b,c){0==a.f&&(a===c&&(b=3,c=new TypeError("Promise cannot resolve to itself")),a.f=1,Se(c,a.o,a.B,a)||(a.m=c,a.f=b,a.h=null,af(a),3!=b||c instanceof We||bf(a,c)))}
function Se(a,b,c,d){if(a instanceof M)return $e(a,Pe(b||Ja,c||null,d)),!0;if(Le(a))return a.then(b,c,d),!0;if(C(a))try{var e=a.then;if("function"===typeof e)return cf(a,e,b,c,d),!0}catch(f){return c.call(d,f),!0}return!1}
function cf(a,b,c,d,e){function f(k){h||(h=!0,d.call(e,k))}
function g(k){h||(h=!0,c.call(e,k))}
var h=!1;try{b.call(a,g,f)}catch(k){f(k)}}
function af(a){a.l||(a.l=!0,td(a.A,a))}
function Ye(a){var b=null;a.g&&(b=a.g,a.g=b.next,b.next=null);a.g||(a.i=null);return b}
M.prototype.A=function(){for(var a;a=Ye(this);)Ze(this,a,this.f,this.m);this.l=!1};
function Ze(a,b,c,d){if(3==c&&b.onRejected&&!b.h)for(;a&&a.j;a=a.h)a.j=!1;if(b.f)b.f.h=null,df(b,c,d);else try{b.h?b.g.call(b.context):df(b,c,d)}catch(e){ef.call(null,e)}md(Oe,b)}
function df(a,b,c){2==b?a.g.call(a.context,c):a.onRejected&&a.onRejected.call(a.context,c)}
function bf(a,b){a.j=!0;td(function(){a.j&&ef.call(null,b)})}
var ef=nd;function We(a){Ua.call(this,a)}
G(We,Ua);We.prototype.name="cancel";function N(a){L.call(this);this.l=1;this.i=[];this.j=0;this.f=[];this.h={};this.m=!!a}
G(N,L);n=N.prototype;n.subscribe=function(a,b,c){var d=this.h[a];d||(d=this.h[a]=[]);var e=this.l;this.f[e]=a;this.f[e+1]=b;this.f[e+2]=c;this.l=e+3;d.push(e);return e};
function ff(a,b,c,d){if(b=a.h[b]){var e=a.f;(b=bb(b,function(f){return e[f+1]==c&&e[f+2]==d}))&&a.W(b)}}
n.W=function(a){var b=this.f[a];if(b){var c=this.h[b];0!=this.j?(this.i.push(a),this.f[a+1]=Ja):(c&&cb(c,a),delete this.f[a],delete this.f[a+1],delete this.f[a+2])}return!!b};
n.O=function(a,b){var c=this.h[a];if(c){for(var d=Array(arguments.length-1),e=1,f=arguments.length;e<f;e++)d[e-1]=arguments[e];if(this.m)for(e=0;e<c.length;e++){var g=c[e];gf(this.f[g+1],this.f[g+2],d)}else{this.j++;try{for(e=0,f=c.length;e<f;e++)g=c[e],this.f[g+1].apply(this.f[g+2],d)}finally{if(this.j--,0<this.i.length&&0==this.j)for(;c=this.i.pop();)this.W(c)}}return 0!=e}return!1};
function gf(a,b,c){td(function(){a.apply(b,c)})}
n.clear=function(a){if(a){var b=this.h[a];b&&(H(b,this.W,this),delete this.h[a])}else this.f.length=0,this.h={}};
n.u=function(){N.J.u.call(this);this.clear();this.i.length=0};function hf(a){this.f=a}
hf.prototype.set=function(a,b){void 0===b?this.f.remove(a):this.f.set(a,Fe(b))};
hf.prototype.get=function(a){try{var b=this.f.get(a)}catch(c){return}if(null!==b)try{return JSON.parse(b)}catch(c){throw"Storage: Invalid value was encountered";}};
hf.prototype.remove=function(a){this.f.remove(a)};function jf(a){this.f=a}
G(jf,hf);function kf(a){this.data=a}
function lf(a){return void 0===a||a instanceof kf?a:new kf(a)}
jf.prototype.set=function(a,b){jf.J.set.call(this,a,lf(b))};
jf.prototype.g=function(a){a=jf.J.get.call(this,a);if(void 0===a||a instanceof Object)return a;throw"Storage: Invalid value was encountered";};
jf.prototype.get=function(a){if(a=this.g(a)){if(a=a.data,void 0===a)throw"Storage: Invalid value was encountered";}else a=void 0;return a};function mf(a){this.f=a}
G(mf,jf);mf.prototype.set=function(a,b,c){if(b=lf(b)){if(c){if(c<E()){mf.prototype.remove.call(this,a);return}b.expiration=c}b.creation=E()}mf.J.set.call(this,a,b)};
mf.prototype.g=function(a){var b=mf.J.g.call(this,a);if(b){var c=b.creation,d=b.expiration;if(d&&d<E()||c&&c>E())mf.prototype.remove.call(this,a);else return b}};function nf(){}
;function of(){}
G(of,nf);of.prototype.clear=function(){var a=Hd(this.K(!0)),b=this;H(a,function(c){b.remove(c)})};function pf(a){this.f=a}
G(pf,of);n=pf.prototype;n.isAvailable=function(){if(!this.f)return!1;try{return this.f.setItem("__sak","1"),this.f.removeItem("__sak"),!0}catch(a){return!1}};
n.set=function(a,b){try{this.f.setItem(a,b)}catch(c){if(0==this.f.length)throw"Storage mechanism: Storage disabled";throw"Storage mechanism: Quota exceeded";}};
n.get=function(a){a=this.f.getItem(a);if("string"!==typeof a&&null!==a)throw"Storage mechanism: Invalid value was encountered";return a};
n.remove=function(a){this.f.removeItem(a)};
n.K=function(a){var b=0,c=this.f,d=new Dd;d.next=function(){if(b>=c.length)throw Cd;var e=c.key(b++);if(a)return e;e=c.getItem(e);if("string"!==typeof e)throw"Storage mechanism: Invalid value was encountered";return e};
return d};
n.clear=function(){this.f.clear()};
n.key=function(a){return this.f.key(a)};function qf(){var a=null;try{a=window.localStorage||null}catch(b){}this.f=a}
G(qf,pf);function rf(a,b){this.g=a;this.f=null;if(fc&&!(9<=Number(tc))){sf||(sf=new Id);this.f=sf.get(a);this.f||(b?this.f=document.getElementById(b):(this.f=document.createElement("userdata"),this.f.addBehavior("#default#userData"),document.body.appendChild(this.f)),sf.set(a,this.f));try{this.f.load(this.g)}catch(c){this.f=null}}}
G(rf,of);var tf={".":".2E","!":".21","~":".7E","*":".2A","'":".27","(":".28",")":".29","%":"."},sf=null;function uf(a){return"_"+encodeURIComponent(a).replace(/[.!~*'()%]/g,function(b){return tf[b]})}
n=rf.prototype;n.isAvailable=function(){return!!this.f};
n.set=function(a,b){this.f.setAttribute(uf(a),b);vf(this)};
n.get=function(a){a=this.f.getAttribute(uf(a));if("string"!==typeof a&&null!==a)throw"Storage mechanism: Invalid value was encountered";return a};
n.remove=function(a){this.f.removeAttribute(uf(a));vf(this)};
n.K=function(a){var b=0,c=this.f.XMLDocument.documentElement.attributes,d=new Dd;d.next=function(){if(b>=c.length)throw Cd;var e=c[b++];if(a)return decodeURIComponent(e.nodeName.replace(/\./g,"%")).substr(1);e=e.nodeValue;if("string"!==typeof e)throw"Storage mechanism: Invalid value was encountered";return e};
return d};
n.clear=function(){for(var a=this.f.XMLDocument.documentElement,b=a.attributes.length;0<b;b--)a.removeAttribute(a.attributes[b-1].nodeName);vf(this)};
function vf(a){try{a.f.save(a.g)}catch(b){throw"Storage mechanism: Quota exceeded";}}
;function wf(a,b){this.g=a;this.f=b+"::"}
G(wf,of);wf.prototype.set=function(a,b){this.g.set(this.f+a,b)};
wf.prototype.get=function(a){return this.g.get(this.f+a)};
wf.prototype.remove=function(a){this.g.remove(this.f+a)};
wf.prototype.K=function(a){var b=this.g.K(!0),c=this,d=new Dd;d.next=function(){for(var e=b.next();e.substr(0,c.f.length)!=c.f;)e=b.next();return a?e.substr(c.f.length):c.g.get(e)};
return d};function xf(a,b){1<b.length?a[b[0]]=b[1]:1===b.length&&Object.assign(a,b[0])}
;var yf=window.yt&&window.yt.config_||window.ytcfg&&window.ytcfg.data_||{};y("yt.config_",yf,void 0);function O(a){xf(yf,arguments)}
function P(a,b){return a in yf?yf[a]:b}
function zf(){return P("PLAYER_CONFIG",{})}
;var Af=[];function Bf(a){Af.forEach(function(b){return b(a)})}
function Cf(a){return a&&window.yterr?function(){try{return a.apply(this,arguments)}catch(b){Df(b),Bf(b)}}:a}
function Df(a){var b=z("yt.logging.errors.log");b?b(a,"ERROR",void 0,void 0,void 0):(b=P("ERRORS",[]),b.push([a,"ERROR",void 0,void 0,void 0]),O("ERRORS",b))}
function Ef(a){var b=z("yt.logging.errors.log");b?b(a,"WARNING",void 0,void 0,void 0):(b=P("ERRORS",[]),b.push([a,"WARNING",void 0,void 0,void 0]),O("ERRORS",b))}
;var Ff=window.yt&&window.yt.msgs_||window.ytcfg&&window.ytcfg.msgs||{};y("yt.msgs_",Ff,void 0);function Gf(a){xf(Ff,arguments)}
;function Hf(a,b,c,d){Fc.set(""+a,b,{ya:c,path:"/",domain:void 0===d?"youtube.com":d,secure:!1})}
;function Q(a){a=If(a);return"string"===typeof a&&"false"===a?!1:!!a}
function Jf(a,b){var c=If(a);return void 0===c&&void 0!==b?b:Number(c||0)}
function If(a){var b=P("EXPERIMENTS_FORCED_FLAGS",{});return void 0!==b[a]?b[a]:P("EXPERIMENT_FLAGS",{})[a]}
;function Kf(a){a&&(a.dataset?a.dataset[Lf("loaded")]="true":a.setAttribute("data-loaded","true"))}
function Mf(a,b){return a?a.dataset?a.dataset[Lf(b)]:a.getAttribute("data-"+b):null}
var Nf={};function Lf(a){return Nf[a]||(Nf[a]=String(a).replace(/\-([a-z])/g,function(b,c){return c.toUpperCase()}))}
;function R(a,b){"function"===typeof a&&(a=Cf(a));return window.setTimeout(a,b)}
function Of(a){window.clearTimeout(a)}
;var Pf=x.ytPubsubPubsubInstance||new N,Qf=x.ytPubsubPubsubSubscribedKeys||{},Rf=x.ytPubsubPubsubTopicToKeys||{},Sf=x.ytPubsubPubsubIsSynchronous||{};function Tf(a,b){var c=Uf();if(c&&b){var d=c.subscribe(a,function(){var e=arguments;var f=function(){Qf[d]&&b.apply&&"function"==typeof b.apply&&b.apply(window,e)};
try{Sf[a]?f():R(f,0)}catch(g){Df(g)}},void 0);
Qf[d]=!0;Rf[a]||(Rf[a]=[]);Rf[a].push(d);return d}return 0}
function Vf(a){var b=Uf();b&&("number"===typeof a?a=[a]:"string"===typeof a&&(a=[parseInt(a,10)]),H(a,function(c){b.unsubscribeByKey(c);delete Qf[c]}))}
function Wf(a,b){var c=Uf();c&&c.publish.apply(c,arguments)}
function Xf(a){var b=Uf();if(b)if(b.clear(a),a)Yf(a);else for(var c in Rf)Yf(c)}
function Uf(){return x.ytPubsubPubsubInstance}
function Yf(a){Rf[a]&&(a=Rf[a],H(a,function(b){Qf[b]&&delete Qf[b]}),a.length=0)}
N.prototype.subscribe=N.prototype.subscribe;N.prototype.unsubscribeByKey=N.prototype.W;N.prototype.publish=N.prototype.O;N.prototype.clear=N.prototype.clear;y("ytPubsubPubsubInstance",Pf,void 0);y("ytPubsubPubsubTopicToKeys",Rf,void 0);y("ytPubsubPubsubIsSynchronous",Sf,void 0);y("ytPubsubPubsubSubscribedKeys",Qf,void 0);var Zf=/\.vflset|-vfl[a-zA-Z0-9_+=-]+/,$f=/-[a-zA-Z]{2,3}_[a-zA-Z]{2,3}(?=(\/|$))/;function ag(a,b,c){c=void 0===c?null:c;if(window.spf&&spf.script){c="";if(a){var d=a.indexOf("jsbin/"),e=a.lastIndexOf(".js"),f=d+6;-1<d&&-1<e&&e>f&&(c=a.substring(f,e),c=c.replace(Zf,""),c=c.replace($f,""),c=c.replace("debug-",""),c=c.replace("tracing-",""))}spf.script.load(a,c,b)}else bg(a,b,c)}
function bg(a,b,c){c=void 0===c?null:c;var d=cg(a),e=document.getElementById(d),f=e&&Mf(e,"loaded"),g=e&&!f;f?b&&b():(b&&(f=Tf(d,b),b=""+Na(b),dg[b]=f),g||(e=eg(a,d,function(){Mf(e,"loaded")||(Kf(e),Wf(d),R(Sa(Xf,d),0))},c)))}
function eg(a,b,c,d){d=void 0===d?null:d;var e=Nc(document,"SCRIPT");e.id=b;e.onload=function(){c&&setTimeout(c,0)};
e.onreadystatechange=function(){switch(e.readyState){case "loaded":case "complete":e.onload()}};
d&&e.setAttribute("nonce",d);Tb(e,ad(a));a=document.getElementsByTagName("head")[0]||document.body;a.insertBefore(e,a.firstChild);return e}
function fg(a){a=cg(a);var b=document.getElementById(a);b&&(Xf(a),b.parentNode.removeChild(b))}
function gg(a,b){if(a&&b){var c=""+Na(b);(c=dg[c])&&Vf(c)}}
function cg(a){var b=document.createElement("a");Sb(b,a);a=b.href.replace(/^[a-zA-Z]+:\/\//,"//");return"js-"+Vb(a)}
var dg={};function hg(){}
function ig(a,b){return jg(a,1,b)}
;function kg(){}
v(kg,hg);function jg(a,b,c){isNaN(c)&&(c=void 0);var d=z("yt.scheduler.instance.addJob");return d?d(a,b,c):void 0===c?(a(),NaN):R(a,c||0)}
kg.prototype.start=function(){var a=z("yt.scheduler.instance.start");a&&a()};
kg.prototype.pause=function(){var a=z("yt.scheduler.instance.pause");a&&a()};
Ka(kg);kg.getInstance();var lg=[],mg=!1;function ng(){if(!Q("disable_ad_status_on_html5_clients")&&(!Q("condition_ad_status_fetch_on_consent_cookie_html5_clients")||Fc.get("CONSENT","").startsWith("YES+"))&&"1"!=gb(zf(),"args","privembed")){var a=function(){mg=!0;"google_ad_status"in window?O("DCLKSTAT",1):O("DCLKSTAT",2)};
try{ag("//static.doubleclick.net/instream/ad_status.js",a)}catch(b){}lg.push(ig(function(){mg||"google_ad_status"in window||(gg("//static.doubleclick.net/instream/ad_status.js",a),mg=!0,O("DCLKSTAT",3))},5E3))}}
function og(){return parseInt(P("DCLKSTAT",0),10)}
;var pg=0;y("ytDomDomGetNextId",z("ytDomDomGetNextId")||function(){return++pg},void 0);var qg={stopImmediatePropagation:1,stopPropagation:1,preventMouseEvent:1,preventManipulation:1,preventDefault:1,layerX:1,layerY:1,screenX:1,screenY:1,scale:1,rotation:1,webkitMovementX:1,webkitMovementY:1};
function rg(a){this.type="";this.state=this.source=this.data=this.currentTarget=this.relatedTarget=this.target=null;this.charCode=this.keyCode=0;this.metaKey=this.shiftKey=this.ctrlKey=this.altKey=!1;this.clientY=this.clientX=0;this.changedTouches=this.touches=null;try{if(a=a||window.event){this.event=a;for(var b in a)b in qg||(this[b]=a[b]);var c=a.target||a.srcElement;c&&3==c.nodeType&&(c=c.parentNode);this.target=c;var d=a.relatedTarget;if(d)try{d=d.nodeName?d:null}catch(e){d=null}else"mouseover"==
this.type?d=a.fromElement:"mouseout"==this.type&&(d=a.toElement);this.relatedTarget=d;this.clientX=void 0!=a.clientX?a.clientX:a.pageX;this.clientY=void 0!=a.clientY?a.clientY:a.pageY;this.keyCode=a.keyCode?a.keyCode:a.which;this.charCode=a.charCode||("keypress"==this.type?this.keyCode:0);this.altKey=a.altKey;this.ctrlKey=a.ctrlKey;this.shiftKey=a.shiftKey;this.metaKey=a.metaKey;this.f=a.pageX;this.g=a.pageY}}catch(e){}}
function sg(a){if(document.body&&document.documentElement){var b=document.body.scrollTop+document.documentElement.scrollTop;a.f=a.clientX+(document.body.scrollLeft+document.documentElement.scrollLeft);a.g=a.clientY+b}}
rg.prototype.preventDefault=function(){this.event&&(this.event.returnValue=!1,this.event.preventDefault&&this.event.preventDefault())};
rg.prototype.stopPropagation=function(){this.event&&(this.event.cancelBubble=!0,this.event.stopPropagation&&this.event.stopPropagation())};
rg.prototype.stopImmediatePropagation=function(){this.event&&(this.event.cancelBubble=!0,this.event.stopImmediatePropagation&&this.event.stopImmediatePropagation())};var ib=x.ytEventsEventsListeners||{};y("ytEventsEventsListeners",ib,void 0);var tg=x.ytEventsEventsCounter||{count:0};y("ytEventsEventsCounter",tg,void 0);
function ug(a,b,c,d){d=void 0===d?{}:d;a.addEventListener&&("mouseenter"!=b||"onmouseenter"in document?"mouseleave"!=b||"onmouseenter"in document?"mousewheel"==b&&"MozBoxSizing"in document.documentElement.style&&(b="MozMousePixelScroll"):b="mouseout":b="mouseover");return hb(function(e){var f="boolean"===typeof e[4]&&e[4]==!!d,g=C(e[4])&&C(d)&&lb(e[4],d);return!!e.length&&e[0]==a&&e[1]==b&&e[2]==c&&(f||g)})}
var vg=Wa(function(){var a=!1;try{var b=Object.defineProperty({},"capture",{get:function(){a=!0}});
window.addEventListener("test",null,b)}catch(c){}return a});
function wg(a,b,c,d){d=void 0===d?{}:d;if(!a||!a.addEventListener&&!a.attachEvent)return"";var e=ug(a,b,c,d);if(e)return e;e=++tg.count+"";var f=!("mouseenter"!=b&&"mouseleave"!=b||!a.addEventListener||"onmouseenter"in document);var g=f?function(h){h=new rg(h);if(!Pc(h.relatedTarget,function(k){return k==a}))return h.currentTarget=a,h.type=b,c.call(a,h)}:function(h){h=new rg(h);
h.currentTarget=a;return c.call(a,h)};
g=Cf(g);a.addEventListener?("mouseenter"==b&&f?b="mouseover":"mouseleave"==b&&f?b="mouseout":"mousewheel"==b&&"MozBoxSizing"in document.documentElement.style&&(b="MozMousePixelScroll"),vg()||"boolean"===typeof d?a.addEventListener(b,g,d):a.addEventListener(b,g,!!d.capture)):a.attachEvent("on"+b,g);ib[e]=[a,b,c,g,d];return e}
function xg(a){a&&("string"==typeof a&&(a=[a]),H(a,function(b){if(b in ib){var c=ib[b],d=c[0],e=c[1],f=c[3];c=c[4];d.removeEventListener?vg()||"boolean"===typeof c?d.removeEventListener(e,f,c):d.removeEventListener(e,f,!!c.capture):d.detachEvent&&d.detachEvent("on"+e,f);delete ib[b]}}))}
;var yg=window.ytcsi&&window.ytcsi.now?window.ytcsi.now:window.performance&&window.performance.timing&&window.performance.now&&window.performance.timing.navigationStart?function(){return window.performance.timing.navigationStart+window.performance.now()}:function(){return(new Date).getTime()};function zg(a){this.o=a;this.f=null;this.j=0;this.m=null;this.l=0;this.h=[];for(a=0;4>a;a++)this.h.push(0);this.i=0;this.G=wg(window,"mousemove",D(this.H,this));a=D(this.B,this);"function"===typeof a&&(a=Cf(a));this.I=window.setInterval(a,25)}
G(zg,L);zg.prototype.H=function(a){void 0===a.f&&sg(a);var b=a.f;void 0===a.g&&sg(a);this.f=new Hc(b,a.g)};
zg.prototype.B=function(){if(this.f){var a=yg();if(0!=this.j){var b=this.m,c=this.f,d=b.x-c.x;b=b.y-c.y;d=Math.sqrt(d*d+b*b)/(a-this.j);this.h[this.i]=.5<Math.abs((d-this.l)/this.l)?1:0;for(c=b=0;4>c;c++)b+=this.h[c]||0;3<=b&&this.o();this.l=d}this.j=a;this.m=this.f;this.i=(this.i+1)%4}};
zg.prototype.u=function(){window.clearInterval(this.I);xg(this.G)};var Ag={};
function Bg(a){var b=void 0===a?{}:a;a=void 0===b.Ra?!0:b.Ra;b=void 0===b.gb?!1:b.gb;if(null==z("_lact",window)){var c=parseInt(P("LACT"),10);c=isFinite(c)?E()-Math.max(c,0):-1;y("_lact",c,window);y("_fact",c,window);-1==c&&Cg();wg(document,"keydown",Cg);wg(document,"keyup",Cg);wg(document,"mousedown",Cg);wg(document,"mouseup",Cg);a&&(b?wg(window,"touchmove",function(){Dg("touchmove",200)},{passive:!0}):(wg(window,"resize",function(){Dg("resize",200)}),wg(window,"scroll",function(){Dg("scroll",200)})));
new zg(function(){Dg("mouse",100)});
wg(document,"touchstart",Cg,{passive:!0});wg(document,"touchend",Cg,{passive:!0})}}
function Dg(a,b){Ag[a]||(Ag[a]=!0,ig(function(){Cg();Ag[a]=!1},b))}
function Cg(){null==z("_lact",window)&&Bg();var a=E();y("_lact",a,window);-1==z("_fact",window)&&y("_fact",a,window);(a=z("ytglobal.ytUtilActivityCallback_"))&&a()}
function Eg(){var a=z("_lact",window),b;null==a?b=-1:b=Math.max(E()-a,0);return b}
;var Fg=window,S=Fg.ytcsi&&Fg.ytcsi.now?Fg.ytcsi.now:Fg.performance&&Fg.performance.timing&&Fg.performance.now&&Fg.performance.timing.navigationStart?function(){return Fg.performance.timing.navigationStart+Fg.performance.now()}:function(){return(new Date).getTime()};var Gg=Jf("initial_gel_batch_timeout",1E3),Hg=Math.pow(2,16)-1,Ig=null,Jg=0,Kg=void 0,Lg=0,Mg=0,Ng=0,Og=!0,Pg=x.ytLoggingTransportGELQueue_||new Map;y("ytLoggingTransportGELQueue_",Pg,void 0);var Qg=x.ytLoggingTransportTokensToCttTargetIds_||{};y("ytLoggingTransportTokensToCttTargetIds_",Qg,void 0);function Rg(a){a=void 0===a?!1:a;return new M(function(b){Of(Lg);Of(Mg);Mg=0;Kg&&Kg.isReady()?(Sg(b,a),Pg.clear()):(Tg(),b())})}
function Tg(){Q("web_gel_timeout_cap")&&!Mg&&(Mg=R(Rg,6E4));Of(Lg);var a=P("LOGGING_BATCH_TIMEOUT",Jf("web_gel_debounce_ms",1E4));Q("shorten_initial_gel_batch_timeout")&&Og&&(a=Gg);Lg=R(Rg,a)}
function Sg(a,b){var c=Kg;b=void 0===b?!1:b;for(var d=Math.round(S()),e=Pg.size,f=u(Pg),g=f.next();!g.done;g=f.next()){var h=u(g.value);g=h.next().value;var k=h.next().value;h=nb({context:Ug(c.F||Vg())});h.events=k;(k=Qg[g])&&Wg(h,g,k);delete Qg[g];Xg(h,d);Yg(c,"log_event",h,{retry:!0,onSuccess:function(){e--;e||a();Jg=Math.round(S()-d)},
onError:function(){e--;e||a()},
tb:b});Og=!1}}
function Xg(a,b){a.requestTimeMs=String(b);Q("unsplit_gel_payloads_in_logs")&&(a.unsplitGelPayloadsInLogs=!0);var c=P("EVENT_ID",void 0);if(c){var d=P("BATCH_CLIENT_COUNTER",void 0)||0;!d&&Q("web_client_counter_random_seed")&&(d=Math.floor(Math.random()*Hg/2));d++;d>Hg&&(d=1);O("BATCH_CLIENT_COUNTER",d);c={serializedEventId:c,clientCounter:String(d)};a.serializedClientEventId=c;Ig&&Jg&&Q("log_gel_rtt_web")&&(a.previousBatchInfo={serializedClientEventId:Ig,roundtripMs:String(Jg)});Ig=c;Jg=0}}
function Wg(a,b,c){if(c.videoId)var d="VIDEO";else if(c.playlistId)d="PLAYLIST";else return;a.credentialTransferTokenTargetId=c;a.context=a.context||{};a.context.user=a.context.user||{};a.context.user.credentialTransferTokens=[{token:b,scope:d}]}
;var Zg=x.ytLoggingGelSequenceIdObj_||{};y("ytLoggingGelSequenceIdObj_",Zg,void 0);
function $g(a,b,c,d){d=void 0===d?{}:d;var e={};e.eventTimeMs=Math.round(d.timestamp||S());e[a]=b;a=Eg();e.context={lastActivityMs:String(d.timestamp||!isFinite(a)?-1:a)};Q("log_sequence_info_on_gel_web")&&d.M&&(a=e.context,b=d.M,Zg[b]=b in Zg?Zg[b]+1:0,a.sequence={index:Zg[b],groupKey:b},d.La&&delete Zg[d.M]);d=d.L;a="";d&&(a={},d.videoId?a.videoId=d.videoId:d.playlistId&&(a.playlistId=d.playlistId),Qg[d.token]=a,a=d.token);d=Pg.get(a)||[];Pg.set(a,d);d.push(e);c&&(Kg=new c);c=Jf("web_logging_max_batch")||
100;e=S();d.length>=c?Rg(!0):10<=e-Ng&&(Tg(),Ng=e)}
;function ah(){var a=bh;z("yt.ads.biscotti.getId_")||y("yt.ads.biscotti.getId_",a,void 0)}
function ch(a){y("yt.ads.biscotti.lastId_",a,void 0)}
;var dh={q:!0,search_query:!0};function eh(a){for(var b=a.split("&"),c={},d=0,e=b.length;d<e;d++){var f=b[d].split("=");if(1==f.length&&f[0]||2==f.length)try{var g=decodeURIComponent((f[0]||"").replace(/\+/g," ")),h=decodeURIComponent((f[1]||"").replace(/\+/g," "));g in c?Array.isArray(c[g])?eb(c[g],h):c[g]=[c[g],h]:c[g]=h}catch(k){dh.hasOwnProperty(f[0])||(k.args=[{key:f[0],value:f[1],query:a}],Df(k))}}return c}
function fh(a){var b=[];fb(a,function(c,d){var e=encodeURIComponent(String(d)),f;Array.isArray(c)?f=c:f=[c];H(f,function(g){""==g?b.push(e):b.push(e+"="+encodeURIComponent(String(g)))})});
return b.join("&")}
function gh(a){"?"==a.charAt(0)&&(a=a.substr(1));return eh(a)}
function hh(a,b,c){var d=a.split("#",2);a=d[0];d=1<d.length?"#"+d[1]:"";var e=a.split("?",2);a=e[0];e=gh(e[1]||"");for(var f in b)!c&&null!==e&&f in e||(e[f]=b[f]);return ac(a,e)+d}
;function ih(a){var b=jh;a=void 0===a?z("yt.ads.biscotti.lastId_")||"":a;b=Object.assign(kh(b),lh(b));b.ca_type="image";a&&(b.bid=a);return b}
function kh(a){var b={};b.dt=dd;b.flash="0";a:{try{var c=a.f.top.location.href}catch(f){a=2;break a}a=c?c===a.g.location.href?0:1:2}b=(b.frm=a,b);b.u_tz=-(new Date).getTimezoneOffset();var d=void 0===d?K:d;try{var e=d.history.length}catch(f){e=0}b.u_his=e;b.u_java=!!K.navigator&&"unknown"!==typeof K.navigator.javaEnabled&&!!K.navigator.javaEnabled&&K.navigator.javaEnabled();K.screen&&(b.u_h=K.screen.height,b.u_w=K.screen.width,b.u_ah=K.screen.availHeight,b.u_aw=K.screen.availWidth,b.u_cd=K.screen.colorDepth);
K.navigator&&K.navigator.plugins&&(b.u_nplug=K.navigator.plugins.length);K.navigator&&K.navigator.mimeTypes&&(b.u_nmime=K.navigator.mimeTypes.length);return b}
function lh(a){var b=a.f;try{var c=b.screenX;var d=b.screenY}catch(p){}try{var e=b.outerWidth;var f=b.outerHeight}catch(p){}try{var g=b.innerWidth;var h=b.innerHeight}catch(p){}b=[b.screenLeft,b.screenTop,c,d,b.screen?b.screen.availWidth:void 0,b.screen?b.screen.availTop:void 0,e,f,g,h];c=a.f.top;try{var k=(c||window).document,l="CSS1Compat"==k.compatMode?k.documentElement:k.body;var m=(new Ic(l.clientWidth,l.clientHeight)).round()}catch(p){m=new Ic(-12245933,-12245933)}k=m;m={};l=new jd;x.SVGElement&&
x.document.createElementNS&&l.set(0);c=Uc();c["allow-top-navigation-by-user-activation"]&&l.set(1);c["allow-popups-to-escape-sandbox"]&&l.set(2);x.crypto&&x.crypto.subtle&&l.set(3);x.TextDecoder&&x.TextEncoder&&l.set(4);l=kd(l);m.bc=l;m.bih=k.height;m.biw=k.width;m.brdim=b.join();a=a.g;return m.vis={visible:1,hidden:2,prerender:3,preview:4,unloaded:5}[a.visibilityState||a.webkitVisibilityState||a.mozVisibilityState||""]||0,m.wgl=!!K.WebGLRenderingContext,m}
var jh=new function(){var a=window.document;this.f=window;this.g=a};
y("yt.ads_.signals_.getAdSignalsString",function(a){return fh(ih(a))},void 0);var mh="XMLHttpRequest"in x?function(){return new XMLHttpRequest}:null;
function nh(){if(!mh)return null;var a=mh();return"open"in a?a:null}
function oh(a){switch(a&&"status"in a?a.status:-1){case 200:case 201:case 202:case 203:case 204:case 205:case 206:case 304:return!0;default:return!1}}
;var ph={Authorization:"AUTHORIZATION","X-Goog-Visitor-Id":"SANDBOXED_VISITOR_ID","X-YouTube-Client-Name":"INNERTUBE_CONTEXT_CLIENT_NAME","X-YouTube-Client-Version":"INNERTUBE_CONTEXT_CLIENT_VERSION","X-YouTube-Delegation-Context":"INNERTUBE_CONTEXT_SERIALIZED_DELEGATION_CONTEXT","X-YouTube-Device":"DEVICE","X-Youtube-Identity-Token":"ID_TOKEN","X-YouTube-Page-CL":"PAGE_CL","X-YouTube-Page-Label":"PAGE_BUILD_LABEL","X-YouTube-Variants-Checksum":"VARIANTS_CHECKSUM"},qh="app debugcss debugjs expflag force_ad_params force_viral_ad_response_params forced_experiments innertube_snapshots innertube_goldens internalcountrycode internalipoverride absolute_experiments conditional_experiments sbb sr_bns_address client_dev_root_url".split(" "),
rh=!1;
function sh(a,b){b=void 0===b?{}:b;if(!c)var c=window.location.href;var d=a.match(Wb)[1]||null,e=Yb(a);d&&e?(d=c,c=a.match(Wb),d=d.match(Wb),c=c[3]==d[3]&&c[1]==d[1]&&c[4]==d[4]):c=e?Yb(c)==e&&(Number(c.match(Wb)[4]||null)||null)==(Number(a.match(Wb)[4]||null)||null):!0;d=Q("web_ajax_ignore_global_headers_if_set");for(var f in ph)e=P(ph[f]),!e||!c&&Yb(a)||d&&void 0!==b[f]||(b[f]=e);if(c||!Yb(a))b["X-YouTube-Utc-Offset"]=String(-(new Date).getTimezoneOffset());(c||!Yb(a))&&(f="undefined"!=typeof Intl?(new Intl.DateTimeFormat).resolvedOptions().timeZone:
null)&&(b["X-YouTube-Time-Zone"]=f);if(c||!Yb(a))b["X-YouTube-Ad-Signals"]=fh(ih(void 0));return b}
function th(a){var b=window.location.search,c=Yb(a),d=Xb(a.match(Wb)[5]||null);d=(c=c&&(c.endsWith("youtube.com")||c.endsWith("youtube-nocookie.com")))&&d&&d.startsWith("/api/");if(!c||d)return a;var e=gh(b),f={};H(qh,function(g){e[g]&&(f[g]=e[g])});
return hh(a,f||{},!1)}
function uh(a,b){if(window.fetch&&"XML"!=b.format){var c={method:b.method||"GET",credentials:"same-origin"};b.headers&&(c.headers=b.headers);a=vh(a,b);var d=wh(a,b);d&&(c.body=d);b.withCredentials&&(c.credentials="include");var e=!1,f;fetch(a,c).then(function(g){if(!e){e=!0;f&&Of(f);var h=g.ok,k=function(l){l=l||{};var m=b.context||x;h?b.onSuccess&&b.onSuccess.call(m,l,g):b.onError&&b.onError.call(m,l,g);b.ra&&b.ra.call(m,l,g)};
"JSON"==(b.format||"JSON")&&(h||400<=g.status&&500>g.status)?g.json().then(k,function(){k(null)}):k(null)}});
b.Ca&&0<b.timeout&&(f=R(function(){e||(e=!0,Of(f),b.Ca.call(b.context||x))},b.timeout))}else xh(a,b)}
function xh(a,b){var c=b.format||"JSON";a=vh(a,b);var d=wh(a,b),e=!1,f=yh(a,function(k){if(!e){e=!0;h&&Of(h);var l=oh(k),m=null,p=400<=k.status&&500>k.status,q=500<=k.status&&600>k.status;if(l||p||q)m=zh(a,c,k,b.fk);if(l)a:if(k&&204==k.status)l=!0;else{switch(c){case "XML":l=0==parseInt(m&&m.return_code,10);break a;case "RAW":l=!0;break a}l=!!m}m=m||{};p=b.context||x;l?b.onSuccess&&b.onSuccess.call(p,k,m):b.onError&&b.onError.call(p,k,m);b.ra&&b.ra.call(p,k,m)}},b.method,d,b.headers,b.responseType,
b.withCredentials);
if(b.X&&0<b.timeout){var g=b.X;var h=R(function(){e||(e=!0,f.abort(),Of(h),g.call(b.context||x,f))},b.timeout)}return f}
function vh(a,b){b.ik&&(a=document.location.protocol+"//"+document.location.hostname+(document.location.port?":"+document.location.port:"")+a);var c=P("XSRF_FIELD_NAME",void 0),d=b.sb;d&&(d[c]&&delete d[c],a=hh(a,d||{},!0));return a}
function wh(a,b){var c=P("XSRF_FIELD_NAME",void 0),d=P("XSRF_TOKEN",void 0),e=b.postBody||"",f=b.D,g=P("XSRF_FIELD_NAME",void 0),h;b.headers&&(h=b.headers["Content-Type"]);b.hk||Yb(a)&&!b.withCredentials&&Yb(a)!=document.location.hostname||"POST"!=b.method||h&&"application/x-www-form-urlencoded"!=h||b.D&&b.D[g]||(f||(f={}),f[c]=d);f&&"string"===typeof e&&(e=gh(e),pb(e,f),e=b.Da&&"JSON"==b.Da?JSON.stringify(e):$b(e));f=e||f&&!jb(f);!rh&&f&&"POST"!=b.method&&(rh=!0,Df(Error("AJAX request with postData should use POST")));
return e}
function zh(a,b,c,d){var e=null;switch(b){case "JSON":try{var f=c.responseText}catch(g){throw d=Error("Error reading responseText"),d.params=a,Ef(d),g;}a=c.getResponseHeader("Content-Type")||"";f&&0<=a.indexOf("json")&&(")]}'\n"===f.substring(0,5)&&(f=f.substring(5)),e=JSON.parse(f));break;case "XML":if(a=(a=c.responseXML)?Ah(a):null)e={},H(a.getElementsByTagName("*"),function(g){e[g.tagName]=Bh(g)})}d&&Ch(e);
return e}
function Ch(a){if(C(a))for(var b in a){var c;(c="html_content"==b)||(c=b.length-5,c=0<=c&&b.indexOf("_html",c)==c);if(c){c=b;var d=Rb(a[b],null);a[c]=d}else Ch(a[b])}}
function Ah(a){return a?(a=("responseXML"in a?a.responseXML:a).getElementsByTagName("root"))&&0<a.length?a[0]:null:null}
function Bh(a){var b="";H(a.childNodes,function(c){b+=c.nodeValue});
return b}
function yh(a,b,c,d,e,f,g){function h(){4==(k&&"readyState"in k?k.readyState:0)&&b&&Cf(b)(k)}
c=void 0===c?"GET":c;d=void 0===d?"":d;var k=nh();if(!k)return null;"onloadend"in k?k.addEventListener("loadend",h,!1):k.onreadystatechange=h;Q("debug_forward_web_query_parameters")&&(a=th(a));k.open(c,a,!0);f&&(k.responseType=f);g&&(k.withCredentials=!0);c="POST"==c&&(void 0===window.FormData||!(d instanceof FormData));if(e=sh(a,e))for(var l in e)k.setRequestHeader(l,e[l]),"content-type"==l.toLowerCase()&&(c=!1);c&&k.setRequestHeader("Content-Type","application/x-www-form-urlencoded");k.send(d);
return k}
;function Dh(){for(var a={},b=u(Object.entries(gh(P("DEVICE","")))),c=b.next();!c.done;c=b.next()){var d=u(c.value);c=d.next().value;d=d.next().value;"cbrand"===c?a.deviceMake=d:"cmodel"===c?a.deviceModel=d:"cbr"===c?a.browserName=d:"cbrver"===c?a.browserVersion=d:"cos"===c?a.osName=d:"cosver"===c?a.osVersion=d:"cplatform"===c&&(a.platform=d)}return a}
;function Eh(){return"INNERTUBE_API_KEY"in yf&&"INNERTUBE_API_VERSION"in yf}
function Vg(){return{innertubeApiKey:P("INNERTUBE_API_KEY",void 0),innertubeApiVersion:P("INNERTUBE_API_VERSION",void 0),Sa:P("INNERTUBE_CONTEXT_CLIENT_CONFIG_INFO"),Ta:P("INNERTUBE_CONTEXT_CLIENT_NAME","WEB"),innertubeContextClientVersion:P("INNERTUBE_CONTEXT_CLIENT_VERSION",void 0),Va:P("INNERTUBE_CONTEXT_HL",void 0),Ua:P("INNERTUBE_CONTEXT_GL",void 0),Wa:P("INNERTUBE_HOST_OVERRIDE",void 0)||"",Ya:!!P("INNERTUBE_USE_THIRD_PARTY_AUTH",!1),Xa:!!P("INNERTUBE_OMIT_API_KEY_WHEN_AUTH_HEADER_IS_PRESENT",
!1),appInstallData:P("SERIALIZED_CLIENT_CONFIG_DATA",void 0)}}
function Ug(a){var b={client:{hl:a.Va,gl:a.Ua,clientName:a.Ta,clientVersion:a.innertubeContextClientVersion,configInfo:a.Sa}},c=window.devicePixelRatio;c&&1!=c&&(b.client.screenDensityFloat=String(c));c=P("EXPERIMENTS_TOKEN","");""!==c&&(b.client.experimentsToken=c);c=[];var d=P("EXPERIMENTS_FORCED_FLAGS",{});for(e in d)c.push({key:e,value:String(d[e])});var e=P("EXPERIMENT_FLAGS",{});for(var f in e)f.startsWith("force_")&&void 0===d[f]&&c.push({key:f,value:String(e[f])});0<c.length&&(b.request={internalExperimentFlags:c});
a.appInstallData&&Q("web_log_app_install_experiments")&&(b.client.configInfo=b.client.configInfo||{},b.client.configInfo.appInstallData=a.appInstallData);P("DELEGATED_SESSION_ID")&&!Q("pageid_as_header_web")&&(b.user={onBehalfOfUser:P("DELEGATED_SESSION_ID")});b.client=Object.assign(b.client,Dh());return b}
function Fh(a,b,c){c=void 0===c?{}:c;var d={"X-Goog-Visitor-Id":c.visitorData||P("VISITOR_DATA","")};if(b&&b.includes("www.youtube-nocookie.com"))return d;(b=c.ck||P("AUTHORIZATION"))||(a?b="Bearer "+z("gapi.auth.getToken")().bk:b=id([]));b&&(d.Authorization=b,d["X-Goog-AuthUser"]=P("SESSION_INDEX",0),Q("pageid_as_header_web")&&(d["X-Goog-PageId"]=P("DELEGATED_SESSION_ID")));return d}
;function Gh(a){a=Object.assign({},a);delete a.Authorization;var b=id();if(b){var c=new Ad;c.update(P("INNERTUBE_API_KEY",void 0));c.update(b);a.hash=zc(c.digest())}return a}
;function Hh(){var a=new qf;(a=a.isAvailable()?new wf(a,"yt.innertube"):null)||(a=new rf("yt.innertube"),a=a.isAvailable()?a:null);this.f=a?new mf(a):null;this.g=document.domain||window.location.hostname}
Hh.prototype.set=function(a,b,c,d){c=c||31104E3;this.remove(a);if(this.f)try{this.f.set(a,b,E()+1E3*c);return}catch(f){}var e="";if(d)try{e=escape(Fe(b))}catch(f){return}else e=escape(b);Hf(a,e,c,this.g)};
Hh.prototype.get=function(a,b){var c=void 0,d=!this.f;if(!d)try{c=this.f.get(a)}catch(e){d=!0}if(d&&(c=Fc.get(""+a,void 0))&&(c=unescape(c),b))try{c=JSON.parse(c)}catch(e){this.remove(a),c=void 0}return c};
Hh.prototype.remove=function(a){this.f&&this.f.remove(a);var b=this.g;Fc.remove(""+a,"/",void 0===b?"youtube.com":b)};var Ih;function Jh(){Ih||(Ih=new Hh);return Ih}
function Kh(a,b,c,d){if(d)return null;d=Jh().get("nextId",!0)||1;var e=Jh().get("requests",!0)||{};e[d]={method:a,request:b,authState:Gh(c),requestTime:Math.round(S())};Jh().set("nextId",d+1,86400,!0);Jh().set("requests",e,86400,!0);return d}
function Lh(a){var b=Jh().get("requests",!0)||{};delete b[a];Jh().set("requests",b,86400,!0)}
function Mh(a){var b=Jh().get("requests",!0);if(b){for(var c in b){var d=b[c];if(!(6E4>Math.round(S())-d.requestTime)){var e=d.authState,f=Gh(Fh(!1));lb(e,f)&&(e=d.request,"requestTimeMs"in e&&(e.requestTimeMs=Math.round(S())),Yg(a,d.method,e,{}));delete b[c]}}Jh().set("requests",b,86400,!0)}}
;var Nh=[],Oh=!1;function Ph(a,b){Oh||(Nh.push({type:"EVENT",eventType:a,payload:b}),10<Nh.length&&Nh.shift())}
;function Qh(a){if(!a)throw Error();throw a;}
function Rh(a){return a}
function T(a){var b=this;this.g=a;this.state={status:"PENDING"};this.f=[];this.onRejected=[];this.g(function(c){if("PENDING"===b.state.status){b.state={status:"FULFILLED",value:c};c=u(b.f);for(var d=c.next();!d.done;d=c.next())d=d.value,d()}},function(c){if("PENDING"===b.state.status){b.state={status:"REJECTED",
reason:c};c=u(b.onRejected);for(var d=c.next();!d.done;d=c.next())d=d.value,d()}})}
T.all=function(a){return new T(function(b,c){var d=[],e=a.length;0===e&&b(d);for(var f={P:0};f.P<a.length;f={P:f.P},++f.P)Sh(T.resolve(a[f.P]).then(function(g){return function(h){d[g.P]=h;e--;0===e&&b(d)}}(f)),function(g){c(g)})})};
T.resolve=function(a){return new T(function(b,c){a instanceof T?a.then(b,c):b(a)})};
T.reject=function(a){return new T(function(b,c){c(a)})};
T.prototype.then=function(a,b){var c=this,d=null!==a&&void 0!==a?a:Rh,e=null!==b&&void 0!==b?b:Qh;return new T(function(f,g){"PENDING"===c.state.status?(c.f.push(function(){Th(c,c,d,f,g)}),c.onRejected.push(function(){Uh(c,c,e,f,g)})):"FULFILLED"===c.state.status?Th(c,c,d,f,g):"REJECTED"===c.state.status&&Uh(c,c,e,f,g)})};
function Sh(a,b){a.then(void 0,b)}
function Th(a,b,c,d,e){try{if("FULFILLED"!==a.state.status)throw Error("calling handleResolve before the promise is fulfilled.");var f=c(a.state.value);f instanceof T?Vh(a,b,f,d,e):d(f)}catch(g){e(g)}}
function Uh(a,b,c,d,e){try{if("REJECTED"!==a.state.status)throw Error("calling handleReject before the promise is rejected.");var f=c(a.state.reason);f instanceof T?Vh(a,b,f,d,e):d(f)}catch(g){e(g)}}
function Vh(a,b,c,d,e){b===c?e(new TypeError("Circular promise chain detected.")):c.then(function(f){f instanceof T?Vh(a,b,f,d,e):d(f)},function(f){e(f)})}
;function Wh(a,b,c){function d(){c(a.error);f()}
function e(){b(a.result);f()}
function f(){try{a.removeEventListener("success",e),a.removeEventListener("error",d)}catch(g){}}
a.addEventListener("success",e);a.addEventListener("error",d)}
function Xh(a){return new M(function(b,c){Wh(a,b,c)})}
function U(a){return new T(function(b,c){Wh(a,b,c)})}
;function Yh(a,b){return new T(function(c,d){function e(){var f=a?b(a):null;f?f.then(function(g){a=g;e()},d):c()}
e()})}
;function Zh(a,b){for(var c=[],d=1;d<arguments.length;++d)c[d-1]=arguments[d];d=Error.call(this,a);this.message=d.message;"stack"in d&&(this.stack=d.stack);this.args=[].concat(c instanceof Array?c:fa(u(c)))}
v(Zh,Error);var $h={},ai=($h.AUTH_INVALID="No user identifier specified.",$h.EXPLICIT_ABORT="Transaction was explicitly aborted.",$h.IDB_NOT_SUPPORTED="IndexedDB is not supported.",$h.MISSING_OBJECT_STORE="Object store not created.",$h.UNKNOWN_ABORT="Transaction was aborted for unknown reasons.",$h.QUOTA_EXCEEDED="The current transaction exceeded its quota limitations.",$h.QUOTA_MAYBE_EXCEEDED="The current transaction may have failed because of exceeding quota limitations.",$h);
function bi(a,b,c){b=void 0===b?{}:b;c=void 0===c?ai[a]:c;Zh.call(this,c,Object.assign({name:"YtIdbKnownError",isSw:void 0===self.document,isIframe:self!==self.top,type:a},b));this.type=a;this.message=c;Object.setPrototypeOf(this,bi.prototype);Oh||(Nh.push({type:"ERROR",payload:this}),10<Nh.length&&Nh.shift())}
v(bi,Zh);function ci(a,b,c){bi.call(this,"UNKNOWN_ABORT",{objectStoreNames:a,dbName:b,mode:c});Object.setPrototypeOf(this,ci.prototype)}
v(ci,bi);function di(a){bi.call(this,"MISSING_OBJECT_STORE",{jk:a},ai.MISSING_OBJECT_STORE);Object.setPrototypeOf(this,di.prototype)}
v(di,bi);function ei(a,b){this.f=a;this.options=b;this.transactionCount=0;this.h=Math.round(S());this.g=!1}
n=ei.prototype;n.add=function(a,b,c){return fi(this,[a],"readwrite",function(d){return gi(d,a).add(b,c)})};
n.clear=function(a){return fi(this,[a],"readwrite",function(b){return gi(b,a).clear()})};
n.close=function(){var a;this.f.close();(null===(a=this.options)||void 0===a?0:a.closed)&&this.options.closed()};
n.count=function(a,b){return fi(this,[a],"readonly",function(c){return gi(c,a).count(b)})};
n["delete"]=function(a,b){return fi(this,[a],"readwrite",function(c){return gi(c,a)["delete"](b)})};
n.get=function(a,b){return fi(this,[a],"readwrite",function(c){return gi(c,a).get(b)})};
function fi(a,b,c,d){c=void 0===c?"readonly":c;a.transactionCount++;var e=a.f.transaction(b,c);e=new hi(e);d=ii(e,d);ji(a,d,b.join(),c);return d}
function ji(a,b,c,d){var e=Math.round(S());Ve(b.then(function(){var f=Math.round(S());ki(a,!0,c,f-e)}),function(f){var g=Math.round(S()),h=a.f.name,k=a.transactionCount,l;
"QuotaExceededError"===f.name?l=new bi("QUOTA_EXCEEDED",{objectStoreNames:c,dbName:h,mode:d}):"UnknownError"===f.name&&(l=new bi("QUOTA_MAYBE_EXCEEDED",{objectStoreNames:c,dbName:h,mode:d}));l&&Ph("QUOTA_EXCEEDED",{dbName:h,objectStoreNames:c,transactionCount:k,transactionMode:d});h=g-e;f instanceof ci&&(Ph("TRANSACTION_UNEXPECTEDLY_ABORTED",{objectStoreNames:c,transactionDuration:h,transactionCount:a.transactionCount,dbDuration:g-a.h}),a.g=!0);ki(a,!1,c,h)})}
function ki(a,b,c,d){Ph("TRANSACTION_ENDED",{objectStoreNames:c,connectionHasUnknownAbortedTransaction:a.g,duration:d,isSuccessful:b})}
function li(a){this.f=a}
n=li.prototype;n.add=function(a,b){return U(this.f.add(a,b))};
n.clear=function(){return U(this.f.clear()).then(function(){})};
n.count=function(a){return U(this.f.count(a))};
function mi(a,b){return ni(a,{query:b},function(c){return c["delete"]().then(function(){return c["continue"]()})}).then(function(){})}
n["delete"]=function(a){return a instanceof IDBKeyRange?mi(this,a):U(this.f["delete"](a))};
n.get=function(a){return U(this.f.get(a))};
n.index=function(a){return new oi(this.f.index(a))};
n.getName=function(){return this.f.name};
function ni(a,b,c){a=a.f.openCursor(b.query,b.direction);return pi(a).then(function(d){return Yh(d,c)})}
function hi(a){var b=this;this.f=a;this.g=new Map;this.aborted=!1;this.done=new M(function(c,d){b.f.addEventListener("complete",function(){c()});
b.f.addEventListener("error",function(e){e.currentTarget===e.target&&d(b.f.error)});
b.f.addEventListener("abort",function(){var e=b.f.error;if(e)d(e);else if(!b.aborted){e=ci;for(var f=b.f.objectStoreNames,g=[],h=0;h<f.length;h++){var k=f.item(h);if(null===k)throw Error("Invariant: item in DOMStringList is null");g.push(k)}e=new e(g.join(),b.f.db.name,b.f.mode);d(e)}})})}
function ii(a,b){var c=new M(function(d,e){Sh(b(a).then(function(f){a.commit();d(f)}),e)});
return Te([c,a.done]).then(function(d){return u(d).next().value})}
hi.prototype.abort=function(){this.f.abort();this.aborted=!0;throw new bi("EXPLICIT_ABORT");};
hi.prototype.commit=function(){var a=this.f;a.commit&&!this.aborted&&a.commit()};
function gi(a,b){var c=a.f.objectStore(b),d=a.g.get(c);d||(d=new li(c),a.g.set(c,d));return d}
function oi(a){this.f=a}
oi.prototype.count=function(a){return U(this.f.count(a))};
oi.prototype["delete"]=function(a){return qi(this,{query:a},function(b){return b["delete"]().then(function(){return b["continue"]()})})};
oi.prototype.get=function(a){return U(this.f.get(a))};
oi.prototype.getKey=function(a){return U(this.f.getKey(a))};
function qi(a,b,c){a=a.f.openCursor(void 0===b.query?null:b.query,void 0===b.direction?"next":b.direction);return pi(a).then(function(d){return Yh(d,c)})}
function ri(a,b){this.request=a;this.cursor=b}
function pi(a){return U(a).then(function(b){return null===b?null:new ri(a,b)})}
n=ri.prototype;n.advance=function(a){this.cursor.advance(a);return pi(this.request)};
n["continue"]=function(a){this.cursor["continue"](a);return pi(this.request)};
n["delete"]=function(){return U(this.cursor["delete"]()).then(function(){})};
n.getKey=function(){return this.cursor.key};
n.getValue=function(){return this.cursor.value};
n.update=function(a){return U(this.cursor.update(a))};function si(a,b,c){function d(){m||(m=new ei(e.result,{closed:l}));return m}
var e=self.indexedDB.open(a,b),f=c.blocked,g=c.blocking,h=c.rb,k=c.upgrade,l=c.closed,m;e.addEventListener("upgradeneeded",function(p){if(null===p.newVersion)throw Error("Invariant: newVersion on IDbVersionChangeEvent is null");if(null===e.transaction)throw Error("Invariant: transaction on IDbOpenDbRequest is null");p.dataLoss&&"none"!==p.dataLoss&&Ph("IDB_DATA_CORRUPTED",{reason:p.dataLossMessage||"unknown reason",dbName:a});var q=d(),r=new hi(e.transaction);k&&k(q,p.oldVersion,p.newVersion,r)});
f&&e.addEventListener("blocked",function(){f()});
return Xh(e).then(function(p){g&&p.addEventListener("versionchange",function(){g(d())});
p.addEventListener("close",function(){Ph("IDB_UNEXPECTEDLY_CLOSED",{dbName:a,dbVersion:p.version});h&&h()});
return d()})}
function ti(a,b,c){c=void 0===c?{}:c;return si(a,b,c)}
function ui(a,b){b=void 0===b?{}:b;var c=self.indexedDB.deleteDatabase(a),d=b.blocked;d&&c.addEventListener("blocked",function(){d()});
return Xh(c).then(function(){})}
;var vi=vc||wc;function wi(){var a=/WebKit\/([0-9]+)/.exec(Mb);return!!(a&&600<=parseInt(a[1],10))}
function xi(){var a=/WebKit\/([0-9]+)/.exec(Mb);return!!(a&&602<=parseInt(a[1],10))}
function yi(a){var b=Mb;return b?0<=b.toLowerCase().indexOf(a):!1}
;function zi(a,b){for(var c=u(Object.keys(b.ab)),d=c.next();!d.done;d=c.next())if(d=d.value,!a.f.objectStoreNames.contains(d))return d}
function Ai(a){this.name="YtIdbMeta";this.options=a;this.g=!1}
function Bi(a,b,c){c=void 0===c?{}:c;return ti(a,b,c)}
Ai.prototype["delete"]=function(a){a=void 0===a?{}:a;return ui(this.name,a)};
Ai.prototype.open=function(){var a=this;if(!this.f){var b,c=function(){a.f===b&&(a.f=void 0)},d={blocking:function(f){f.close()},
closed:c,rb:c,upgrade:this.options.upgrade},e=function(){return Ve(Bi(a.name,a.options.version,d).then(function(f){if(uc){var g=zi(f,a.options);if(void 0!==g){if(uc&&!a.g)return a.g=!0,a["delete"]().then(function(){return e()});
throw new di(g);}}return f}),function(f){if(f instanceof DOMException?"VersionError"===f.name:"DOMError"in self&&f instanceof DOMError?"VersionError"===f.name:f instanceof Object&&"message"in f&&"An attempt was made to open a database using a lower version than the existing version."===f.message)return Bi(a.name,void 0,Object.assign(Object.assign({},d),{upgrade:void 0}));
c();throw f;})};
this.f=b=e()}return this.f};var Ci=new Ai({ab:{databases:!0},upgrade:function(a,b){1>b&&a.f.createObjectStore("databases",{keyPath:"actualName"})}});
function Di(){var a={actualName:"yt-idb-test-do-not-use",publicName:"yt-idb-test-do-not-use",userIdentifier:void 0,signedIn:!1};return Ci.open().then(function(b){return fi(b,["databases"],"readwrite",function(c){var d=gi(c,"databases");return d.get(a.actualName).then(function(e){if(e?a.actualName!==e.actualName||a.publicName!==e.publicName||a.userIdentifier!==e.userIdentifier||a.signedIn!==e.signedIn||a.clearDataOnAuthChange!==e.clearDataOnAuthChange:1)return U(d.f.put(a,void 0))})})})}
function Ei(){return Ci.open().then(function(a){return a["delete"]("databases","yt-idb-test-do-not-use")})}
;new De;var Fi;function Gi(){return cc(this,function b(){var c,d;return Ba(b,function(e){switch(e.g){case 1:if(vi&&wi()&&!xi()&&!Q("ytidb_allow_on_ios_safari_v8_and_v9")||gc)return e["return"](!1);try{if(c=self,!(c.indexedDB&&c.IDBIndex&&c.IDBKeyRange&&c.IDBObjectStore))return e["return"](!1)}catch(f){return e["return"](!1)}if(Q("ytidb_new_supported_check_with_delete"))return e["return"](new Promise(function(f){Ve(Ei().then(function(){f(!0)}),function(){f(!1)})}));
if(Q("ytidb_new_supported_check_with_add_and_delete"))return e["return"](new Promise(function(f){Ve(Di().then(function(){return Ei()}).then(function(){f(!0)}),function(){f(!1)})}));
sa(e);return ra(e,Ve(ti("yt-idb-test-do-not-use"),function(){}));
case 5:if(d=e.A,!d)return e["return"](!1);case 3:ua(e);if(d)try{d.close()}catch(f){}va(e);break;case 2:return ta(e),e["return"](!1);case 4:return"IDBTransaction"in self&&"objectStoreNames"in IDBTransaction.prototype?e["return"](!0):e["return"](!1)}})})}
function Hi(){if(void 0!==Fi)return Fi;var a=S();Oh=!0;return Fi=new M(function(b){Gi().then(function(c){Oh=!1;Ph("IS_SUPPORTED_COMPLETED",{duration:Math.round(S()-a),isSupported:c});b(c)})})}
;function Ii(){De.call(this);this.h=Ji();Ki(this);Li(this)}
v(Ii,De);function Ji(){var a=window.navigator.onLine;return void 0===a?!0:a}
function Li(a){window.addEventListener("online",function(){a.h=!0;a.m&&a.m()})}
function Ki(a){window.addEventListener("offline",function(){a.h=!1;a.l&&a.l()})}
;function Mi(a,b){b=void 0===b?{}:b;Hi().then(function(){Ii.f||(Ii.f=new Ii);Ii.f.h!==Ji()&&Ef(new Zh("NetworkStatusManager isOnline does not match window status"));xh(a,b)})}
function Ni(a,b){b=void 0===b?{}:b;Hi().then(function(){xh(a,b)})}
;function Oi(a){var b=this;this.F=null;a?this.F=a:Eh()&&(this.F=Vg());jg(function(){Mh(b)},0,5E3)}
Oi.prototype.isReady=function(){!this.F&&Eh()&&(this.F=Vg());return!!this.F};
function Yg(a,b,c,d){!P("VISITOR_DATA")&&"visitor_id"!==b&&.01>Math.random()&&Ef(new Zh("Missing VISITOR_DATA when sending innertube request.",b,c,d));if(!a.isReady()){var e=new Zh("innertube xhrclient not ready",b,c,d);Df(e);e.sampleWeight=0;throw e;}var f={headers:{"Content-Type":"application/json"},method:"POST",D:c,Da:"JSON",X:function(){d.X()},
Ca:d.X,onSuccess:function(p,q){if(d.onSuccess)d.onSuccess(q)},
Ba:function(p){if(d.onSuccess)d.onSuccess(p)},
onError:function(p,q){if(d.onError)d.onError(q)},
kk:function(p){if(d.onError)d.onError(p)},
timeout:d.timeout,withCredentials:!0},g="";(e=a.F.Wa)&&(g=e);var h=a.F.Ya||!1,k=Fh(h,g,d);Object.assign(f.headers,k);f.headers.Authorization&&!g&&(f.headers["x-origin"]=window.location.origin);e="/youtubei/"+a.F.innertubeApiVersion+"/"+b;var l={alt:"json"};a.F.Xa&&f.headers.Authorization||(l.key=a.F.innertubeApiKey);var m=hh(""+g+e,l||{},!0);Hi().then(function(p){if(d.retry&&Q("retry_web_logging_batches")&&"www.youtube-nocookie.com"!=g){if(Q("networkless_gel")&&!p||!Q("networkless_gel"))var q=Kh(b,
c,k,h);if(q){var r=f.onSuccess,A=f.Ba;f.onSuccess=function(B,V){Lh(q);r(B,V)};
c.Ba=function(B,V){Lh(q);A(B,V)}}}try{Q("use_fetch_for_op_xhr")?uh(m,f):Q("networkless_gel")&&d.retry?(f.method="POST",!d.tb&&Q("nwl_send_fast_on_unload")?Ni(m,f):Mi(m,f)):(f.method="POST",f.D||(f.D={}),xh(m,f))}catch(B){if("InvalidAccessError"==B.name)q&&(Lh(q),q=0),Ef(Error("An extension is blocking network request."));
else throw B;}q&&jg(function(){Mh(a)},0,5E3)})}
;function Pi(a,b,c){c=void 0===c?{}:c;var d=Oi;P("ytLoggingEventsDefaultDisabled",!1)&&Oi==Oi&&(d=null);$g(a,b,d,c)}
;var Qi=[{za:function(a){return"Cannot read property '"+a.key+"'"},
sa:{TypeError:[{regexp:/Cannot read property '([^']+)' of (null|undefined)/,groups:["key","value"]},{regexp:/\u65e0\u6cd5\u83b7\u53d6\u672a\u5b9a\u4e49\u6216 (null|undefined) \u5f15\u7528\u7684\u5c5e\u6027\u201c([^\u201d]+)\u201d/,groups:["value","key"]},{regexp:/\uc815\uc758\ub418\uc9c0 \uc54a\uc74c \ub610\ub294 (null|undefined) \ucc38\uc870\uc778 '([^']+)' \uc18d\uc131\uc744 \uac00\uc838\uc62c \uc218 \uc5c6\uc2b5\ub2c8\ub2e4./,groups:["value","key"]},{regexp:/No se puede obtener la propiedad '([^']+)' de referencia nula o sin definir/,
groups:["key"]},{regexp:/Unable to get property '([^']+)' of (undefined or null) reference/,groups:["key","value"]}],Error:[{regexp:/(Permission denied) to access property "([^']+)"/,groups:["reason","key"]}]}},{za:function(a){return"Cannot call '"+a.key+"'"},
sa:{TypeError:[{regexp:/(?:([^ ]+)?\.)?([^ ]+) is not a function/,groups:["base","key"]},{regexp:/([^ ]+) called on (null or undefined)/,groups:["key","value"]},{regexp:/Object (.*) has no method '([^ ]+)'/,groups:["base","key"]},{regexp:/Object doesn't support property or method '([^ ]+)'/,groups:["key"]},{regexp:/\u30aa\u30d6\u30b8\u30a7\u30af\u30c8\u306f '([^']+)' \u30d7\u30ed\u30d1\u30c6\u30a3\u307e\u305f\u306f\u30e1\u30bd\u30c3\u30c9\u3092\u30b5\u30dd\u30fc\u30c8\u3057\u3066\u3044\u307e\u305b\u3093/,
groups:["key"]},{regexp:/\uac1c\uccb4\uac00 '([^']+)' \uc18d\uc131\uc774\ub098 \uba54\uc11c\ub4dc\ub97c \uc9c0\uc6d0\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4./,groups:["key"]}]}}];function Ri(){this.f=[];this.g=[]}
var Si;var Ti=new N;function Ui(a,b,c,d){c+="."+a;a=Vi(b);d[c]=a;return c.length+a.length}
function Vi(a){return("string"===typeof a?a:String(JSON.stringify(a))).substr(0,500)}
;var Wi=new Set,Xi=0,Yi=["PhantomJS","Googlebot","TO STOP THIS SECURITY SCAN go/scan"];function Zi(a){$i(a,"WARNING")}
function $i(a,b,c,d,e,f){f=void 0===f?{}:f;f.name=c||P("INNERTUBE_CONTEXT_CLIENT_NAME",1);f.version=d||P("INNERTUBE_CONTEXT_CLIENT_VERSION",void 0);c=f||{};b=void 0===b?"ERROR":b;b=void 0===b?"ERROR":b;var g=void 0===g?!1:g;if(a&&(Q("console_log_js_exceptions")&&(d=[],d.push("Name: "+a.name),d.push("Message: "+a.message),a.hasOwnProperty("params")&&d.push("Error Params: "+JSON.stringify(a.params)),d.push("File name: "+a.fileName),d.push("Stacktrace: "+a.stack),window.console.log(d.join("\n"),a)),
(window&&window.yterr||g)&&!(5<=Xi)&&0!==a.sampleWeight)){f=Ac(a);g=f.message||"Unknown Error";d=f.name||"UnknownError";var h=f.stack||a.f||"Not available";Q("kevlar_js_fixes")&&h.startsWith(d+": "+g)&&(e=h.split("\n"),e.shift(),h=e.join("\n"));e=f.lineNumber||"Not available";f=f.fileName||"Not available";if(a.hasOwnProperty("args")&&a.args&&a.args.length)for(var k=0,l=0;l<a.args.length;l++){var m=a.args[l],p="params."+l;k+=p.length;if(m)if(Array.isArray(m))for(var q=c,r=0;r<m.length&&!(m[r]&&(k+=
Ui(r,m[r],p,q),500<k));r++);else if("object"===typeof m)for(q in q=void 0,r=c,m){if(m[q]&&(k+=Ui(q,m[q],p,r),500<k))break}else c[p]=Vi(m),k+=c[p].length;else c[p]=Vi(m),k+=c[p].length;if(500<=k)break}else if(a.hasOwnProperty("params")&&a.params)if(m=a.params,"object"===typeof a.params)for(l in p=0,m){if(m[l]&&(k="params."+l,q=Vi(m[l]),c[k]=q,p+=k.length+q.length,500<p))break}else c.params=Vi(m);navigator.vendor&&!c.hasOwnProperty("vendor")&&(c.vendor=navigator.vendor);c={message:g,name:d,lineNumber:e,
fileName:f,stack:h,params:c};a=Number(a.columnNumber);isNaN(a)||(c.lineNumber=c.lineNumber+":"+a);a=u(Qi);for(g=a.next();!g.done;g=a.next())if(g=g.value,g.sa[c.name])for(e=u(g.sa[c.name]),d=e.next();!d.done;d=e.next())if(f=d.value,d=c.message.match(f.regexp)){c.params["error.original"]=d[0];e=f.groups;f={};for(h=0;h<e.length;h++)f[e[h]]=d[h+1],c.params["error."+e[h]]=d[h+1];c.message=g.za(f);break}window.yterr&&"function"===typeof window.yterr&&window.yterr(c);if(!(Wi.has(c.message)||0<=c.stack.indexOf("/YouTubeCenter.js")||
0<=c.stack.indexOf("/mytube.js"))){"ERROR"===b?Ti.O("handleError",c):"WARNING"===b&&Ti.O("handleWarning",c);if(Q("kevlar_gel_error_routing")){a=b;a:{g=u(Yi);for(d=g.next();!d.done;d=g.next())if(yi(d.value.toLowerCase())){g=!0;break a}g=!1}if(!g){d={stackTrace:c.stack};c.fileName&&(d.filename=c.fileName);g=c.lineNumber&&c.lineNumber.split?c.lineNumber.split(":"):[];0!==g.length&&(1!==g.length||isNaN(Number(g[0]))?2!==g.length||isNaN(Number(g[0]))||isNaN(Number(g[1]))||(d.lineNumber=Number(g[0]),d.columnNumber=
Number(g[1])):d.lineNumber=Number(g[0]));Si||(Si=new Ri);g=Si;e=c.message;f=c.name;a:{h=u(g.g);for(l=h.next();!l.done;l=h.next())if(l=l.value,c.message&&c.message.match(l.f)){h=l.weight;break a}h=u(g.f);for(l=h.next();!l.done;l=h.next())if(l=l.value,l.Ja(c)){h=l.weight;break a}h=1}e={level:"ERROR_LEVEL_UNKNOWN",message:e,errorClassName:f,sampleWeight:h};"ERROR"===a?e.level="ERROR_LEVEL_ERROR":"WARNING"===a&&(e.level="ERROR_LEVEL_WARNNING");a={isObfuscated:!0,browserStackInfo:d};d={pageUrl:window.location.href};
P("FEXP_EXPERIMENTS")&&(d.experimentIds=P("FEXP_EXPERIMENTS"));d.kvPairs=[{key:"client.params.errorServiceSignature",value:"msg="+g.g.length+"&cb="+g.f.length},{key:"client.params.serviceWorker",value:"false"}];if(g=c.params)for(f=u(Object.keys(g)),h=f.next();!h.done;h=f.next())h=h.value,d.kvPairs.push({key:"client."+h,value:String(g[h])});g=P("SERVER_NAME",void 0);f=P("SERVER_VERSION",void 0);g&&f&&(d.kvPairs.push({key:"server.name",value:g}),d.kvPairs.push({key:"server.version",value:f}));Pi("clientError",
{errorMetadata:d,stackTrace:a,logMessage:e});Rg()}}if(!Q("suppress_error_204_logging")){a=c.params||{};b={sb:{a:"logerror",t:"jserror",type:c.name,msg:c.message.substr(0,250),line:c.lineNumber,level:b,"client.name":a.name},D:{url:P("PAGE_NAME",window.location.href),file:c.fileName},method:"POST"};a.version&&(b["client.version"]=a.version);if(b.D){c.stack&&(b.D.stack=c.stack);g=u(Object.keys(a));for(d=g.next();!d.done;d=g.next())d=d.value,b.D["client."+d]=a[d];if(a=P("LATEST_ECATCHER_SERVICE_TRACKING_PARAMS",
void 0))for(g=u(Object.keys(a)),d=g.next();!d.done;d=g.next())d=d.value,b.D[d]=a[d];a=P("SERVER_NAME",void 0);g=P("SERVER_VERSION",void 0);a&&g&&(b.D["server.name"]=a,b.D["server.version"]=g)}xh(P("ECATCHER_REPORT_HOST","")+"/error_204",b)}Wi.add(c.message);Xi++}}}
function aj(a,b){for(var c=[],d=1;d<arguments.length;++d)c[d-1]=arguments[d];a.args||(a.args=[]);a.args.push.apply(a.args,c instanceof Array?c:fa(u(c)))}
;function bj(){this.g=!1;this.f=null}
bj.prototype.initialize=function(a,b,c,d,e,f){var g=this;f=void 0===f?!1:f;b?(this.g=!0,ag(b,function(){g.g=!1;window.botguard?cj(g,c,d,f):(fg(b),Zi(new Zh("Unable to load Botguard","from "+b)))},e)):a&&(e=Nc(document,"SCRIPT"),e.textContent=a,e.nonce=Fa(),document.head.appendChild(e),document.head.removeChild(e),window.botguard?cj(this,c,d,f):Zi(Error("Unable to load Botguard from JS")))};
function cj(a,b,c,d){if(d)try{a.f=new window.botguard.bg(b,c?function(){return c(b)}:Ja)}catch(e){Zi(e)}else{try{a.f=new window.botguard.bg(b)}catch(e){Zi(e)}c&&c(b)}}
bj.prototype.dispose=function(){this.f=null};var dj=new bj;function ej(){return!!dj.f}
function fj(a){a=void 0===a?{}:a;a=void 0===a?{}:a;return dj.f?dj.f.invoke(void 0,void 0,a):null}
;var gj=E().toString();
function hj(){a:{if(window.crypto&&window.crypto.getRandomValues)try{var a=Array(16),b=new Uint8Array(16);window.crypto.getRandomValues(b);for(var c=0;c<a.length;c++)a[c]=b[c];var d=a;break a}catch(e){}d=Array(16);for(a=0;16>a;a++){b=E();for(c=0;c<b%23;c++)d[a]=Math.random();d[a]=Math.floor(256*Math.random())}if(gj)for(a=1,b=0;b<gj.length;b++)d[a%16]=d[a%16]^d[(a-1)%16]/4^gj.charCodeAt(b),a++}a=[];for(b=0;b<d.length;b++)a.push("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_".charAt(d[b]&63));
return a.join("")}
;var ij=x.ytLoggingDocDocumentNonce_||hj();y("ytLoggingDocDocumentNonce_",ij,void 0);var jj=1;function kj(a){this.f=a}
function lj(a){return new kj({trackingParams:a})}
function mj(a){var b=jj++;return new kj({veType:a,veCounter:b,elementIndex:void 0,dataElement:void 0,youtubeData:void 0})}
kj.prototype.getAsJson=function(){var a={};void 0!==this.f.trackingParams?a.trackingParams=this.f.trackingParams:(a.veType=this.f.veType,void 0!==this.f.veCounter&&(a.veCounter=this.f.veCounter),void 0!==this.f.elementIndex&&(a.elementIndex=this.f.elementIndex));void 0!==this.f.dataElement&&(a.dataElement=this.f.dataElement.getAsJson());void 0!==this.f.youtubeData&&(a.youtubeData=this.f.youtubeData);return a};
kj.prototype.toString=function(){return JSON.stringify(this.getAsJson())};
kj.prototype.isClientVe=function(){return!this.f.trackingParams&&!!this.f.veType};function nj(a){a=void 0===a?0:a;return 0==a?"client-screen-nonce":"client-screen-nonce."+a}
function oj(a){a=void 0===a?0:a;return 0==a?"ROOT_VE_TYPE":"ROOT_VE_TYPE."+a}
function pj(a){return P(oj(void 0===a?0:a),void 0)}
y("yt_logging_screen.getRootVeType",pj,void 0);function qj(a){return(a=pj(void 0===a?0:a))?new kj({veType:a,youtubeData:void 0}):null}
function rj(){var a=P("csn-to-ctt-auth-info");a||(a={},O("csn-to-ctt-auth-info",a));return a}
function W(a){a=void 0===a?0:a;var b=P(nj(a));if(!b&&!P("USE_CSN_FALLBACK",!0))return null;b||0!=a||(Q("kevlar_client_side_screens")||Q("c3_client_side_screens")?b="UNDEFINED_CSN":b=P("EVENT_ID"));return b?b:null}
y("yt_logging_screen.getCurrentCsn",W,void 0);function sj(a,b,c){var d=rj();(c=W(c))&&delete d[c];b&&(d[a]=b)}
function tj(a){return rj()[a]}
y("yt_logging_screen.getCttAuthInfo",tj,void 0);function uj(a,b,c,d){c=void 0===c?0:c;if(a!==P(nj(c))||b!==P(oj(c)))if(sj(a,d,c),O(nj(c),a),O(oj(c),b),0==c||Q("web_screen_associated_all_layers"))b=function(){setTimeout(function(){a&&$g("foregroundHeartbeatScreenAssociated",{clientDocumentNonce:ij,clientScreenNonce:a},Oi)},0)},"requestAnimationFrame"in window?window.requestAnimationFrame(b):b()}
y("yt_logging_screen.setCurrentScreen",uj,void 0);function vj(a,b,c){b=void 0===b?{}:b;c=void 0===c?!1:c;var d=P("EVENT_ID");d&&(b.ei||(b.ei=d));if(b){d=a;var e=void 0===e?!0:e;var f=P("VALID_SESSION_TEMPDATA_DOMAINS",[]),g=Yb(window.location.href);g&&f.push(g);g=Yb(d);if(0<=Xa(f,g)||!g&&0==d.lastIndexOf("/",0))if(Q("autoescape_tempdata_url")&&(f=document.createElement("a"),Sb(f,d),d=f.href),d){g=d.match(Wb);d=g[5];f=g[6];g=g[7];var h="";d&&(h+=d);f&&(h+="?"+f);g&&(h+="#"+g);d=h;f=d.indexOf("#");if(d=0>f?d:d.substr(0,f))if(e&&!b.csn&&(b.itct||b.ved)&&
(b=Object.assign({csn:W()},b)),k){var k=parseInt(k,10);isFinite(k)&&0<k&&(e=b,b="ST-"+Vb(d).toString(36),e=e?$b(e):"",Hf(b,e,k||5))}else k=b,e="ST-"+Vb(d).toString(36),k=k?$b(k):"",Hf(e,k,5)}}if(c)return!1;if((window.ytspf||{}).enabled)spf.navigate(a);else{var l=void 0===l?{}:l;var m=void 0===m?"":m;var p=void 0===p?window:p;c=p.location;a=ac(a,l)+m;a=a instanceof I?a:Kb(a);c.href=Gb(a)}return!0}
;function wj(a,b){this.version=a;this.args=b}
;function xj(a,b){this.topic=a;this.f=b}
xj.prototype.toString=function(){return this.topic};var yj=z("ytPubsub2Pubsub2Instance")||new N;N.prototype.subscribe=N.prototype.subscribe;N.prototype.unsubscribeByKey=N.prototype.W;N.prototype.publish=N.prototype.O;N.prototype.clear=N.prototype.clear;y("ytPubsub2Pubsub2Instance",yj,void 0);var zj=z("ytPubsub2Pubsub2SubscribedKeys")||{};y("ytPubsub2Pubsub2SubscribedKeys",zj,void 0);var Aj=z("ytPubsub2Pubsub2TopicToKeys")||{};y("ytPubsub2Pubsub2TopicToKeys",Aj,void 0);var Bj=z("ytPubsub2Pubsub2IsAsync")||{};y("ytPubsub2Pubsub2IsAsync",Bj,void 0);
y("ytPubsub2Pubsub2SkipSubKey",null,void 0);function Cj(a,b){var c=Dj();c&&c.publish.call(c,a.toString(),a,b)}
function Ej(a,b,c){var d=Dj();if(!d)return 0;var e=d.subscribe(a.toString(),function(f,g){var h=z("ytPubsub2Pubsub2SkipSubKey");h&&h==e||(h=function(){if(zj[e])try{if(g&&a instanceof xj&&a!=f)try{var k=a.f,l=g;if(!l.args||!l.version)throw Error("yt.pubsub2.Data.deserialize(): serializedData is incomplete.");try{if(!k.N){var m=new k;k.N=m.version}var p=k.N}catch(q){}if(!p||l.version!=p)throw Error("yt.pubsub2.Data.deserialize(): serializedData version is incompatible.");try{g=Reflect.construct(k,db(l.args))}catch(q){throw q.message=
"yt.pubsub2.Data.deserialize(): "+q.message,q;}}catch(q){throw q.message="yt.pubsub2.pubsub2 cross-binary conversion error for "+a.toString()+": "+q.message,q;}b.call(c||window,g)}catch(q){Df(q)}},Bj[a.toString()]?z("yt.scheduler.instance")?ig(h):R(h,0):h())});
zj[e]=!0;Aj[a.toString()]||(Aj[a.toString()]=[]);Aj[a.toString()].push(e);return e}
function Fj(){var a=Gj,b=Ej(Hj,function(c){a.apply(void 0,arguments);Ij(b)},void 0);
return b}
function Ij(a){var b=Dj();b&&("number"===typeof a&&(a=[a]),H(a,function(c){b.unsubscribeByKey(c);delete zj[c]}))}
function Dj(){return z("ytPubsub2Pubsub2Instance")}
;function Jj(a){wj.call(this,1,arguments);this.csn=a}
v(Jj,wj);var Hj=new xj("screen-created",Jj),Kj=[],Mj=Lj,Nj=0;function Oj(a,b,c,d){c={csn:b,parentVe:c.getAsJson(),childVes:$a(d,function(f){return f.getAsJson()})};
d=u(d);for(var e=d.next();!e.done;e=d.next())e=e.value.getAsJson(),(jb(e)||!e.trackingParams&&!e.veType)&&Zi(Error("Child VE logged with no data"));d={L:tj(b),M:b};"UNDEFINED_CSN"==b?Pj("visualElementAttached",c,d):a?$g("visualElementAttached",c,a,d):Pi("visualElementAttached",c,d)}
function Qj(a,b,c){var d="INTERACTION_LOGGING_GESTURE_TYPE_GENERIC_CLICK";c={csn:b,ve:c.getAsJson(),gestureType:d};d={L:tj(b),M:b};"UNDEFINED_CSN"==b?Pj("visualElementGestured",c,d):a?$g("visualElementGestured",c,a,d):Pi("visualElementGestured",c,d)}
function Lj(){for(var a=Math.random()+"",b=[],c=0,d=0;d<a.length;d++){var e=a.charCodeAt(d);255<e&&(b[c++]=e&255,e>>=8);b[c++]=e}return zc(b)}
function Pj(a,b,c){Kj.push({payloadName:a,payload:b,options:c});Nj||(Nj=Fj())}
function Gj(a){if(Kj){for(var b=u(Kj),c=b.next();!c.done;c=b.next())c=c.value,c.payload&&(c.payload.csn=a.csn,$g(c.payloadName,c.payload,null,c.options));Kj.length=0}Nj=0}
;function Rj(a,b,c){Oj(Q("use_default_events_client")?void 0:Oi,a,b,[c])}
;var Sj={Yb:6827,Zb:29434,cc:3611,ze:3854,Pf:42993,ti:4724,aj:96370,ub:27686,vb:85013,wb:23462,yb:42016,zb:62407,Ab:26926,xb:43781,Bb:51236,Cb:79148,Db:50160,Eb:77504,Qb:87907,Rb:18630,Sb:54445,Tb:80935,Ub:105675,Vb:37521,Wb:47786,Xb:98349,ac:7282,ec:32276,dc:76278,fc:93911,hc:106531,ic:27259,jc:27262,kc:27263,lc:21759,mc:27107,nc:62936,oc:49568,pc:38408,qc:80637,sc:68727,tc:68728,uc:80353,wc:80356,xc:74610,yc:45707,zc:83962,Ac:83970,Bc:46713,Cc:89711,Dc:74612,Ec:93265,Fc:74611,Hc:113533,Ic:93252,
Jc:99357,Lc:94521,Mc:114252,Nc:113532,Oc:94522,Kc:94583,Pc:88E3,Qc:93253,Rc:93254,Sc:94387,Tc:94388,Uc:93255,Vc:97424,Gc:72502,Wc:110111,Xc:76019,Yc:89431,Zc:110466,bd:77240,cd:60508,dd:105350,ed:73393,fd:113534,gd:92098,hd:84517,jd:83759,kd:80357,ld:86113,md:72598,nd:72733,od:107349,pd:97615,qd:31402,rd:84774,sd:95117,td:98930,ud:98931,vd:98932,wd:43347,xd:45474,yd:100352,zd:84758,Ad:98443,Bd:74613,Cd:74614,Dd:64502,Ed:74615,Fd:74616,Gd:74617,Hd:77820,Id:74618,Jd:93278,Kd:93274,Ld:93275,Md:93276,
Nd:22110,Od:29433,Pd:82047,Qd:113550,Rd:75836,Sd:75837,Td:42352,Ud:84512,Vd:76065,Wd:75989,Xd:16623,Yd:32594,Zd:27240,ae:32633,be:74858,de:3945,ce:16989,ee:45520,ge:25488,he:25492,ie:25494,je:55760,ke:14057,le:18451,me:57204,ne:57203,oe:17897,pe:57205,qe:18198,re:17898,se:17909,te:43980,ue:46220,we:11721,xe:49954,ye:96369,Ae:56251,Be:25624,Ce:16906,De:99999,Ee:68172,Fe:27068,Ge:47973,He:72773,Ie:26970,Je:26971,Ke:96805,Le:17752,Me:73233,Ne:109512,Oe:22256,Pe:14115,Qe:22696,Re:89278,Se:89277,Te:109513,
Ue:43278,Ve:43459,We:43464,Xe:89279,Ye:43717,Ze:55764,af:22255,bf:89281,cf:40963,df:43277,ef:43442,ff:91824,gf:96367,hf:36850,jf:72694,kf:37414,lf:36851,mf:73491,nf:54473,pf:43375,qf:46674,rf:32473,sf:72901,tf:72906,uf:50947,vf:50612,wf:50613,xf:50942,yf:84938,zf:84943,Af:84939,Bf:84941,Cf:84944,Df:84940,Ef:84942,Ff:35585,Gf:51926,Hf:79983,If:63238,Jf:18921,Kf:63241,Lf:57893,Mf:41182,Nf:33424,Of:22207,Qf:36229,Rf:22206,Sf:22205,Tf:18993,Uf:19001,Vf:18990,Wf:18991,Xf:18997,Yf:18725,Zf:19003,ag:36874,
cg:44763,dg:33427,eg:67793,fg:22182,gg:37091,hg:34650,jg:50617,kg:47261,lg:22287,mg:25144,ng:97917,og:62397,pg:36961,qg:108035,rg:27426,sg:27857,tg:27846,ug:27854,vg:69692,wg:61411,xg:39299,yg:38696,zg:62520,Ag:36382,Bg:108701,Cg:50663,Dg:36387,Eg:14908,Fg:37533,Gg:105443,Hg:61635,Ig:62274,Jg:65702,Kg:65703,Lg:65701,Mg:76256,Ng:37671,Og:49953,Pg:36216,Qg:28237,Rg:39553,Sg:29222,Tg:26107,Ug:38050,Vg:26108,Wg:26109,Xg:26110,Yg:66881,Zg:28236,ah:14586,bh:57929,dh:74723,eh:44098,fh:44099,gh:23528,hh:61699,
ih:59149,jh:101951,kh:97346,lh:95102,mh:64882,nh:63595,oh:63349,ph:95101,qh:75240,rh:27039,sh:68823,uh:21537,vh:83464,wh:75707,xh:83113,yh:101952,zh:101953,Ah:79610,Bh:24402,Ch:24400,Dh:32925,Eh:57173,Fh:64423,Gh:64424,Hh:33986,Ih:100828,Jh:21409,Kh:11070,Lh:11074,Mh:17880,Nh:14001,Ph:30709,Qh:30707,Rh:30711,Sh:30710,Th:30708,Oh:26984,Uh:63648,Vh:63649,Wh:51879,Xh:111059,Yh:5754,Zh:20445,ai:110386,bi:113746,ci:66557,di:17310,fi:28631,gi:21589,hi:68012,ii:60480,ji:31571,ki:76980,li:41577,mi:45469,
ni:38669,oi:13768,ri:13777,si:62985,vi:59369,wi:43927,xi:43928,yi:12924,zi:100355,Bi:56219,Ci:27669,Di:10337,Ai:47896,Ei:107598,Fi:96639,Gi:107536,Hi:96661,Ii:96658,Ji:96660,Ki:104443,Li:96659,Mi:106442,Ni:63667,Oi:63668,Pi:63669,Qi:78314,Ri:55761,Si:96368,Ti:67374,Ui:48992,Vi:49956,Wi:31961,Xi:26388,Yi:23811,Zi:5E4,bj:47355,cj:47356,dj:37935,ej:45521,fj:21760,gj:83769,hj:49977,ij:49974,jj:93497,kj:93498,lj:34325,mj:100081,nj:35309,oj:68314,pj:25602,qj:100339,rj:59018,sj:18248,tj:50625,uj:9729,vj:37168,
wj:37169,xj:21667,yj:16749,zj:18635,Aj:39305,Bj:18046,Cj:53969,Dj:8213,Ej:93926,Fj:102852,Gj:110099,Hj:22678,Ij:69076,Jj:100856,Kj:17736,Lj:3832,Mj:55759,Nj:64031,Oj:93044,Pj:93045,Qj:34388,Rj:17657,Sj:17655,Tj:39579,Uj:39578,Vj:77448,Wj:8196,Xj:11357,Yj:69877,Zj:8197,ak:82039};function Tj(a){a=a||{};var b={},c={};this.url=a.url||"";this.args=a.args||mb(b);this.assets=a.assets||{};this.attrs=a.attrs||mb(c);this.fallback=a.fallback||null;this.fallbackMessage=a.fallbackMessage||null;this.html5=!!a.html5;this.disable=a.disable||{};this.loaded=!!a.loaded;this.messages=a.messages||{}}
Tj.prototype.clone=function(){var a=new Tj,b;for(b in this)if(this.hasOwnProperty(b)){var c=this[b];"object"==La(c)?a[b]=mb(c):a[b]=c}return a};function Uj(){L.call(this);this.f=[]}
v(Uj,L);Uj.prototype.u=function(){for(;this.f.length;){var a=this.f.pop();a.target.removeEventListener(a.name,a.Ja)}L.prototype.u.call(this)};var Vj=/cssbin\/(?:debug-)?([a-zA-Z0-9_-]+?)(?:-2x|-web|-rtl|-vfl|.css)/;function Wj(a){a=a||"";if(window.spf){var b=a.match(Vj);spf.style.load(a,b?b[1]:"",void 0)}else Xj(a)}
function Xj(a){var b=Yj(a),c=document.getElementById(b),d=c&&Mf(c,"loaded");d||c&&!d||(c=Zj(a,b,function(){Mf(c,"loaded")||(Kf(c),Wf(b),R(Sa(Xf,b),0))}))}
function Zj(a,b,c){var d=document.createElement("link");d.id=b;d.onload=function(){c&&setTimeout(c,0)};
a=ad(a);d.rel="stylesheet";d.href=ub(a).toString();(document.getElementsByTagName("head")[0]||document.body).appendChild(d);return d}
function Yj(a){var b=Nc(document,"A");Sb(b,new I(a,Fb));a=b.href.replace(/^[a-zA-Z]+:\/\//,"//");return"css-"+Vb(a)}
;function ak(a,b,c,d){L.call(this);var e=this;this.m=this.ca=a;this.H=b;this.o=!1;this.api={};this.aa=this.G=null;this.I=new N;Vc(this,Sa(Wc,this.I));this.j={};this.S=this.ba=this.i=this.ja=this.f=null;this.R=!1;this.l=this.B=null;this.da={};this.Ga=["onReady"];this.ia=null;this.ta=NaN;this.Y={};this.h=d;bk(this);this.ea("WATCH_LATER_VIDEO_ADDED",this.bb.bind(this));this.ea("WATCH_LATER_VIDEO_REMOVED",this.cb.bind(this));this.ea("onAdAnnounce",this.Ia.bind(this));this.Ha=new Uj(this);Vc(this,Sa(Wc,
this.Ha));this.Z=0;c?this.Z=R(function(){e.loadNewVideoConfig(c)},0):d&&(ck(this),dk(this))}
v(ak,L);n=ak.prototype;n.getId=function(){return this.H};
n.loadNewVideoConfig=function(a){if(!this.g){this.Z&&(Of(this.Z),this.Z=0);a instanceof Tj||(a=new Tj(a));this.ja=a;this.f=a.clone();ck(this);this.ba||(this.ba=ek(this,this.f.args.jsapicallback||"onYouTubePlayerReady"));this.f.args.jsapicallback=null;if(a=this.f.attrs.width)this.m.style.width=cd(Number(a)||String(a));if(a=this.f.attrs.height)this.m.style.height=cd(Number(a)||String(a));dk(this);this.o&&fk(this)}};
function ck(a){var b;a.h?b=a.h.rootElementId:b=a.f.attrs.id;a.i=b||a.i;"video-player"==a.i&&(a.i=a.H,a.h?a.h.rootElementId=a.H:a.f.attrs.id=a.H);a.m.id==a.i&&(a.i+="-player",a.h?a.h.rootElementId=a.i:a.f.attrs.id=a.i)}
n.Oa=function(){return this.ja};
function fk(a){a.f&&!a.f.loaded&&(a.f.loaded=!0,"0"!=a.f.args.autoplay?a.api.loadVideoByPlayerVars(a.f.args):a.api.cueVideoByPlayerVars(a.f.args))}
function gk(a){var b=!0,c=hk(a);c&&a.f&&(a=ik(a),b=Mf(c,"version")===a);return b&&!!z("yt.player.Application.create")}
function dk(a){if(!a.g&&!a.R){var b=gk(a);if(b&&"html5"==(hk(a)?"html5":null))a.S="html5",a.o||jk(a);else if(kk(a),a.S="html5",b&&a.l)a.ca.appendChild(a.l),jk(a);else{a.f&&(a.f.loaded=!0);var c=!1;a.B=function(){c=!0;var d=lk(a,"player_bootstrap_method")?z("yt.player.Application.createAlternate")||z("yt.player.Application.create"):z("yt.player.Application.create");var e=a.f?a.f.clone():void 0;d(a.ca,e,a.h);jk(a)};
a.R=!0;b?a.B():(ag(ik(a),a.B),(b=a.h?a.h.cssUrl:a.f.assets.css)&&Wj(b),mk(a)&&!c&&y("yt.player.Application.create",null,void 0))}}}
function hk(a){var b=Jc(a.i);!b&&a.m&&a.m.querySelector&&(b=a.m.querySelector("#"+a.i));return b}
function jk(a){if(!a.g){var b=hk(a),c=!1;b&&b.getApiInterface&&b.getApiInterface()&&(c=!0);c?(a.R=!1,!lk(a,"html5_remove_not_servable_check_killswitch")&&b.isNotServable&&a.f&&b.isNotServable(a.f.args.video_id)||nk(a)):a.ta=R(function(){jk(a)},50)}}
function nk(a){bk(a);a.o=!0;var b=hk(a);b.addEventListener&&(a.G=ok(a,b,"addEventListener"));b.removeEventListener&&(a.aa=ok(a,b,"removeEventListener"));var c=b.getApiInterface();c=c.concat(b.getInternalApiInterface());for(var d=0;d<c.length;d++){var e=c[d];a.api[e]||(a.api[e]=ok(a,b,e))}for(var f in a.j)a.G(f,a.j[f]);fk(a);a.ba&&a.ba(a.api);a.I.O("onReady",a.api)}
function ok(a,b,c){var d=b[c];return function(){try{return a.ia=null,d.apply(b,arguments)}catch(e){"sendAbandonmentPing"!=c&&(e.params=c,a.ia=e,Ef(e))}}}
function bk(a){a.o=!1;if(a.aa)for(var b in a.j)a.aa(b,a.j[b]);for(var c in a.Y)Of(parseInt(c,10));a.Y={};a.G=null;a.aa=null;for(var d in a.api)a.api[d]=null;a.api.addEventListener=a.ea.bind(a);a.api.removeEventListener=a.ib.bind(a);a.api.destroy=a.dispose.bind(a);a.api.getLastError=a.Pa.bind(a);a.api.getPlayerType=a.Qa.bind(a);a.api.getCurrentVideoConfig=a.Oa.bind(a);a.api.loadNewVideoConfig=a.loadNewVideoConfig.bind(a);a.api.isReady=a.Za.bind(a)}
n.Za=function(){return this.o};
n.ea=function(a,b){var c=this,d=ek(this,b);if(d){if(!(0<=Xa(this.Ga,a)||this.j[a])){var e=pk(this,a);this.G&&this.G(a,e)}this.I.subscribe(a,d);"onReady"==a&&this.o&&R(function(){d(c.api)},0)}};
n.ib=function(a,b){if(!this.g){var c=ek(this,b);c&&ff(this.I,a,c)}};
function ek(a,b){var c=b;if("string"==typeof b){if(a.da[b])return a.da[b];c=function(){var d=z(b);d&&d.apply(x,arguments)};
a.da[b]=c}return c?c:null}
function pk(a,b){var c="ytPlayer"+b+a.H;a.j[b]=c;x[c]=function(d){var e=R(function(){if(!a.g){a.I.O(b,d);var f=a.Y,g=String(e);g in f&&delete f[g]}},0);
kb(a.Y,String(e))};
return c}
n.Ia=function(a){Wf("a11y-announce",a)};
n.bb=function(a){Wf("WATCH_LATER_VIDEO_ADDED",a)};
n.cb=function(a){Wf("WATCH_LATER_VIDEO_REMOVED",a)};
n.Qa=function(){return this.S||(hk(this)?"html5":null)};
n.Pa=function(){return this.ia};
function kk(a){a.cancel();bk(a);a.S=null;a.f&&(a.f.loaded=!1);var b=hk(a);b&&(gk(a)||!mk(a)?a.l=b:(b&&b.destroy&&b.destroy(),a.l=null));for(a=a.ca;b=a.firstChild;)a.removeChild(b)}
n.cancel=function(){if(this.B){var a=ik(this);gg(a,this.B)}Of(this.ta);this.R=!1};
n.u=function(){kk(this);if(this.l&&this.f&&this.l.destroy)try{this.l.destroy()}catch(b){Df(b)}this.da=null;for(var a in this.j)x[this.j[a]]=null;this.ja=this.f=this.api=null;delete this.ca;delete this.m;L.prototype.u.call(this)};
function mk(a){return a.f&&a.f.args&&a.f.args.fflags?-1!=a.f.args.fflags.indexOf("player_destroy_old_version=true"):!1}
function ik(a){return a.h?a.h.jsUrl:a.f.assets.js}
function lk(a,b){if(a.h)var c=a.h.serializedExperimentFlags;else a.f&&a.f.args&&(c=a.f.args.fflags);return"true"==eh(c||"")[b]}
;var qk={},rk="player_uid_"+(1E9*Math.random()>>>0);
function sk(a,b,c){var d="player";c=void 0===c?!0:c;var e;"string"===typeof d?e=Jc(d):e=d;d=e;e=rk+"_"+Na(d);var f=qk[e];if(f&&c)return(b&&b.serializedExperimentFlags?b.serializedExperimentFlags.includes("web_player_remove_playerproxy=true"):a&&a.args&&a.args.fflags&&a.args.fflags.includes("web_player_remove_playerproxy=true"))?f.api.loadVideoByPlayerVars(a.args||null):f.loadNewVideoConfig(a),f.api;f=new ak(d,e,a,b);qk[e]=f;Wf("player-added",f.api);Vc(f,Sa(tk,f));return f.api}
function tk(a){delete qk[a.getId()]}
;function uk(a){return(0===a.search("cue")||0===a.search("load"))&&"loadModule"!==a}
function vk(a,b,c){"string"===typeof a&&(a={mediaContentUrl:a,startSeconds:b,suggestedQuality:c});a:{if((b=a.mediaContentUrl)&&(b=/\/([ve]|embed)\/([^#?]+)/.exec(b))&&b[2]){b=b[2];break a}b=null}a.videoId=b;return wk(a)}
function wk(a,b,c){if("string"===typeof a)return{videoId:a,startSeconds:b,suggestedQuality:c};b=["endSeconds","startSeconds","mediaContentUrl","suggestedQuality","videoId"];c={};for(var d=0;d<b.length;d++){var e=b[d];a[e]&&(c[e]=a[e])}return c}
function xk(a,b,c,d){if(C(a)&&!Array.isArray(a)){b="playlist list listType index startSeconds suggestedQuality".split(" ");c={};for(d=0;d<b.length;d++){var e=b[d];a[e]&&(c[e]=a[e])}return c}b={index:b,startSeconds:c,suggestedQuality:d};"string"===typeof a&&16===a.length?b.list="PL"+a:b.playlist=a;return b}
;function yk(a){a=void 0===a?!1:a;L.call(this);this.f=new N(a);Vc(this,Sa(Wc,this.f))}
G(yk,L);yk.prototype.subscribe=function(a,b,c){return this.g?0:this.f.subscribe(a,b,c)};
yk.prototype.j=function(a,b){this.g||this.f.O.apply(this.f,arguments)};function zk(a,b,c){yk.call(this);this.h=a;this.i=b;this.l=c}
v(zk,yk);function Ak(a,b,c){if(!a.g){var d=a.h;d.g||a.i!=d.f||(a={id:a.l,command:b},c&&(a.data=c),d.f.postMessage(Fe(a),d.i))}}
zk.prototype.u=function(){this.i=this.h=null;yk.prototype.u.call(this)};function Bk(a){L.call(this);this.f=a;this.f.subscribe("command",this.Ea,this);this.h={};this.j=!1}
v(Bk,L);n=Bk.prototype;n.start=function(){this.j||this.g||(this.j=!0,Ak(this.f,"RECEIVING"))};
n.Ea=function(a,b,c){if(this.j&&!this.g){var d=b||{};switch(a){case "addEventListener":"string"===typeof d.event&&(a=d.event,a in this.h||(c=D(this.kb,this,a),this.h[a]=c,this.addEventListener(a,c)));break;case "removeEventListener":"string"===typeof d.event&&Ck(this,d.event);break;default:this.i.isReady()&&this.i.isExternalMethodAvailable(a,c||null)&&(b=Dk(a,b||{}),c=this.i.handleExternalCall(a,b,c||null),(c=Ek(a,c))&&this.j&&!this.g&&Ak(this.f,a,c))}}};
n.kb=function(a,b){this.j&&!this.g&&Ak(this.f,a,this.la(a,b))};
n.la=function(a,b){if(null!=b)return{value:b}};
function Ck(a,b){b in a.h&&(a.removeEventListener(b,a.h[b]),delete a.h[b])}
n.u=function(){var a=this.f;a.g||ff(a.f,"command",this.Ea,this);this.f=null;for(var b in this.h)Ck(this,b);L.prototype.u.call(this)};function Fk(a,b){Bk.call(this,b);this.i=a;this.start()}
v(Fk,Bk);Fk.prototype.addEventListener=function(a,b){this.i.addEventListener(a,b)};
Fk.prototype.removeEventListener=function(a,b){this.i.removeEventListener(a,b)};
function Dk(a,b){switch(a){case "loadVideoById":return b=wk(b),[b];case "cueVideoById":return b=wk(b),[b];case "loadVideoByPlayerVars":return[b];case "cueVideoByPlayerVars":return[b];case "loadPlaylist":return b=xk(b),[b];case "cuePlaylist":return b=xk(b),[b];case "seekTo":return[b.seconds,b.allowSeekAhead];case "playVideoAt":return[b.index];case "setVolume":return[b.volume];case "setPlaybackQuality":return[b.suggestedQuality];case "setPlaybackRate":return[b.suggestedRate];case "setLoop":return[b.loopPlaylists];
case "setShuffle":return[b.shufflePlaylist];case "getOptions":return[b.module];case "getOption":return[b.module,b.option];case "setOption":return[b.module,b.option,b.value];case "handleGlobalKeyDown":return[b.keyCode,b.shiftKey,b.ctrlKey,b.altKey,b.metaKey,b.key,b.code]}return[]}
function Ek(a,b){switch(a){case "isMuted":return{muted:b};case "getVolume":return{volume:b};case "getPlaybackRate":return{playbackRate:b};case "getAvailablePlaybackRates":return{availablePlaybackRates:b};case "getVideoLoadedFraction":return{videoLoadedFraction:b};case "getPlayerState":return{playerState:b};case "getCurrentTime":return{currentTime:b};case "getPlaybackQuality":return{playbackQuality:b};case "getAvailableQualityLevels":return{availableQualityLevels:b};case "getDuration":return{duration:b};
case "getVideoUrl":return{videoUrl:b};case "getVideoEmbedCode":return{videoEmbedCode:b};case "getPlaylist":return{playlist:b};case "getPlaylistIndex":return{playlistIndex:b};case "getOptions":return{options:b};case "getOption":return{option:b}}}
Fk.prototype.la=function(a,b){switch(a){case "onReady":return;case "onStateChange":return{playerState:b};case "onPlaybackQualityChange":return{playbackQuality:b};case "onPlaybackRateChange":return{playbackRate:b};case "onError":return{errorCode:b}}return Bk.prototype.la.call(this,a,b)};
Fk.prototype.u=function(){Bk.prototype.u.call(this);delete this.i};function Gk(a,b,c){L.call(this);var d=this;c=c||P("POST_MESSAGE_ORIGIN",void 0)||window.document.location.protocol+"//"+window.document.location.hostname;this.h=b||null;this.o="*";this.i=c;this.sessionId=null;this.channel="widget";this.B=!!a;this.m=function(e){a:if(!("*"!=d.i&&e.origin!=d.i||d.h&&e.source!=d.h||"string"!==typeof e.data)){try{var f=JSON.parse(e.data)}catch(g){break a}if(!(null==f||d.B&&(d.sessionId&&d.sessionId!=f.id||d.channel&&d.channel!=f.channel))&&f)switch(f.event){case "listening":"null"!=
e.origin&&(d.i=d.o=e.origin);d.h=e.source;d.sessionId=f.id;d.f&&(d.f(),d.f=null);break;case "command":d.j&&(!d.l||0<=Xa(d.l,f.func))&&d.j(f.func,f.args,e.origin)}}};
this.l=this.f=this.j=null;window.addEventListener("message",this.m)}
v(Gk,L);Gk.prototype.sendMessage=function(a,b){var c=b||this.h;if(c){this.sessionId&&(a.id=this.sessionId);this.channel&&(a.channel=this.channel);try{var d=JSON.stringify(a);c.postMessage(d,this.o)}catch(e){Ef(e)}}};
Gk.prototype.u=function(){window.removeEventListener("message",this.m);L.prototype.u.call(this)};function Hk(){var a=this.g=new Gk(!!P("WIDGET_ID_ENFORCE")),b=D(this.hb,this);a.j=b;a.l=null;this.g.channel="widget";if(a=P("WIDGET_ID"))this.g.sessionId=a;this.i=[];this.l=!1;this.j={}}
n=Hk.prototype;n.hb=function(a,b,c){"addEventListener"==a&&b?(a=b[0],this.j[a]||"onReady"==a||(this.addEventListener(a,Ik(this,a)),this.j[a]=!0)):this.Aa(a,b,c)};
n.Aa=function(){};
function Ik(a,b){return D(function(c){this.sendMessage(b,c)},a)}
n.addEventListener=function(){};
n.Na=function(){this.l=!0;this.sendMessage("initialDelivery",this.ma());this.sendMessage("onReady");H(this.i,this.Fa,this);this.i=[]};
n.ma=function(){return null};
function Jk(a,b){a.sendMessage("infoDelivery",b)}
n.Fa=function(a){this.l?this.g.sendMessage(a):this.i.push(a)};
n.sendMessage=function(a,b){this.Fa({event:a,info:void 0==b?null:b})};
n.dispose=function(){this.g=null};function Kk(a){Hk.call(this);this.f=a;this.h=[];this.addEventListener("onReady",D(this.eb,this));this.addEventListener("onVideoProgress",D(this.ob,this));this.addEventListener("onVolumeChange",D(this.pb,this));this.addEventListener("onApiChange",D(this.jb,this));this.addEventListener("onPlaybackQualityChange",D(this.lb,this));this.addEventListener("onPlaybackRateChange",D(this.mb,this));this.addEventListener("onStateChange",D(this.nb,this));this.addEventListener("onWebglSettingsChanged",D(this.qb,
this))}
v(Kk,Hk);n=Kk.prototype;n.Aa=function(a,b,c){if(this.f.isExternalMethodAvailable(a,c)){b=b||[];if(0<b.length&&uk(a)){var d=b;if(C(d[0])&&!Array.isArray(d[0]))d=d[0];else{var e={};switch(a){case "loadVideoById":case "cueVideoById":e=wk.apply(window,d);break;case "loadVideoByUrl":case "cueVideoByUrl":e=vk.apply(window,d);break;case "loadPlaylist":case "cuePlaylist":e=xk.apply(window,d)}d=e}b.length=1;b[0]=d}this.f.handleExternalCall(a,b,c);uk(a)&&Jk(this,this.ma())}};
n.eb=function(){var a=D(this.Na,this);this.g.f=a};
n.addEventListener=function(a,b){this.h.push({eventType:a,listener:b});this.f.addEventListener(a,b)};
n.ma=function(){if(!this.f)return null;var a=this.f.getApiInterface();cb(a,"getVideoData");for(var b={apiInterface:a},c=0,d=a.length;c<d;c++){var e=a[c];if(0===e.search("get")||0===e.search("is")){var f=0;0===e.search("get")?f=3:0===e.search("is")&&(f=2);f=e.charAt(f).toLowerCase()+e.substr(f+1);try{var g=this.f[e]();b[f]=g}catch(h){}}}b.videoData=this.f.getVideoData();b.currentTimeLastUpdated_=E()/1E3;return b};
n.nb=function(a){a={playerState:a,currentTime:this.f.getCurrentTime(),duration:this.f.getDuration(),videoData:this.f.getVideoData(),videoStartBytes:0,videoBytesTotal:this.f.getVideoBytesTotal(),videoLoadedFraction:this.f.getVideoLoadedFraction(),playbackQuality:this.f.getPlaybackQuality(),availableQualityLevels:this.f.getAvailableQualityLevels(),currentTimeLastUpdated_:E()/1E3,playbackRate:this.f.getPlaybackRate(),mediaReferenceTime:this.f.getMediaReferenceTime()};this.f.getVideoUrl&&(a.videoUrl=
this.f.getVideoUrl());this.f.getVideoContentRect&&(a.videoContentRect=this.f.getVideoContentRect());this.f.getProgressState&&(a.progressState=this.f.getProgressState());this.f.getPlaylist&&(a.playlist=this.f.getPlaylist());this.f.getPlaylistIndex&&(a.playlistIndex=this.f.getPlaylistIndex());this.f.getStoryboardFormat&&(a.storyboardFormat=this.f.getStoryboardFormat());Jk(this,a)};
n.lb=function(a){Jk(this,{playbackQuality:a})};
n.mb=function(a){Jk(this,{playbackRate:a})};
n.jb=function(){for(var a=this.f.getOptions(),b={namespaces:a},c=0,d=a.length;c<d;c++){var e=a[c],f=this.f.getOptions(e);b[e]={options:f};for(var g=0,h=f.length;g<h;g++){var k=f[g],l=this.f.getOption(e,k);b[e][k]=l}}this.sendMessage("apiInfoDelivery",b)};
n.pb=function(){Jk(this,{muted:this.f.isMuted(),volume:this.f.getVolume()})};
n.ob=function(a){a={currentTime:a,videoBytesLoaded:this.f.getVideoBytesLoaded(),videoLoadedFraction:this.f.getVideoLoadedFraction(),currentTimeLastUpdated_:E()/1E3,playbackRate:this.f.getPlaybackRate(),mediaReferenceTime:this.f.getMediaReferenceTime()};this.f.getProgressState&&(a.progressState=this.f.getProgressState());Jk(this,a)};
n.qb=function(){var a={sphericalProperties:this.f.getSphericalProperties()};Jk(this,a)};
n.dispose=function(){Hk.prototype.dispose.call(this);for(var a=0;a<this.h.length;a++){var b=this.h[a];this.f.removeEventListener(b.eventType,b.listener)}this.h=[]};function Lk(a,b,c){L.call(this);this.f=a;this.i=c;this.j=wg(window,"message",D(this.l,this));this.h=new zk(this,a,b);Vc(this,Sa(Wc,this.h))}
v(Lk,L);Lk.prototype.l=function(a){var b;if(b=!this.g)if(b=a.origin==this.i)a:{b=this.f;do{b:{var c=a.source;do{if(c==b){c=!0;break b}if(c==c.parent)break;c=c.parent}while(null!=c);c=!1}if(c){b=!0;break a}b=b.opener}while(null!=b);b=!1}if(b&&(b=a.data,"string"===typeof b)){try{b=JSON.parse(b)}catch(d){return}b.command&&(c=this.h,c.g||c.j("command",b.command,b.data,a.origin))}};
Lk.prototype.u=function(){xg(this.j);this.f=null;L.prototype.u.call(this)};function Mk(){var a=mb(Nk),b;return Ve(new M(function(c,d){a.onSuccess=function(e){oh(e)?c(e):d(new Ok("Request failed, status="+(e&&"status"in e?e.status:-1),"net.badstatus",e))};
a.onError=function(e){d(new Ok("Unknown request error","net.unknown",e))};
a.X=function(e){d(new Ok("Request timed out","net.timeout",e))};
b=xh("//googleads.g.doubleclick.net/pagead/id",a)}),function(c){c instanceof We&&b.abort();
return Qe(c)})}
function Ok(a,b,c){Ua.call(this,a+", errorCode="+b);this.errorCode=b;this.xhr=c;this.name="PromiseAjaxError"}
v(Ok,Ua);function Pk(){this.g=0;this.f=null}
Pk.prototype.then=function(a,b,c){return 1===this.g&&a?(a=a.call(c,this.f),Le(a)?a:Qk(a)):2===this.g&&b?(a=b.call(c,this.f),Le(a)?a:Rk(a)):this};
Pk.prototype.getValue=function(){return this.f};
Pk.prototype.$goog_Thenable=!0;function Rk(a){var b=new Pk;a=void 0===a?null:a;b.g=2;b.f=void 0===a?null:a;return b}
function Qk(a){var b=new Pk;a=void 0===a?null:a;b.g=1;b.f=void 0===a?null:a;return b}
;function Sk(a){Ua.call(this,a.message||a.description||a.name);this.isMissing=a instanceof Tk;this.isTimeout=a instanceof Ok&&"net.timeout"==a.errorCode;this.isCanceled=a instanceof We}
v(Sk,Ua);Sk.prototype.name="BiscottiError";function Tk(){Ua.call(this,"Biscotti ID is missing from server")}
v(Tk,Ua);Tk.prototype.name="BiscottiMissingError";var Nk={format:"RAW",method:"GET",timeout:5E3,withCredentials:!0},Uk=null;
function bh(){if(Q("disable_biscotti_fetch_on_html5_clients"))return Qe(Error("Fetching biscotti ID is disabled."));if(Q("condition_biscotti_fetch_on_consent_cookie_html5_clients")&&!Fc.get("CONSENT","").startsWith("YES+"))return Qe(Error("User has not consented - not fetching biscotti id."));if("1"===gb(zf(),"args","privembed"))return Qe(Error("Biscotti ID is not available in private embed mode"));Uk||(Uk=Ve(Mk().then(Vk),function(a){return Wk(2,a)}));
return Uk}
function Vk(a){a=a.responseText;if(0!=a.lastIndexOf(")]}'",0))throw new Tk;a=JSON.parse(a.substr(4));if(1<(a.type||1))throw new Tk;a=a.id;ch(a);Uk=Qk(a);Xk(18E5,2);return a}
function Wk(a,b){var c=new Sk(b);ch("");Uk=Rk(c);0<a&&Xk(12E4,a-1);throw c;}
function Xk(a,b){R(function(){Ve(Mk().then(Vk,function(c){return Wk(b,c)}),Ja)},a)}
function Yk(){try{var a=z("yt.ads.biscotti.getId_");return a?a():bh()}catch(b){return Qe(b)}}
;function Zk(a){if("1"!==gb(zf(),"args","privembed")){a&&ah();try{Yk().then(function(){},function(){}),R(Zk,18E5)}catch(b){Df(b)}}}
;var X=z("ytglobal.prefsUserPrefsPrefs_")||{};y("ytglobal.prefsUserPrefsPrefs_",X,void 0);function $k(){this.f=P("ALT_PREF_COOKIE_NAME","PREF");var a=Fc.get(""+this.f,void 0);if(a){a=decodeURIComponent(a).split("&");for(var b=0;b<a.length;b++){var c=a[b].split("="),d=c[0];(c=c[1])&&(X[d]=c.toString())}}}
n=$k.prototype;n.get=function(a,b){al(a);bl(a);var c=void 0!==X[a]?X[a].toString():null;return null!=c?c:b?b:""};
n.set=function(a,b){al(a);bl(a);if(null==b)throw Error("ExpectedNotNull");X[a]=b.toString()};
n.remove=function(a){al(a);bl(a);delete X[a]};
n.save=function(){Hf(this.f,this.dump(),63072E3)};
n.clear=function(){for(var a in X)delete X[a]};
n.dump=function(){var a=[],b;for(b in X)a.push(b+"="+encodeURIComponent(String(X[b])));return a.join("&")};
function bl(a){if(/^f([1-9][0-9]*)$/.test(a))throw Error("ExpectedRegexMatch: "+a);}
function al(a){if(!/^\w+$/.test(a))throw Error("ExpectedRegexMismatch: "+a);}
function cl(a){a=void 0!==X[a]?X[a].toString():null;return null!=a&&/^[A-Fa-f0-9]+$/.test(a)?parseInt(a,16):null}
Ka($k);function dl(){this.g=new Set;this.f=new Set;this.h=new Map}
dl.prototype.clear=function(){this.g.clear();this.f.clear();this.h.clear()};
Ka(dl);var el={},fl=(el[0]=[],el[1]=[],el);function gl(a,b){for(var c=[],d=1;d<arguments.length;++d)c[d-1]=arguments[d];if(!hl(a)||c.some(function(e){return!hl(e)}))throw Error("Only objects may be merged.");
c=u(c);for(d=c.next();!d.done;d=c.next())il(a,d.value);return a}
function il(a,b){for(var c in b)if(hl(b[c])){if(c in a&&!hl(a[c]))throw Error("Cannot merge an object into a non-object.");c in a||(a[c]={});il(a[c],b[c])}else if(jl(b[c])){if(c in a&&!jl(a[c]))throw Error("Cannot merge an array into a non-array.");c in a||(a[c]=[]);kl(a[c],b[c])}else a[c]=b[c];return a}
function kl(a,b){for(var c=u(b),d=c.next();!d.done;d=c.next())d=d.value,hl(d)?a.push(il({},d)):jl(d)?a.push(kl([],d)):a.push(d);return a}
function hl(a){return"object"===typeof a&&!Array.isArray(a)}
function jl(a){return"object"===typeof a&&Array.isArray(a)}
;var ll={},ml=0;
function nl(a,b,c,d,e){e=void 0===e?"":e;if(a)if(c&&!yi("cobalt")){if(a){a instanceof I||(a="object"==typeof a&&a.U?a.T():String(a),Jb.test(a)?a=new I(a,Fb):(a=String(a),a=a.replace(/(%0A|%0D)/g,""),a=(b=a.match(Ib))&&Hb.test(b[1])?new I(a,Fb):null));a=Gb(a||Lb);if("about:invalid#zClosurez"===a||a.startsWith("data"))a="";else{if(!(a instanceof Pb)){b="object"==typeof a;var f=null;b&&a.na&&(f=a.ka());a=Rb(wb(b&&a.U?a.T():String(a)),f)}a instanceof Pb&&a.constructor===Pb?a=a.f:(La(a),a="type_error:SafeHtml");
a=encodeURIComponent(String(Fe(a.toString())))}/^[\s\xa0]*$/.test(a)||(a=Mc("IFRAME",{src:'javascript:"<body><img src=\\""+'+a+'+"\\"></body>"',style:"display:none"}),(9==a.nodeType?a:a.ownerDocument||a.document).body.appendChild(a))}}else if(e)yh(a,b,"POST",e,d);else if(P("USE_NET_AJAX_FOR_PING_TRANSPORT",!1)||d)yh(a,b,"GET","",d);else{b:{try{var g=new Va({url:a});if(g.h&&g.g||g.i){var h=Xb(a.match(Wb)[5]||null),k;if(!(k=!h||!h.endsWith("/aclk"))){var l=a.search(bc);d:{for(c=0;0<=(c=a.indexOf("ri",
c))&&c<l;){var m=a.charCodeAt(c-1);if(38==m||63==m){var p=a.charCodeAt(c+2);if(!p||61==p||38==p||35==p){var q=c;break d}}c+=3}q=-1}if(0>q)var r=null;else{var A=a.indexOf("&",q);if(0>A||A>l)A=l;q+=3;r=decodeURIComponent(a.substr(q,A-q).replace(/\+/g," "))}k="1"!==r}f=!k;break b}}catch(B){}f=!1}f?ol(a)?(b&&b(),f=!0):f=!1:f=!1;f||pl(a,b)}}
function ol(a,b){try{if(window.navigator&&window.navigator.sendBeacon&&window.navigator.sendBeacon(a,void 0===b?"":b))return!0}catch(c){}return!1}
function pl(a,b){var c=new Image,d=""+ml++;ll[d]=c;c.onload=c.onerror=function(){b&&ll[d]&&b();delete ll[d]};
c.src=a}
;function ql(a,b){wj.call(this,1,arguments)}
v(ql,wj);function rl(a,b){wj.call(this,1,arguments)}
v(rl,wj);var sl=new xj("aft-recorded",ql),tl=new xj("timing-sent",rl);var ul=window;function vl(){this.timing={};this.clearResourceTimings=function(){};
this.webkitClearResourceTimings=function(){};
this.mozClearResourceTimings=function(){};
this.msClearResourceTimings=function(){};
this.oClearResourceTimings=function(){}}
var wl=ul.performance||ul.mozPerformance||ul.msPerformance||ul.webkitPerformance||new vl;var xl=!1;D(wl.clearResourceTimings||wl.webkitClearResourceTimings||wl.mozClearResourceTimings||wl.msClearResourceTimings||wl.oClearResourceTimings||Ja,wl);function yl(a){var b=zl(a);if(b.aft)return b.aft;a=P((a||"")+"TIMING_AFT_KEYS",["ol"]);for(var c=a.length,d=0;d<c;d++){var e=b[a[d]];if(e)return e}return NaN}
function Al(a){var b;(b=z("ytcsi."+(a||"")+"data_"))||(b={tick:{},info:{}},F("ytcsi."+(a||"")+"data_",b));return b}
function Bl(a){a=Al(a);a.info||(a.info={});return a.info}
function zl(a){a=Al(a);a.tick||(a.tick={});return a.tick}
function Cl(a){var b=Al(a).nonce;b||(b=hj(),Al(a).nonce=b);return b}
function Dl(a){var b=zl(a||""),c=yl(a);c&&!xl&&(Cj(sl,new ql(Math.round(c-b._start),a)),xl=!0)}
;function El(){var a=z("ytcsi.debug");a||(a=[],y("ytcsi.debug",a,void 0),y("ytcsi.reference",{},void 0));return a}
function Fl(a){a=a||"";var b=z("ytcsi.reference");b||(El(),b=z("ytcsi.reference"));if(b[a])return b[a];var c=El(),d={timerName:a,info:{},tick:{},span:{}};c.push(d);return b[a]=d}
;var Gl=x.ytLoggingLatencyUsageStats_||{};y("ytLoggingLatencyUsageStats_",Gl,void 0);function Hl(){this.f=0}
function Il(){Hl.f||(Hl.f=new Hl);return Hl.f}
Hl.prototype.tick=function(a,b,c){Jl(this,"tick_"+a+"_"+b)||Pi("latencyActionTicked",{tickName:a,clientActionNonce:b},{timestamp:c})};
Hl.prototype.info=function(a,b){var c=Object.keys(a).join("");Jl(this,"info_"+c+"_"+b)||(c=Object.assign({},a),c.clientActionNonce=b,Pi("latencyActionInfo",c))};
Hl.prototype.span=function(a,b){var c=Object.keys(a).join("");Jl(this,"span_"+c+"_"+b)||(a.clientActionNonce=b,Pi("latencyActionSpan",a))};
function Jl(a,b){Gl[b]=Gl[b]||{count:0};var c=Gl[b];c.count++;c.time=S();a.f||(a.f=jg(function(){var d=S(),e;for(e in Gl)Gl[e]&&6E4<d-Gl[e].time&&delete Gl[e];a&&(a.f=0)},0,5E3));
return 5<c.count?(6===c.count&&1>1E5*Math.random()&&(c=new Zh("CSI data exceeded logging limit with key",b.split("_")),0<=b.indexOf("plev")||Zi(c)),!0):!1}
;var Y={},Kl=(Y.ad_allowed="adTypesAllowed",Y.yt_abt="adBreakType",Y.ad_cpn="adClientPlaybackNonce",Y.ad_docid="adVideoId",Y.yt_ad_an="adNetworks",Y.ad_at="adType",Y.aida="appInstallDataAgeMs",Y.browse_id="browseId",Y.p="httpProtocol",Y.t="transportProtocol",Y.cpn="clientPlaybackNonce",Y.ccs="creatorInfo.creatorCanaryState",Y.cseg="creatorInfo.creatorSegment",Y.csn="clientScreenNonce",Y.docid="videoId",Y.GetHome_rid="requestIds",Y.GetSearch_rid="requestIds",Y.GetPlayer_rid="requestIds",Y.GetWatchNext_rid=
"requestIds",Y.GetBrowse_rid="requestIds",Y.GetLibrary_rid="requestIds",Y.is_continuation="isContinuation",Y.is_nav="isNavigation",Y.b_p="kabukiInfo.browseParams",Y.is_prefetch="kabukiInfo.isPrefetch",Y.is_secondary_nav="kabukiInfo.isSecondaryNav",Y.prev_browse_id="kabukiInfo.prevBrowseId",Y.query_source="kabukiInfo.querySource",Y.voz_type="kabukiInfo.vozType",Y.yt_lt="loadType",Y.mver="creatorInfo.measurementVersion",Y.yt_ad="isMonetized",Y.nr="webInfo.navigationReason",Y.nrsu="navigationRequestedSameUrl",
Y.ncnp="webInfo.nonPreloadedNodeCount",Y.pnt="performanceNavigationTiming",Y.prt="playbackRequiresTap",Y.plt="playerInfo.playbackType",Y.pis="playerInfo.playerInitializedState",Y.paused="playerInfo.isPausedOnLoad",Y.yt_pt="playerType",Y.fmt="playerInfo.itag",Y.yt_pl="watchInfo.isPlaylist",Y.yt_pre="playerInfo.preloadType",Y.yt_ad_pr="prerollAllowed",Y.pa="previousAction",Y.yt_red="isRedSubscriber",Y.rce="mwebInfo.responseContentEncoding",Y.scrh="screenHeight",Y.scrw="screenWidth",Y.st="serverTimeMs",
Y.ssdm="shellStartupDurationMs",Y.br_trs="tvInfo.bedrockTriggerState",Y.kebqat="kabukiInfo.earlyBrowseRequestInfo.abandonmentType",Y.kebqa="kabukiInfo.earlyBrowseRequestInfo.adopted",Y.label="tvInfo.label",Y.is_mdx="tvInfo.isMdx",Y.preloaded="tvInfo.isPreloaded",Y.upg_player_vis="playerInfo.visibilityState",Y.query="unpluggedInfo.query",Y.upg_chip_ids_string="unpluggedInfo.upgChipIdsString",Y.yt_vst="videoStreamType",Y.vph="viewportHeight",Y.vpw="viewportWidth",Y.yt_vis="isVisible",Y.rcl="mwebInfo.responseContentLength",
Y.GetSettings_rid="requestIds",Y.GetTrending_rid="requestIds",Y.GetMusicSearchSuggestions_rid="requestIds",Y.REQUEST_ID="requestIds",Y),Ll="isContinuation isNavigation kabukiInfo.earlyBrowseRequestInfo.adopted kabukiInfo.isPrefetch kabukiInfo.isSecondaryNav isMonetized navigationRequestedSameUrl performanceNavigationTiming playerInfo.isPausedOnLoad prerollAllowed isRedSubscriber tvInfo.isMdx tvInfo.isPreloaded isVisible watchInfo.isPlaylist playbackRequiresTap".split(" "),Ml={},Nl=(Ml.ccs="CANARY_STATE_",
Ml.mver="MEASUREMENT_VERSION_",Ml.pis="PLAYER_INITIALIZED_STATE_",Ml.yt_pt="LATENCY_PLAYER_",Ml.pa="LATENCY_ACTION_",Ml.yt_vst="VIDEO_STREAM_TYPE_",Ml),Ol="all_vc ap c cver cbrand cmodel cplatform ctheme ei l_an l_mm plid srt yt_fss yt_li vpst vpni2 vpil2 icrc icrt pa GetAccountOverview_rid GetHistory_rid cmt d_vpct d_vpnfi d_vpni nsru pc pfa pfeh pftr pnc prerender psc rc start tcrt tcrc ssr vpr vps yt_abt yt_fn yt_fs yt_pft yt_pre yt_pt yt_pvis ytu_pvis yt_ref yt_sts tds".split(" ");
function Pl(a){return!!P("FORCE_CSI_ON_GEL",!1)||Q("csi_on_gel")||!!Al(a).useGel}
function Ql(a){a=Al(a);if(!("gel"in a))a.gel={gelTicks:{},gelInfos:{}};else if(a.gel){var b=a.gel;b.gelInfos||(b.gelInfos={});b.gelTicks||(b.gelTicks={})}return a.gel}
;function Rl(a,b,c){if(null!==b)if(Bl(c)[a]=b,Pl(c)){var d=b;b=Ql(c);if(b.gelInfos)b.gelInfos["info_"+a]=!0;else{var e={};b.gelInfos=(e["info_"+a]=!0,e)}if(a.match("_rid")){var f=a.split("_rid")[0];a="REQUEST_ID"}if(a in Kl){b=Kl[a];0<=Xa(Ll,b)&&(d=!!d);a in Nl&&"string"===typeof d&&(d=Nl[a]+d.toUpperCase());a=d;d=b.split(".");for(var g=e={},h=0;h<d.length-1;h++){var k=d[h];g[k]={};g=g[k]}g[d[d.length-1]]="requestIds"===b?[{id:a,endpoint:f}]:a;f=gl({},e)}else 0<=Xa(Ol,a)||Zi(new Zh("Unknown label logged with GEL CSI",
a)),f=void 0;f&&Pl(c)&&(b=Fl(c||""),gl(b.info,f),b=Ql(c),"gelInfos"in b||(b.gelInfos={}),gl(b.gelInfos,f),c=Cl(c),Il().info(f,c))}else Fl(c||"").info[a]=b}
function Sl(a,b,c){var d=zl(c);if(Q("use_first_tick")&&Tl(a,c))return d[a];if(!b&&"_"!==a[0]){var e=a;wl.mark&&(0==e.lastIndexOf("mark_",0)||(e="mark_"+e),c&&(e+=" ("+c+")"),wl.mark(e))}e=b||S();d[a]=e;e=Ql(c);e.gelTicks&&(e.gelTicks["tick_"+a]=!0);c||b||S();if(Pl(c)){Fl(c||"").tick[a]=b||S();e=Cl(c);if("_start"===a){var f=Il();Jl(f,"baseline_"+e)||Pi("latencyActionBaselined",{clientActionNonce:e},{timestamp:b})}else Il().tick(a,e,b);Dl(c);e=!0}else e=!1;if(!e){if(!z("yt.timing."+(c||"")+"pingSent_")&&
(f=P((c||"")+"TIMING_ACTION",void 0),e=zl(c),z("ytglobal.timing"+(c||"")+"ready_")&&f&&Tl("_start")&&yl(c)))if(Dl(c),c)Ul(c);else{f=!0;var g=P("TIMING_WAIT",[]);if(g.length)for(var h=0,k=g.length;h<k;++h)if(!(g[h]in e)){f=!1;break}f&&Ul(c)}Fl(c||"").tick[a]=b||S()}return d[a]}
function Tl(a,b){var c=zl(b);return a in c}
function Ul(a){if(!Pl(a)){var b=zl(a),c=Bl(a),d=b._start,e=P("CSI_SERVICE_NAME","youtube"),f={v:2,s:e,action:P((a||"")+"TIMING_ACTION",void 0)},g=c.srt;void 0!==b.srt&&delete c.srt;b.aft=yl(a);var h=zl(a),k=h.pbr,l=h.vc;h=h.pbs;k&&l&&h&&k<l&&l<h&&Bl(a).yt_pvis&&"youtube"===e&&(Rl("yt_lt","hot_bg",a),e=b.vc,k=b.pbs,delete b.aft,c.aft=Math.round(k-e));for(var m in c)"_"!==m.charAt(0)&&(f[m]=c[m]);b.ps=S();m={};e=[];for(var p in b)"_"!==p.charAt(0)&&(k=Math.round(b[p]-d),m[p]=k,e.push(p+"."+k));f.rt=
e.join(",");b=!!c.ap;Q("debug_csi_data")&&(c=z("yt.timing.csiData"),c||(c=[],F("yt.timing.csiData",c)),c.push({page:location.href,time:new Date,args:f}));c="";for(var q in f)f.hasOwnProperty(q)&&(c+="&"+q+"="+f[q]);f="/csi_204?"+c.substring(1);if(window.navigator&&window.navigator.sendBeacon&&b){var r=void 0===r?"":r;ol(f,r)||nl(f,void 0,void 0,void 0,r)}else nl(f);y("yt.timing."+(a||"")+"pingSent_",!0,void 0);Cj(tl,new rl(m.aft+(Number(g)||0),a))}}
var Vl=window;Vl.ytcsi&&(Vl.ytcsi.info=Rl,Vl.ytcsi.tick=Sl);function Wl(){var a=this;this.i=[];this.j=[];this.f=[];this.A=!1;this.l=[];this.g=this.m=!1;this.o=new Map;Q("screen_manager_wait_for_csn")&&(Q("web_lifecycles")&&fl[0].push(this.B),Ej("loggingScreenCreated",function(){a.B()}),Ej("clearWaitForNavigationJobs",function(){a.l=[]}))}
function Xl(a,b,c){c=void 0===c?0:c;b.then(function(d){var e,f;a.g&&a.h&&a.h();var g=W(c),h=qj(c);g&&h&&(d.csn=g,(null===(e=d.response)||void 0===e?0:e.trackingParams)&&Oj(a.client,g,h,[lj(d.response.trackingParams)]),(null===(f=d.playerResponse)||void 0===f?0:f.trackingParams)&&Oj(a.client,g,h,[lj(d.playerResponse.trackingParams)]))})}
function Yl(a,b,c,d){if(a.g&&!d)a.i.push([b,c]);else{var e=W(d);c=c||qj(d);e&&c&&Oj(a.client,e,c,[b])}}
function Zl(a,b){var c=void 0===c?0:c;a.o.set(b,c);"UNDEFINED_CSN"===W(c)||a.g||Yl(a,b,void 0,c)}
Wl.prototype.clickCommand=function(a){var b=W();if(!a.clickTrackingParams||!b)return!1;Qj(this.client,b,lj(a.clickTrackingParams));return!0};
function $l(a,b,c){c=void 0===c?{}:c;a.g=!0;a.h=function(){am(a,b,c);var f=qj(c.layer);if(f){for(var g=u(a.i),h=g.next();!h.done;h=g.next())h=h.value,Yl(a,h[0],h[1]||f,c.layer);f=u(a.j);for(g=f.next();!g.done;g=f.next()){h=g.value;g=h[0];var k=h[1];if(a.g)a.j.push([g,k]);else{var l=lj(g);if(h=W())g=a.client,k={csn:h,ve:l.getAsJson(),clientData:k},l={L:tj(h),M:h},"UNDEFINED_CSN"==h?Pj("visualElementStateChanged",k,l):g?$g("visualElementStateChanged",k,g,l):Pi("visualElementStateChanged",k,l)}}}};
W(c.layer)||a.h();if(c.wa)for(var d=u(c.wa),e=d.next();!e.done;e=d.next())Xl(a,e.value,c.layer);else $i(Error("Delayed screen needs a data promise."))}
function am(a,b,c){c=void 0===c?{}:c;c.layer||(c.layer=0);var d=void 0!==c.fb?c.fb:c.layer;var e=W(d);d=qj(d);var f;d&&(void 0!==c.parentCsn?f={clientScreenNonce:c.parentCsn,visualElement:d}:e&&"UNDEFINED_CSN"!==e&&(f={clientScreenNonce:e,visualElement:d}));if(e&&"UNDEFINED_CSN"!==e&&d){var g=a.client,h=!0,k=(h=void 0===h?!1:h)?16:8;k={csn:e,ve:d.getAsJson(),eventType:k};h={L:tj(e),M:e,La:h};"UNDEFINED_CSN"==e?Pj("visualElementHidden",k,h):g?$g("visualElementHidden",k,g,h):Pi("visualElementHidden",
k,h)}try{var l=a.client;g=f;var m=c.va,p=c.L,q=Mj(),r={csn:q,pageVe:(new kj({veType:b,youtubeData:void 0})).getAsJson()};g&&g.visualElement?r.implicitGesture={parentCsn:g.clientScreenNonce,gesturedVe:g.visualElement.getAsJson()}:g&&Zi(new Zh("newScreen() parent element does not have a VE - rootVe",b));m&&(r.cloneCsn=m);m={L:p,M:q};l?$g("screenCreated",r,l,m):Pi("screenCreated",r,m);Cj(Hj,new Jj(q));var A=q}catch(B){aj(B,{mk:b,rootVe:d,parentVisualElement:void 0,gk:e,lk:f,va:c.va});$i(B);return}uj(A,
b,c.layer,c.L);a.f[a.f.length-1]&&!a.f[a.f.length-1].csn&&(a.f[a.f.length-1].csn=A||"");Q("screen_manager_wait_for_csn")&&(y("midTransition",!1,void 0),Cj("loggingScreenCreated"),a.m=!1);Rl("csn",A);dl.getInstance().clear();a.g=!1;a.h=void 0;b=qj(c.layer);e=u(a.o);for(f=e.next();!f.done;f=e.next())f=u(f.value),A=f.next().value,f.next().value===c.layer&&b&&Yl(a,A,b,c.layer);Q("c3_client_side_screens")&&!a.A&&(c=mj(49980),b=mj(49981),F("historyVes",{backButtonVe:c,forwardButtonVe:b}),Zl(a,c),Zl(a,b),
a.A=!0)}
Wl.prototype.B=function(){for(var a=u(this.l),b=a.next();!b.done;b=a.next())b=b.value,b();this.l=[]};var Z=null,bm=null,cm=null,dm={};function em(a){var b=a.id;a=mj(a.ve_type);dm[b]=a;b=W();var c=qj();b&&c&&Rj(b,c,a)}
function fm(){var a=Z.getVideoData(1);a=a.title?a.title+" - YouTube":"YouTube";document.title!==a&&(document.title=a)}
function gm(a){var b=a.csn;a=a.root_ve_type;if(b&&a&&(uj(b,a),a=qj()))for(var c in dm){var d=dm[c];d&&Rj(b,a,d)}}
function hm(a){dm[a.id]=lj(a.tracking_params)}
function im(a){var b=W();a=dm[a.id];b&&a&&Qj(Q("use_default_events_client")?void 0:Oi,b,a)}
function jm(a){a=a.ids;var b=W();if(b)for(var c=0;c<a.length;c++){var d=dm[a[c]];if(d){var e=Q("use_default_events_client")?void 0:Oi;d={csn:b,ve:d.getAsJson(),eventType:1};var f={L:tj(b),M:b};"UNDEFINED_CSN"==b?Pj("visualElementShown",d,f):e?$g("visualElementShown",d,e,f):Pi("visualElementShown",d,f)}}}
;y("yt.setConfig",O,void 0);y("yt.config.set",O,void 0);y("yt.setMsg",Gf,void 0);y("yt.msgs.set",Gf,void 0);y("yt.logging.errors.log",$i,void 0);
y("writeEmbed",function(){var a=P("PLAYER_CONFIG",void 0);if(!a){var b=P("PLAYER_VARS",void 0);b&&(a={args:b})}Zk(!0);"gvn"==a.args.ps&&(document.body.style.backgroundColor="transparent");a.attrs||(a.attrs={width:"100%",height:"100%",id:"video-player"});var c=document.referrer;b=P("POST_MESSAGE_ORIGIN");window!=window.top&&c&&c!=document.URL&&(a.args.loaderUrl=c);if((c=P("WEB_PLAYER_CONTEXT_CONFIGS",void 0))&&"WEB_PLAYER_CONTEXT_CONFIG_ID_EMBEDDED_PLAYER"in c){if(!c.serializedForcedExperimentIds){var d=
window.location.href;-1!=d.indexOf("?")?(d=(d||"").split("#")[0],d=d.split("?",2),d=gh(1<d.length?d[1]:d[0])):d={};d.forced_experiments&&(c.serializedForcedExperimentIds=d.forced_experiments)}Z=sk(a,c.WEB_PLAYER_CONTEXT_CONFIG_ID_EMBEDDED_PLAYER,!1)}else Z=sk(a);Z.addEventListener("onScreenChanged",gm);Z.addEventListener("onLogClientVeCreated",em);Z.addEventListener("onLogServerVeCreated",hm);Z.addEventListener("onLogVeClicked",im);Z.addEventListener("onLogVesShown",jm);Z.addEventListener("onVideoDataChange",
fm);a=P("POST_MESSAGE_ID","player");P("ENABLE_JS_API")?cm=new Kk(Z):P("ENABLE_POST_API")&&"string"===typeof a&&"string"===typeof b&&(bm=new Lk(window.parent,a,b),cm=new Fk(Z,bm.h));ng()},void 0);
var km=Cf(function(){Sl("ol");var a=$k.getInstance(),b=!!((cl("f"+(Math.floor(119/31)+1))||0)&67108864),c=1<window.devicePixelRatio;if(document.body&&Od(document.body,"exp-invert-logo"))if(c&&!Od(document.body,"inverted-hdpi")){var d=document.body;if(d.classList)d.classList.add("inverted-hdpi");else if(!Od(d,"inverted-hdpi")){var e=Md(d);Nd(d,e+(0<e.length?" inverted-hdpi":"inverted-hdpi"))}}else!c&&Od(document.body,"inverted-hdpi")&&Pd();b!=c&&(b="f"+(Math.floor(119/31)+1),d=cl(b)||0,d=c?d|67108864:
d&-67108865,0==d?delete X[b]:(c=d.toString(16),X[b]=c.toString()),a.save());Wl.f||(Wl.f=new Wl);a=Wl.f;c=16623;var f=void 0===f?{}:f;Object.values(Sj).includes(c)||(Zi(new Zh("createClientScreen() called with a non-page VE",c)),c=83769);f.isHistoryNavigation||a.f.push({rootVe:c,key:f.key||""});a.i=[];a.j=[];Q("screen_manager_wait_for_csn")&&(a.m||Cj("clearWaitForNavigationJobs"),F("midTransition",!0));f.wa?$l(a,c,f):am(a,c,f)}),lm=Cf(function(){Z&&Z.sendAbandonmentPing&&Z.sendAbandonmentPing();
P("PL_ATT")&&dj.dispose();for(var a=0,b=lg.length;a<b;a++){var c=lg[a];if(!isNaN(c)){var d=z("yt.scheduler.instance.cancelJob");d?d(c):Of(c)}}lg.length=0;fg("//static.doubleclick.net/instream/ad_status.js");mg=!1;O("DCLKSTAT",0);Xc(cm,bm);Z&&(Z.removeEventListener("onScreenChanged",gm),Z.removeEventListener("onLogClientVeCreated",em),Z.removeEventListener("onLogServerVeCreated",hm),Z.removeEventListener("onLogVeClicked",im),Z.removeEventListener("onLogVesShown",jm),Z.removeEventListener("onVideoDataChange",
fm),Z.destroy());dm={}});
window.addEventListener?(window.addEventListener("load",km),window.addEventListener("unload",lm)):window.attachEvent&&(window.attachEvent("onload",km),window.attachEvent("onunload",lm));F("yt.abuse.player.botguardInitialized",z("yt.abuse.player.botguardInitialized")||ej);F("yt.abuse.player.invokeBotguard",z("yt.abuse.player.invokeBotguard")||fj);F("yt.abuse.dclkstatus.checkDclkStatus",z("yt.abuse.dclkstatus.checkDclkStatus")||og);F("yt.player.exports.navigate",z("yt.player.exports.navigate")||vj);
F("yt.util.activity.init",z("yt.util.activity.init")||Bg);F("yt.util.activity.getTimeSinceActive",z("yt.util.activity.getTimeSinceActive")||Eg);F("yt.util.activity.setTimestamp",z("yt.util.activity.setTimestamp")||Cg);}).call(this);
