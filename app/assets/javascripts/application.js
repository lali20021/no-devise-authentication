// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree
//= require bootstrap
 window.setTimeout(function(){
   $(".success, .alert, .primary").fadeTo('slow', 0).slideUp('slow', function(){
     $(this).remove()
   });
 }, 3000);


 // Safari fix back button
 // http://www.aichengxu.com/view/47210
 function isSafari() {
     if (navigator.userAgent.indexOf("Safari") > -1) {
         return true;
     }
     return false;
 }


 if (isSafari()){
     $(window).bind('pageshow', function(event) {
         if (event.originalEvent.persisted) {
             document.body.style.display = "none";
             window.location.reload(true)
         }
     });
 }
