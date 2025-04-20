import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/shared_widgets/show_logout_dialog.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/patient/profile/data/models/patient_profile_model.dart';
import 'package:graduation_project/features/patient/profile/presentation/view%20model/patient_profile_api_service.dart';
import 'package:intl/intl.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late final Future<PatientProfileModel?> userFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userFuture = ApiService().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<PatientProfileModel?>(
            future: userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Failed to load the Profile"));
              }

              final profile = snapshot.data!;
              List<Map<String, dynamic>> profileItems = [
                {
                  'icon': 'assets/icons/profile.svg',
                  'text': profile.user?.username ?? 'Name',
                },
                {
                  'icon': 'assets/icons/calendar.svg',
                  'text': profile.user?.birthDate != null
                      ? DateFormat('yyyy-MM-dd')
                          .format(profile.user!.birthDate!)
                      : 'Birth Date',
                },
                {
                  'icon': 'assets/icons/sms.svg',
                  'text': profile.user?.email ?? 'Email',
                },
                {
                  'icon': 'assets/icons/call.svg',
                  'text': profile.user?.phoneNumber ?? 'Phone Number',
                },
                {
                  'icon': 'assets/icons/female.svg',
                  'text': profile.user?.gender ?? 'Gender',
                },
              ];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 58),
                      child: Text(
                        'Profile',
                        style: textStyle20(),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SvgPicture.asset(
                      'assets/icons/profile-circle.svg',
                      width: 116.w,
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          width: 343.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xffEBEBEB))),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 11.w, right: 8.w),
                                child: SvgPicture.asset(
                                  profileItems[index]['icon']!,
                                  colorFilter: const ColorFilter.mode(
                                      Color(0xff292D32), BlendMode.srcIn),
                                ),
                              ),
                              Text(profileItems[index]['text']!,
                                  style:
                                      textStyle12(fontSize: 16, height: 1.375))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12.h,
                        );
                      },
                      itemCount: profileItems.length,
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Chronic Diseases',
                          style: textStyle12(fontSize: 14.sp),
                        )),
                    Container(
                      // alignment: Alignment.center,
                      width: 343.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 11.w, vertical: 13.h),
                      margin: EdgeInsets.only(bottom: 28.h, top: 12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffEBEBEB))),
                      child: Text(
                        profile.chronicDiseases ??
                            'No chronic diseases specified',
                        style: textStyle12(height: 1.75),
                      ),
                    ),
                    customButton(
                        func: () {
                          showLogoutDialog(context: context);
                        },
                        text: 'Logout',
                        textAlignment: MainAxisAlignment.start,
                        svgIcon: 'assets/icons/logout.svg',
                        letterSpacing: .09,
                        fontWeight: FontWeight.w500,
                        lineHeight: 2),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                )),
              );
            }));
  }
//   final List<String> _genderOptions = ['Male', 'Female'];
//   String? _selectedGender;
//   PatientProfileModel? originalProfile;
//   late Future<PatientProfileModel?> userFuture;
//   bool isEditing = false;
//   bool isDataInitialized = false;
//   late final List<Map<String, dynamic>> items;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _birthdayController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _chronicDiseasesController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     userFuture = ApiService().fetchProfileModel();
//     items = [
//       {
//         'icon': 'assets/icons/profile.svg',
//         'hintText': 'Name',
//         'controller': _nameController
//       },
//       {
//         'icon': 'assets/icons/calendar.svg',
//         'hintText': 'Birth Date',
//         'controller': _birthdayController
//       },
//       {
//         'icon': 'assets/icons/sms.svg',
//         'hintText': 'Email',
//         'controller': _emailController
//       },
//       {
//         'icon': 'assets/icons/call.svg',
//         'hintText': 'Phone Number',
//         'controller': _phoneController
//       },
//       {
//         'icon': 'assets/icons/female.svg',
//         'hintText': 'Gender',
//         'controller': _genderController
//       },
//       {
//         'icon': null,
//         'title': 'About',
//         'hintText': 'Write About you....',
//         'controller': _chronicDiseasesController
//       },
//     ];
//   }
//
//   void _setControllers(PatientProfileModel user) {
//     _nameController.text = user.user?.username ?? '';
//     _birthdayController.text = user.user?.birthDate != null
//         ? DateFormat('yyyy-MM-dd').format(user.user!.birthDate!)
//         : '';
//     _emailController.text = user.user?.email ?? '';
//     _phoneController.text = user.user?.phoneNumber ?? '';
//     _genderController.text = user.user?.gender ?? '';
//     _selectedGender = user.user?.gender ?? '';
//     _chronicDiseasesController.text = user.chronicDiseases ?? '';
//     originalProfile = user;
//   }
//
//   void _cancelEditing() {
//     setState(() {
//       if (originalProfile != null) {
//         _setControllers(originalProfile!);
//         isEditing = false;
//       }
//     });
//   }
//
//   void _pickDate() async {
//     DateTime lastDate = DateTime(2008);
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _birthdayController.text.isNotEmpty
//           ? DateTime.tryParse(_birthdayController.text) ?? lastDate
//           : lastDate,
//       firstDate: DateTime(1910),
//       lastDate: lastDate,
//     );
//     if (pickedDate != null) {
//       setState(() {
//         _birthdayController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//       });
//     }
//   }
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _birthdayController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _genderController.dispose();
//     _chronicDiseasesController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder<PatientProfileModel?>(
//             future: userFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError || snapshot.data == null) {
//                 return const Center(child: Text("Failed to load user data"));
//               }
//
//               final user = snapshot.data!;
//               if (!isDataInitialized) {
//                 _setControllers(user);
//                 isDataInitialized = true;
//               }
//
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ProfileHeader(
//                         isEditing: isEditing,
//                         onEditTap: () {
//                           setState(() {
//                             if (isEditing) {
//                               _cancelEditing();
//                             } else {
//                               isEditing = !isEditing;
//                             }
//                           });
//                         },
//                       ),
//                       SizedBox(
//                         height: 9.h,
//                       ),
//                       ProfileImage(
//                         profileImageUrl: user.user!.image,
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       ListView.separated(
//                         itemBuilder: (context, index) {
//                           if (index == 4) {
//                             return GenderDropdown(
//                               isEditing: isEditing,
//                               genderControllerText: _genderController.text,
//                               genderOptions: _genderOptions,
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   _selectedGender = newValue;
//                                   _genderController.text = newValue!;
//                                 });
//                               },
//                               selectedGender: _selectedGender,
//                             );
//                           }
//                           return ProfileTextField(
//                             isEditing: isEditing,
//                             title: items[index]['title'],
//                             controller: items[index]['controller'],
//                             hintText: items[index]['hintText'],
//                             onTap: isEditing == true && index == 1
//                                 ? _pickDate
//                                 : null,
//                             iconPath: items[index]['icon'],
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return SizedBox(
//                             height: index == 4 ? 32.h : 18.h,
//                           );
//                         },
//                         itemCount: items.length,
//                         padding: EdgeInsets.only(bottom: 32.h),
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                       ),
//                       ProfileBottomButton(
//                           isEditing: isEditing,
//                           onSave: () async {
//                             final updatedProfile = PatientProfileModel(
//                               user: User(
//                                 username: _nameController.text,
//                                 email: _emailController.text,
//                                 gender: _genderController.text,
//                                 phoneNumber: _phoneController.text,
//                                 birthDate: _birthdayController.text.isNotEmpty
//                                     ? DateTime.tryParse(
//                                     _birthdayController.text)
//                                     : null,
//                               ),
//                               chronicDiseases:_chronicDiseasesController.text,
//                             );
//
//                             final success = await ApiService()
//                                 .updateProfile(updatedProfile);
//                             if (!context.mounted) return;
//                             if (success) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                     Text('Profile updated successfully')),
//                               );
//                               setState(() {
//                                 isEditing = false;
//                                 originalProfile = updatedProfile;
//                                 _setControllers(updatedProfile);
//                               });
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text('Failed to update profile')),
//                               );
//                             }
//                           },
//                           onLogout: () {
//                             showLogoutDialog(context: context);
//                           }),
//                       SizedBox(
//                         height: 30.h,
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }));
//   }
}
