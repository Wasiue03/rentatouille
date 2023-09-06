// user_profile_screen.dart
import 'package:flutter/material.dart';
import '../../models/UserProfile/user_profile.dart';
import '../../services/Profile/fetch_profile.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileService _profileService = UserProfileService();
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userProfile = await _profileService.fetchUserProfile();
    if (userProfile != null) {
      setState(() {
        _userProfile = userProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: _userProfile != null
          ? _buildUserProfile(_userProfile!)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildUserProfile(UserProfile userProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (userProfile.profilePictureUrl.isNotEmpty)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(userProfile.profilePictureUrl),
          ),
        SizedBox(height: 16),
        Text('Name: ${userProfile.displayName}'),
        Text('Email: ${userProfile.email}'),
        // You can add more user profile details here
      ],
    );
  }
}
