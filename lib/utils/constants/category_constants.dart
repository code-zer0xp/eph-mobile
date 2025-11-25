class CategoryConstants {
  // Main Categories
  static const List<String> mainCategories = [
    'Tourist Attraction',
    'Facilities',
    'Services',
  ];

  // Subcategories
  static const Map<String, List<String>> subcategories = {
    'Tourist Attraction': [
      // Cultural
      'Religious Sites',
      'Museums',
      'Historical Sites',
      'Festivals',
      'Traditional Villages',
      // Natural
      'Beach',
      'Mountain',
      'Falls',
      'Caves',
      'Islands',
      // Adventure
      'Zip Lines',
      'Whitewater Rafting',
      'Hike',
      'Surf',
      'Dive',
      // Man-made
      'Man-made',
      // Shopping
      'Shopping',
      // Resorts
      'Resorts',
      // Agri-Tourism
      'Agri-Tourism Farm/Site',
    ],
    'Facilities': [
      'Hotel',
      'Mabuhay Accommodation',
      'Restaurant',
      'Specialty Shop',
      'MICE Facility',
      'Homestay',
      'Hostels',
      'Bread and Breakfast',
      'Inns',
      'Motels',
      'Apartelles',
      'Pension Houses',
    ],
    'Services': [
      'Travel and Tour Agency',
      'Travel Agency',
      'Land Tourist Transport',
      'Water Tourist Transport',
      'Air Tourist Transport',
      'MICE Organizer',
      'Regional Tour Guide',
      'Community Guide',
    ],
  };

  // Subcategory icons
  static const Map<String, String> subcategoryIcons = {
    // Cultural
    'Religious Sites': 'church',
    'Museums': 'museum',
    'Historical Sites': 'account_balance',
    'Festivals': 'celebration',
    'Traditional Villages': 'home',
    // Natural
    'Beach': 'beach_access',
    'Mountain': 'terrain',
    'Falls': 'water',
    'Caves': 'landscape',
    'Islands': 'sailing',
    // Adventure
    'Zip Lines': 'cable',
    'Whitewater Rafting': 'rafting',
    'Hike': 'hiking',
    'Surf': 'surfing',
    'Dive': 'scuba_diving',
    // Man-made
    'Man-made': 'apartment',
    // Shopping
    'Shopping': 'shopping_bag',
    // Resorts
    'Resorts': 'pool',
    // Agri-Tourism
    'Agri-Tourism Farm/Site': 'agriculture',
    // Facilities
    'Hotel': 'hotel',
    'Mabuhay Accommodation': 'bed',
    'Restaurant': 'restaurant',
    'Specialty Shop': 'store',
    'MICE Facility': 'business_center',
    'Homestay': 'home',
    'Hostels': 'night_shelter',
    'Bread and Breakfast': 'free_breakfast',
    'Inns': 'cottage',
    'Motels': 'garage',
    'Apartelles': 'apartment',
    'Pension Houses': 'villa',
    // Services
    'Travel and Tour Agency': 'travel_explore',
    'Travel Agency': 'flight',
    'Land Tourist Transport': 'directions_bus',
    'Water Tourist Transport': 'directions_boat',
    'Air Tourist Transport': 'flight_takeoff',
    'MICE Organizer': 'event',
    'Regional Tour Guide': 'tour',
    'Community Guide': 'groups',
  };

  // Category descriptions
  static const Map<String, String> categoryDescriptions = {
    'Tourist Attraction': 'Tourist attractions and destinations',
    'Facilities': 'Accommodations and facilities',
    'Services': 'Travel and tourism services',
  };
}
