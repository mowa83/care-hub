import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/show_logout_dialog.dart';
import 'package:graduation_project/features/nurse/profile/data/models/nurse_profile_model.dart';
import 'package:graduation_project/core/shared_widgets/build_gender_dropdown.dart';
import 'package:graduation_project/core/shared_widgets/profile_bottom_button.dart';
import 'package:graduation_project/core/shared_widgets/profile_header.dart';
import 'package:graduation_project/core/shared_widgets/profile_image.dart';
import 'package:graduation_project/core/shared_widgets/profile_text_field.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project/features/nurse/profile/presentation/view%20model/nurse_profile_api_service.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final List<String> _genderOptions = ['Male', 'Female'];
  String? _selectedGender;
  ProfileModel? originalProfile;
  late Future<ProfileModel?> userFuture;
  bool isEditing = false;
  bool isDataInitialized = false;
  late final List<Map<String, dynamic>> items;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userFuture = ApiService().fetchProfileModel();
    items = [
      {
        'icon': 'assets/icons/profile.svg',
        'hintText': 'Name',
        'controller': _nameController
      },
      {
        'icon': 'assets/icons/calendar.svg',
        'hintText': 'Birth Date',
        'controller': _birthdayController
      },
      {
        'icon': 'assets/icons/sms.svg',
        'hintText': 'Email',
        'controller': _emailController
      },
      {
        'icon': 'assets/icons/call.svg',
        'hintText': 'Phone Number',
        'controller': _phoneController
      },
      {
        'icon': 'assets/icons/female.svg',
        'hintText': 'Gender',
        'controller': _genderController
      },
      {
        'icon': null,
        'title': 'About',
        'hintText': 'Write About you....',
        'controller': _aboutController
      },
      {
        'icon': null,
        'title': 'Services',
        'hintText': 'Write Your Services',
        'controller': _serviceController
      }
    ];
  }

  void _setControllers(ProfileModel user) {
    _nameController.text = user.user?.username ?? '';
    _birthdayController.text = user.user?.birthDate != null
        ? DateFormat('yyyy-MM-dd').format(user.user!.birthDate!)
        : '';
    _emailController.text = user.user?.email ?? '';
    _phoneController.text = user.user?.phoneNumber ?? '';
    _genderController.text = user.user?.gender ?? '';
    _selectedGender = user.user?.gender ?? '';
    _serviceController.text = user.services ?? '';

    _aboutController.text = user.about ?? '';
    originalProfile = user;
  }

  void _cancelEditing() {
    setState(() {
      if (originalProfile != null) {
        _setControllers(originalProfile!);
        isEditing = false;
      }
    });
  }

  void _pickDate() async {
    DateTime lastDate = DateTime(2008);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthdayController.text.isNotEmpty
          ? DateTime.tryParse(_birthdayController.text) ?? lastDate
          : lastDate,
      firstDate: DateTime(1910),
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      setState(() {
        _birthdayController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _serviceController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ProfileModel?>(
            future: userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Failed to load user data"));
              }

              final user = snapshot.data!;
              if (!isDataInitialized) {
                _setControllers(user);
                isDataInitialized = true;
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileHeader(
                        isEditing: isEditing,
                        onEditTap: () {
                          setState(() {
                            if (isEditing) {
                              _cancelEditing();
                            } else {
                              isEditing = !isEditing;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      ProfileImage(
                        profileImageUrl: user.user!.image,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) {
                          if (index == 4) {
                            return GenderDropdown(
                              isEditing: isEditing,
                              genderControllerText: _genderController.text,
                              genderOptions: _genderOptions,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedGender = newValue;
                                  _genderController.text = newValue!;
                                });
                              },
                              selectedGender: _selectedGender,
                            );
                          }
                          return ProfileTextField(
                            isEditing: isEditing,
                            title: items[index]['title'],
                            controller: items[index]['controller'],
                            hintText: items[index]['hintText'],
                            onTap: isEditing == true && index == 1
                                ? _pickDate
                                : null,
                            iconPath: items[index]['icon'],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: index == 4 ? 25.h : 16.h,
                          );
                        },
                        itemCount: items.length,
                        padding: EdgeInsets.only(bottom: 32.h),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      ProfileBottomButton(
                          isEditing: isEditing,
                          onSave: () async {
                            final updatedProfile = ProfileModel(
                              user: User(
                                username: _nameController.text,
                                email: _emailController.text,
                                gender: _genderController.text,
                                phoneNumber: _phoneController.text,
                                birthDate: _birthdayController.text.isNotEmpty
                                    ? DateTime.tryParse(
                                        _birthdayController.text)
                                    : null,
                              ),
                              services: _serviceController.text
                              ,
                              about: _aboutController.text,
                            );

                            final success = await ApiService()
                                .updateProfile(updatedProfile);
                            if (!context.mounted) return;
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Profile updated successfully')),
                              );
                              setState(() {
                                isEditing = false;
                                originalProfile = updatedProfile;
                                _setControllers(updatedProfile);
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Failed to update profile')),
                              );
                            }
                          },
                          onLogout: () {
                            showLogoutDialog(context: context);
                          }),
                      SizedBox(
                        height: 30.h,
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
