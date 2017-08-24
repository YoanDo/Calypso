$(document).ready(function() {
  var flat_addresses = document.querySelectorAll('.autocomplete-location');

  if (flat_addresses.length > 0) {
    flat_addresses.forEach(function(flat_address) {
      var autocomplete = new google.maps.places.Autocomplete(flat_address, { types: ['geocode'] });
      google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
      google.maps.event.addDomListener(flat_address, 'keydown', function(e) {
        if (e.keyCode == 13) {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    })
  }
});

function onPlaceChanged() {
  var place = this.getPlace();

  $('#service_location').trigger('blur').val(place.formatted_address);
}
