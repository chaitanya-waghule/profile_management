$(document).ready(function() {

  window.showProfilePicturePreview = function(event) {
    var output = $('#profile_picture_preview')[0];
    output.src = URL.createObjectURL(event.target.files[0]);
    output.onload = function() {
      URL.revokeObjectURL(output.src)
    }
  };

});
