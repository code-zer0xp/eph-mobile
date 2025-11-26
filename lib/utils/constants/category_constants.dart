class CategoryConstants {
  // Main Categories (Renamed Tourist Attraction to Destinations)
  static const List<String> mainCategories = [
    'Destinations',
    'Facilities',
    'Services',
  ];

  // Subcategories
  static const Map<String, List<String>> subcategories = {
    'Destinations': [
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
    'Destinations': 'Explore beautiful destinations across the Philippines',
    'Facilities': 'Find the best accommodations and facilities',
    'Services': 'Discover travel and tourism services',
  };

  // Placeholder images for categories
  static const Map<String, String> categoryImages = {
    'Destinations':
        'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400',
    'Facilities':
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
    'Services':
        'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400',
  };

  // Placeholder images for subcategories
  static const Map<String, String> subcategoryImages = {
    'Religious Sites':
        'https://images.unsplash.com/photo-1548625149-fc4a29cf7092?w=400',
    'Museums':
        'https://images.unsplash.com/photo-1554907984-15263bfd63bd?w=400',
    'Historical Sites':
        'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=400',
    'Festivals':
        'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=400',
    'Traditional Villages':
        'https://images.unsplash.com/photo-1518638150340-f706e86654de?w=400',
    'Beach':
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
    'Mountain':
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400',
    'Falls':
        'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=400',
    'Caves':
        'https://images.unsplash.com/photo-1500627965408-b5f300c68645?w=400',
    'Islands':
        'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=400',
    'Zip Lines':
        'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400',
    'Whitewater Rafting':
        'https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?w=400',
    'Hike': 'https://images.unsplash.com/photo-1551632811-561732d1e306?w=400',
    'Surf':
        'https://images.unsplash.com/photo-1502680390469-be75c86b636f?w=400',
    'Dive': 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
    'Man-made':
        'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=400',
    'Shopping':
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
    'Resorts':
        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=400',
    'Agri-Tourism Farm/Site':
        'https://images.unsplash.com/photo-1500076656116-558758c991c1?w=400',
    'Hotel':
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
    'Mabuhay Accommodation':
        'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=400',
    'Restaurant':
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
    'Specialty Shop':
        'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=400',
    'MICE Facility':
        'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=400',
    'Homestay':
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400',
    'Hostels':
        'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=400',
    'Bread and Breakfast':
        'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400',
    'Inns':
        'https://images.unsplash.com/photo-1445991842772-097fea258e7b?w=400',
    'Motels':
        'https://images.unsplash.com/photo-1586611292717-f828b167408c?w=400',
    'Apartelles':
        'https://images.unsplash.com/photo-1502672023488-70e25813eb80?w=400',
    'Pension Houses':
        'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=400',
    'Travel and Tour Agency':
        'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400',
    'Travel Agency':
        'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=400',
    'Land Tourist Transport':
        'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400',
    'Water Tourist Transport':
        'https://images.unsplash.com/photo-1544551763-77ef2d0cfc6c?w=400',
    'Air Tourist Transport':
        'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=400',
    'MICE Organizer':
        'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?w=400',
    'Regional Tour Guide':
        'https://images.unsplash.com/photo-1527631746610-bca00a040d60?w=400',
    'Community Guide':
        'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=400',
  };
}
