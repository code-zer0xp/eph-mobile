import 'package:flutter/material.dart';

class AppKeys {
  // App level keys
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Screen keys
  static const Key homeScreenKey = Key('home_screen');
  static const Key authScreenKey = Key('auth_screen');
  static const Key settingsScreenKey = Key('settings_screen');

  // Widget keys
  static const Key appLogoKey = Key('app_logo');
  static const Key loadingIndicatorKey = Key('loading_indicator');
  static const Key errorMessageKey = Key('error_message');
  static const Key successMessageKey = Key('success_message');

  // Form keys
  static const Key loginFormKey = Key('login_form');
  static const Key signupFormKey = Key('signup_form');
  static const Key settingsFormKey = Key('settings_form');

  // Button keys
  static const Key loginButtonKey = Key('login_button');
  static const Key signupButtonKey = Key('signup_button');
  static const Key logoutButtonKey = Key('logout_button');
  static const Key saveButtonKey = Key('save_button');
  static const Key cancelButtonKey = Key('cancel_button');

  // Input field keys
  static const Key emailFieldKey = Key('email_field');
  static const Key passwordFieldKey = Key('password_field');
  static const Key nameFieldKey = Key('name_field');
  static const Key phoneFieldKey = Key('phone_field');

  // Navigation keys
  static const Key bottomNavKey = Key('bottom_navigation');
  static const Key drawerKey = Key('drawer');
  static const Key appBarKey = Key('app_bar');

  // List keys
  static const Key destinationListKey = Key('destination_list');
  static const Key categoryListKey = Key('category_list');
  static const Key searchResultsKey = Key('search_results');

  // Search keys
  static const Key searchFieldKey = Key('search_field');
  static const Key searchButtonKey = Key('search_button');
  static const Key filterButtonKey = Key('filter_button');

  // Dialog keys
  static const Key confirmDialogKey = Key('confirm_dialog');
  static const Key errorDialogKey = Key('error_dialog');
  static const Key infoDialogKey = Key('info_dialog');

  // Tab keys
  static const Key exploreTabKey = Key('explore_tab');
  static const Key favoritesTabKey = Key('favorites_tab');
  static const Key profileTabKey = Key('profile_tab');
}
