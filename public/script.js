$(document).ready(function() {
  var elements = $("li");
  var rides = {};
  var percentage, c = 0;
  var total = $("ul").data("total");
  for (var i = 0; i < elements.length; i++){
    rides[$(elements[i]).data("rider")] = ($(elements[i]).data("rides") / total ).toFixed(2);
  }
  for ( var i in rides ) {
    var color = '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6);
    $($(".bar")[c]).css({"width" : 100 * rides[i] + "%", "background-color": color})
    $($("li")[c]).css("padding-left", (100 * rides[i] + 1) + "%")
    c++;
  }
});