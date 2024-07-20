const GOOGLE_MAP_API = 'AIzaSyCVru0fdI7sZzaR6s89YhR_gkuSz_VrNbY';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$longitude,$latitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$longitude,$latitude&key=$GOOGLE_MAP_API';
    //AIzaSyCVru0fdI7sZzaR6s89YhR_gkuSz_VrNbY'
  }
}

//  /styles/v1/{username}/{style_id}/static/{overlay}/{lon},{lat},{zoom},{bearing},{pitch}|{bbox}|{auto}/{width}x{height}{@2x}