import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/shared_widgets/show_logout_dialog.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';


class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final List<String> _genderOptions = ['Male', 'Female'];
  late List<Map<String, dynamic>> profileItems;
  late List<Map<String, dynamic>> items;
  bool isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = "Menna Amir";
    _birthdayController.text = "02/12/2002";
    _emailController.text = "mennaamir@yahoo.com";
    _phoneController.text = "0121202020";
    _genderController.text = "Female";
    profileItems = [
      {
        'icon': 'assets/icons/profile.svg',
        'text': _nameController.text,
        'controller': _nameController
      },
      {
        'icon': 'assets/icons/calendar.svg',
        'text': _birthdayController.text,
        // 'text': '02/12/2002',
        'controller': _birthdayController
      },
      {
        'icon': 'assets/icons/sms.svg',
        'text': _emailController.text,
        // 'text': 'mennaamir@yahoo.com',
        'controller': _emailController
      },
      {
        'icon': 'assets/icons/call.svg',
        'text': _phoneController.text,
        // 'text': '0121202020',
        'controller': _phoneController
      },
      {
        'icon': 'assets/icons/female.svg',
        'text': _genderController.text,
        // 'text': 'Female',
        'controller': _genderController
      }
    ];
    items = [
      {
        'title': 'About',
        'text': 'Write About you....',
        'controller': _aboutController
      },
      {
        'title': 'Services',
        'text': 'Write Your Services',
        'controller': _servicesController
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 74),
                child: Row(
                  mainAxisAlignment: isEditing
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
                  children: [
                    Text(
                      'Profile',
                      style: textStyle20(),
                    ),
                    if (isEditing == false) SizedBox(width: 106.w),
                    if (isEditing == false)
                      InkWell(
                          onTap: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          child: Text(
                            'EDIT',
                            style: textStyle16(
                                height: 1.5,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.primarycolor),
                          ))
                  ],
                ),
              ),
              SizedBox(
                height: 9.h,
              ),
              Stack(children: [
                Align(
                  child: CircleAvatar(
                    backgroundColor: AppColor.secondryColor,
                    radius: 43.5.r,
                  ),
                ),
                Align(
                  child: Image.asset(
                    'assets/images/doctor_profile.png',
                    width: 86.w,
                    height: 86.h,
                  ),
                ),
              ]),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   'Dentist',
              //   style: textStyle20(fontSize: 14.sp),
              // ),
              isEditing
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        if (profileItems[index]['icon'] ==
                            'assets/icons/female.svg') {
                          return DropdownButtonFormField<String>(
                            value: profileItems[index]['text'],
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            onChanged: isEditing
                                ? (String? newValue) {
                                    setState(() {
                                      // profileItems[index]['text'] = newValue!;
                                      _genderController.text = newValue!;
                                    });
                                  }
                                : null, // Disable dropdown if not editing
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  _genderController.text == 'Male'
                                      ? 'assets/icons/male.svg'
                                      : 'assets/icons/female.svg',
                                  colorFilter: ColorFilter.mode(
                                    Color(0xff292D32),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: _genderOptions
                                .map((gender) => DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(gender,
                                          style: textStyle12(
                                              fontSize: 16.sp,
                                              height: 1.375,
                                              color: Color(0xff787B80))),
                                    ))
                                .toList(),
                            isExpanded: true,
                          );
                        } else {
                          return TextField(
                              controller: profileItems[index]['controller'],
                              enabled: isEditing,
                              style: textStyle12(
                                  fontSize: 16.sp,
                                  height: 1.375,
                                  color: Color(0xff787B80)),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(11),
                                  child: SvgPicture.asset(
                                    profileItems[index]['icon']!,
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xff292D32), BlendMode.srcIn),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // hintText: profileItems[index]['text'],
                                // hintStyle: textStyle12(
                                //     letterSpacing: .5,
                                //     color: Color(0xff787B80),
                                //     height: 1.7)
                              ));
                        }
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12.h,
                        );
                      },
                      itemCount: profileItems.length,
                      padding: EdgeInsets.only(top: 46.h, bottom: 16.h),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : ListView.separated(
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
                                  style: textStyle12(
                                      fontSize: 16.sp,
                                      height: 1.375,
                                      color: Color(0xff787B80)))
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
                      padding: EdgeInsets.only(top: 46.h, bottom: 16.h),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
              ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items[index]['title']!,
                          style: textStyle12(fontSize: 14.sp)),
                      Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: TextField(
                            maxLines: null,
                            minLines:3,
                            controller: items[index]['controller']
                                as TextEditingController,
                            enabled: isEditing,
                            style: textStyle12(
                                fontSize: 14.sp,
                                letterSpacing: .5,
                                color: Color(0xff787B80),
                                height: 1.7),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: items[index]['text'],
                                hintStyle: textStyle12(
                                    letterSpacing: .5,
                                    color: Color(0xff787B80),
                                    height: 1.7))),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 18.h,
                  );
                },
                itemCount: items.length,
                padding: EdgeInsets.only(bottom: 32.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              isEditing
                  ? customButton(
                      func: () {
                        setState(() {
                          isEditing = false;
                          profileItems = [
                            {
                              'icon': 'assets/icons/profile.svg',
                              'text': _nameController.text,
                              'controller': _nameController
                            },
                            {
                              'icon': 'assets/icons/calendar.svg',
                              'text': _birthdayController.text,
                              'controller': _birthdayController
                            },
                            {
                              'icon': 'assets/icons/sms.svg',
                              'text': _emailController.text,
                              'controller': _emailController
                            },
                            {
                              'icon': 'assets/icons/call.svg',
                              'text': _phoneController.text,
                              'controller': _phoneController
                            },
                            {
                              'icon': 'assets/icons/female.svg',
                              'text': _genderController.text,
                              'controller': _genderController
                            }
                          ];
                        });
                      },
                      text: 'Save',
                      textAlignment: MainAxisAlignment.center,
                      letterSpacing: .09,
                      fontWeight: FontWeight.w500,
                      lineHeight: 2)
                  : customButton(
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
          ),
        ),
      ),
    );
  }
}
