import 'dart:async';

import 'package:nextcloud_cookbook_flutter/src/services/authentication_provider.dart';

import '../models/app_authentication.dart';

class UserRepository {
  // Singleton
  static final UserRepository _userRepository = UserRepository._internal();
  factory UserRepository() {
    return _userRepository;
  }
  UserRepository._internal();

  AuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<AppAuthentication> authenticate(String serverUrl) async {
    return authenticationProvider.authenticate(serverUrl: serverUrl);
  }

  AppAuthentication getCurrentAppAuthentication() {
    return authenticationProvider.currentAppAuthentication;
  }

  Future<bool> hasAppAuthentication() async {
    return authenticationProvider.hasAppAuthentication();
  }

  Future<void> loadAppAuthentication() async {
    return authenticationProvider.loadAppAuthentication();
  }

  Future<void> persistAppAuthentication(
      AppAuthentication appAuthentication) async {
    return authenticationProvider.persistAppAuthentication(appAuthentication);
  }

  Future<void> deleteAppAuthentication() async {
    return authenticationProvider.deleteAppAuthentication();
  }
}
