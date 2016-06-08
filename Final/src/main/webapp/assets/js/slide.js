var primary = $("#carousel");
var secondary = $("#thumbnails");

$(document).ready(function() {
  primary.owlCarousel({
    singleItem             : true,
    slideSpeed             : 1000,
    pagination             : false,
    afterAction            : syncPosition,
    responsiveRefreshRate  : 200,
    navigation             : true,
    navigationText        : ["",""]
  });

  secondary.owlCarousel({
    items                 : 7,
    itemsDesktop          : [1200,8],
    itemsDesktopSmall     : [992,7],
    itemsTablet           : [768,6],
    itemsMobile           : [480,4],
    pagination            : false,
    responsiveRefreshRate : 100,
    navigation            : true,
    navigationText        : ["",""],
    afterInit             : function(el) {
      el.find(".owl-item").eq(0).addClass("synced");
    }
  });

  function syncPosition(el) {
    var current = this.currentItem;
    secondary.find(".owl-item").removeClass("synced").eq(current).addClass("synced");
    if (secondary.data("owlCarousel") !== undefined) {
      center(current);
    }
    $('.current-item').html(this.owl.currentItem + 1);
    $('.max-items').html(this.owl.owlItems.length);
  }

  secondary.on("click", ".owl-item", function(e) {
    e.preventDefault();
    var number = $(this).data("owlItem");
    primary.trigger("owl.goTo",number);
  });

  function center(number) {
    var sync2visible = secondary.data("owlCarousel").owl.visibleItems;
    var num = number;
    var found = false;
    for (var i in sync2visible) {
      if (num === sync2visible[i]) {
        var found = true;
      }
    }

    if (found===false) {
      if (num>sync2visible[sync2visible.length-1]) {
        secondary.trigger("owl.goTo", num - sync2visible.length+2);
      } else{
        if (num - 1 === -1) {
          num = 0;
        }
        secondary.trigger("owl.goTo", num);
      }
    } else if (num === sync2visible[sync2visible.length-1]) {
      secondary.trigger("owl.goTo", sync2visible[1]);
    } else if (num === sync2visible[0]) {
      secondary.trigger("owl.goTo", num-1);
    }
  }
});

$( ".collapse-button" ).click(function() {
  var thumbnailsWrapper = $('.thumbnails-wrapper');
  if(thumbnailsWrapper.position().top < thumbnailsWrapper.parent().height() - 1){
    thumbnailsWrapper.animate({bottom: '-' + thumbnailsWrapper.outerHeight() +'px'});
    thumbnailsWrapper.find('.icon').addClass('-flip');
  }
  else {
    thumbnailsWrapper.animate({bottom: '0'});
    thumbnailsWrapper.find('.icon').removeClass('-flip');
  }
});