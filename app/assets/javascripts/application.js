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
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require_tree . 
//= require bootstrap-sprockets

//背景画像をスライダーにする
$(function() {
 $('.bg-slider').bgSwitcher({
 images: ['/assets/image6.jpg','/assets/image16.jpg','/assets/image15.jpg','/assets/image14.jpg','/assets/image9.jpg','/assets/image7.jpg','/assets/image8.jpg','/assets/image12.jpg','/assets/image13.jpg','/assets/image10.jpg','/assets/image11.jpg'],   //画像を呼び込むにはこの記述しかない
 interval: 10000,
 loop: true,
 shuffle: true,
 effect: "fade", // fade,blind,clip,slide,drop,hide
 duration: 5000,
 easing: "swing" // linear,swing
 });
});