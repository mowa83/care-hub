import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/build_gender_dropdown.dart';
import 'package:graduation_project/core/shared_widgets/profile_bottom_button.dart';
import 'package:graduation_project/core/shared_widgets/profile_header.dart';
import 'package:graduation_project/core/shared_widgets/profile_image.dart';
import 'package:graduation_project/core/shared_widgets/profile_text_field.dart';
import 'package:graduation_project/core/shared_widgets/show_logout_dialog.dart';
import 'package:graduation_project/features/doctor/profile/data/models/doctor_profile_model.dart';
import 'package:graduation_project/features/doctor/profile/presentation/view%20model/doctor_profile_api_service.dart';
import 'package:intl/intl.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final List<String> _genderOptions = ['Male', 'Female'];
  String? _selectedGender;
  DoctorProfileModel? originalProfile;
  late Future<DoctorProfileModel?> userFuture;
  bool isEditing = false;
  bool isDataInitialized = false;
  late final List<Map<String, dynamic>> items;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _offerController = TextEditingController();
  final TextEditingController _workingTimeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _certificatesController = TextEditingController();

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
        'title': 'Price',
        'hintText': 'Write your Price.....',
        'controller': _priceController
      },
      {
        'icon': null,
        'title': 'Offer',
        'hintText': 'Write your Offer.....',
        'controller': _offerController
      },
      // {
      //   'icon': null,
      //   'title': 'Working Time',
      //   'hintText': 'Write your Price.....',
      //   'controller': _workingTimeController
      // },
      {
        'icon': null,
        'title': 'Experience',
        'hintText': 'Write Experience Years.....',
        'controller': _experienceController
      },
      {
        'icon': null,
        'title': 'About',
        'hintText': 'Write About you....',
        'controller': _aboutController
      },
      {
        'icon': null,
        'title': 'Certificates',
        'hintText': 'Write Your Certificates',
        'controller': _certificatesController
      }
    ];
  }

  void _setControllers(DoctorProfileModel user) {
    _nameController.text = user.user?.username ?? '';
    _birthdayController.text = user.user?.birthDate != null
        ? DateFormat('yyyy-MM-dd').format(user.user!.birthDate!)
        : '';
    _emailController.text = user.user?.email ?? '';
    _phoneController.text = user.user?.phoneNumber ?? '';
    _genderController.text = user.user?.gender ?? '';
    _selectedGender = user.user?.gender ?? '';
    _certificatesController.text = user.certificates ?? '';
    _experienceController.text = user.experienceYear?.toString() ?? '';
    _priceController.text = user.price?.toString() ?? '';
    _offerController.text = user.offer?.toString() ?? '';
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
    _certificatesController.dispose();
    _aboutController.dispose();
    _experienceController.dispose();
    _priceController.dispose();
    _offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DoctorProfileModel?>(
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
                            final updatedProfile = DoctorProfileModel(
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
                              offer: int.tryParse(_offerController.text),
                              price: int.tryParse(_priceController.text),
                              about: _aboutController.text,
                              certificates: _certificatesController.text,
                              experienceYear:
                                  int.tryParse(_experienceController.text),
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
  // final List<String> _genderOptions = ['Male', 'Female'];
  // late List<Map<String, dynamic>> profileItems;
  // late List<Map<String, dynamic>> items;
  // bool isEditing = false;
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _birthdayController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _genderController = TextEditingController();
  // final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _workingTimeController = TextEditingController();
  // final TextEditingController _experienceYearController =
  //     TextEditingController();
  // final TextEditingController _aboutController = TextEditingController();
  // final TextEditingController _certifiactesController = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _nameController.text = "Menna Amir";
  //   _birthdayController.text = "02/12/2002";
  //   _emailController.text = "mennaamir@yahoo.com";
  //   _phoneController.text = "0121202020";
  //   _genderController.text = "Female";
  //   profileItems = [
  //     {
  //       'icon': 'assets/icons/profile.svg',
  //       'text': _nameController.text,
  //       'controller': _nameController
  //     },
  //     {
  //       'icon': 'assets/icons/calendar.svg',
  //       'text': _birthdayController.text,
  //       // 'text': '02/12/2002',
  //       'controller': _birthdayController
  //     },
  //     {
  //       'icon': 'assets/icons/sms.svg',
  //       'text': _emailController.text,
  //       // 'text': 'mennaamir@yahoo.com',
  //       'controller': _emailController
  //     },
  //     {
  //       'icon': 'assets/icons/call.svg',
  //       'text': _phoneController.text,
  //       // 'text': '0121202020',
  //       'controller': _phoneController
  //     },
  //     {
  //       'icon': 'assets/icons/female.svg',
  //       'text': _genderController.text,
  //       // 'text': 'Female',
  //       'controller': _genderController
  //     }
  //   ];
  //   items = [
  //     {
  //       'title': 'Price',
  //       'text': 'Write your Price.....',
  //       'controller': _priceController
  //     },
  //     {
  //       'title': 'Working Time',
  //       'text': 'Write your Price.....',
  //       'controller': _workingTimeController
  //     },
  //     {
  //       'title': 'Experience Year',
  //       'text': 'Write Experience Year.....',
  //       'controller': _experienceYearController
  //     },
  //     {
  //       'title': 'About',
  //       'text': 'Write About you....',
  //       'controller': _aboutController
  //     },
  //     {
  //       'title': 'Certificates',
  //       'text': 'Write Your Certifiactes',
  //       'controller': _certifiactesController
  //     }
  //   ];
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16.w),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 74),
  //               child: Row(
  //                 mainAxisAlignment: isEditing
  //                     ? MainAxisAlignment.center
  //                     : MainAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     'Profile',
  //                     style: textStyle20(),
  //                   ),
  //                   if (isEditing == false) SizedBox(width: 106.w),
  //                   if (isEditing == false)
  //                     InkWell(
  //                         onTap: () {
  //                           setState(() {
  //                             isEditing = true;
  //                           });
  //                         },
  //                         child: Text(
  //                           'EDIT',
  //                           style: textStyle16(
  //                               height: 1.5,
  //                               decoration: TextDecoration.underline,
  //                               decorationColor: AppColor.primarycolor),
  //                         ))
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 9.h,
  //             ),
  //             Stack(children: [
  //               Align(
  //                 child: CircleAvatar(
  //                   backgroundColor: AppColor.secondryColor,
  //                   radius: 43.5.r,
  //                 ),
  //               ),
  //               Align(
  //                 child: Image.asset(
  //                   'assets/images/doctor_profile.png',
  //                   width: 86.w,
  //                   height: 86.h,
  //                 ),
  //               ),
  //             ]),
  //             SizedBox(
  //               height: 10.h,
  //             ),
  //             Text(
  //               'Dentist',
  //               style: textStyle20(fontSize: 14.sp),
  //             ),
  //             isEditing
  //                 ? ListView.separated(
  //                     itemBuilder: (context, index) {
  //                       if (profileItems[index]['icon'] ==
  //                           'assets/icons/female.svg') {
  //                         return DropdownButtonFormField<String>(
  //                           value: profileItems[index]['text'],
  //                           dropdownColor: Colors.white,
  //                           borderRadius: BorderRadius.circular(12),
  //                           onChanged: isEditing
  //                               ? (String? newValue) {
  //                                   setState(() {
  //                                     // profileItems[index]['text'] = newValue!;
  //                                     _genderController.text = newValue!;
  //                                   });
  //                                 }
  //                               : null, // Disable dropdown if not editing
  //                           decoration: InputDecoration(
  //                             prefixIcon: Padding(
  //                               padding: EdgeInsets.all(12),
  //                               child: SvgPicture.asset(
  //                                 _genderController.text == 'Male'
  //                                     ? 'assets/icons/male.svg'
  //                                     : 'assets/icons/female.svg',
  //                                 colorFilter: ColorFilter.mode(
  //                                   Color(0xff292D32),
  //                                   BlendMode.srcIn,
  //                                 ),
  //                               ),
  //                             ),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                           ),
  //                           items: _genderOptions
  //                               .map((gender) => DropdownMenuItem<String>(
  //                                     value: gender,
  //                                     child: Text(gender,
  //                                         style: textStyle12(
  //                                             fontSize: 16.sp,
  //                                             height: 1.375,
  //                                             color: Color(0xff787B80))),
  //                                   ))
  //                               .toList(),
  //                           isExpanded: true,
  //                         );
  //                       } else {
  //                         return TextField(
  //                             controller: profileItems[index]['controller'],
  //                             enabled: isEditing,
  //                             style: textStyle12(
  //                                 fontSize: 16.sp,
  //                                 height: 1.375,
  //                                 color: Color(0xff787B80)),
  //                             decoration: InputDecoration(
  //                               prefixIcon: Padding(
  //                                 padding: EdgeInsets.all(11),
  //                                 child: SvgPicture.asset(
  //                                   profileItems[index]['icon']!,
  //                                   colorFilter: const ColorFilter.mode(
  //                                       Color(0xff292D32), BlendMode.srcIn),
  //                                 ),
  //                               ),
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(10),
  //                               ),
  //                               // hintText: profileItems[index]['text'],
  //                               // hintStyle: textStyle12(
  //                               //     letterSpacing: .5,
  //                               //     color: Color(0xff787B80),
  //                               //     height: 1.7)
  //                             ));
  //                       }
  //                     },
  //                     separatorBuilder: (context, index) {
  //                       return SizedBox(
  //                         height: 12.h,
  //                       );
  //                     },
  //                     itemCount: profileItems.length,
  //                     padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                   )
  //                 : ListView.separated(
  //                     itemBuilder: (context, index) {
  //                       return Container(
  //                         width: 343.w,
  //                         height: 56.h,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             border:
  //                                 Border.all(color: const Color(0xffEBEBEB))),
  //                         child: Row(
  //                           children: [
  //                             Padding(
  //                               padding:
  //                                   EdgeInsets.only(left: 11.w, right: 8.w),
  //                               child: SvgPicture.asset(
  //                                 profileItems[index]['icon']!,
  //                                 colorFilter: const ColorFilter.mode(
  //                                     Color(0xff292D32), BlendMode.srcIn),
  //                               ),
  //                             ),
  //                             Text(profileItems[index]['text']!,
  //                                 style: textStyle12(
  //                                     fontSize: 16.sp,
  //                                     height: 1.375,
  //                                     color: Color(0xff787B80)))
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                     separatorBuilder: (context, index) {
  //                       return SizedBox(
  //                         height: 12.h,
  //                       );
  //                     },
  //                     itemCount: profileItems.length,
  //                     padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                   ),
  //             ListView.separated(
  //               itemBuilder: (context, index) {
  //                 return Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(items[index]['title']!,
  //                         style: textStyle12(fontSize: 14.sp)),
  //                     Padding(
  //                       padding: EdgeInsets.only(top: 14.h),
  //                       child: TextField(
  //                           maxLines: null,
  //                           minLines: items[index]['title'] == 'About' ||
  //                                   items[index]['title'] == 'Certificates'
  //                               ? 3
  //                               : 1,
  //                           controller: items[index]['controller']
  //                               as TextEditingController,
  //                           enabled: isEditing,
  //                           style: textStyle12(
  //                               fontSize: 14.sp,
  //                               letterSpacing: .5,
  //                               color: Color(0xff787B80),
  //                               height: 1.7),
  //                           decoration: InputDecoration(
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(10),
  //                               ),
  //                               hintText: items[index]['text'],
  //                               hintStyle: textStyle12(
  //                                   letterSpacing: .5,
  //                                   color: Color(0xff787B80),
  //                                   height: 1.7))),
  //                     )
  //                   ],
  //                 );
  //               },
  //               separatorBuilder: (context, index) {
  //                 return SizedBox(
  //                   height: 18.h,
  //                 );
  //               },
  //               itemCount: items.length,
  //               padding: EdgeInsets.only(bottom: 32.h),
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //             ),
  //             isEditing
  //                 ? customButton(
  //                     func: () {
  //                       setState(() {
  //                         isEditing = false;
  //                         profileItems = [
  //                           {
  //                             'icon': 'assets/icons/profile.svg',
  //                             'text': _nameController.text,
  //                             'controller': _nameController
  //                           },
  //                           {
  //                             'icon': 'assets/icons/calendar.svg',
  //                             'text': _birthdayController.text,
  //                             'controller': _birthdayController
  //                           },
  //                           {
  //                             'icon': 'assets/icons/sms.svg',
  //                             'text': _emailController.text,
  //                             'controller': _emailController
  //                           },
  //                           {
  //                             'icon': 'assets/icons/call.svg',
  //                             'text': _phoneController.text,
  //                             'controller': _phoneController
  //                           },
  //                           {
  //                             'icon': 'assets/icons/female.svg',
  //                             'text': _genderController.text,
  //                             'controller': _genderController
  //                           }
  //                         ];
  //                       });
  //                     },
  //                     text: 'Save',
  //                     textAlignment: MainAxisAlignment.center,
  //                     letterSpacing: .09,
  //                     fontWeight: FontWeight.w500,
  //                     lineHeight: 2)
  //                 : customButton(
  //                     func: () {
  //                       showLogoutDialog(context: context);
  //                     },
  //                     text: 'Logout',
  //                     textAlignment: MainAxisAlignment.start,
  //                     svgIcon: 'assets/icons/logout.svg',
  //                     letterSpacing: .09,
  //                     fontWeight: FontWeight.w500,
  //                     lineHeight: 2),
  //             SizedBox(
  //               height: 30.h,
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
