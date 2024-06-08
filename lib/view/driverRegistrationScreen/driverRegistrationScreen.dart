// ignore_for_file: use_build_context_synchronously

import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:covefood_domiciliario/controller/provider/profileProvider/profileProvider.dart';
import 'package:covefood_domiciliario/controller/services/profileServices/profileServices.dart';
import 'package:covefood_domiciliario/model/driverModel/driverModel.dart';
import 'package:covefood_domiciliario/utils/colors.dart';
import 'package:covefood_domiciliario/utils/textStyles.dart';
import 'package:covefood_domiciliario/widgets/commonElevatedButton.dart';
import 'package:covefood_domiciliario/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DriverRegistrationScreen extends StatefulWidget {
  const DriverRegistrationScreen({super.key});

  @override
  State<DriverRegistrationScreen> createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController vehicleRegistrationController = TextEditingController();
  TextEditingController drivingLicenseNumber = TextEditingController();
  bool registerButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
            return InkWell(
              onTap: () async {
                await context
                    .read<ProfileProvider>()
                    .pickImageFromGallery(context);
              },
              child: CircleAvatar(
                radius: 5.h,
                backgroundColor: black,
                child: CircleAvatar(
                    backgroundColor: white,
                    radius: 5.h - 2,
                    backgroundImage: profileProvider.profileImage != null
                        ? FileImage(profileProvider.profileImage!)
                        : null,
                    child: profileProvider.profileImage == null
                        ? FaIcon(
                            FontAwesomeIcons.user,
                            size: 4.h,
                            color: black,
                          )
                        : null),
              ),
            );
          }),
          SizedBox(
            height: 4.h,
          ),
          CommonTextfield(
            controller: nameController,
            title: 'Nombre',
            hintText: 'Nombre',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
            controller: vehicleRegistrationController,
            title: 'Placa',
            hintText: 'Placa del vehiculo',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
            controller: drivingLicenseNumber,
            title: 'Numero de licencia de conducción',
            hintText: 'Licencia de conducción',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 35.h,
          ),
          CommonElevatedButton(
            onPressed: () async {
              setState(() {
                registerButtonPressed = true;
              });
              await context
                  .read<ProfileProvider>()
                  .uploadImageAndGetImageURL(context);
              DriverModel driverData = DriverModel(
                name: nameController.text.trim(),
                profilePictureURL:
                    context.read<ProfileProvider>().profileImageURL,
                mobileNumber: auth.currentUser!.phoneNumber,
                driverID: auth.currentUser!.uid,
                vehicleRegistrationNumber:
                    vehicleRegistrationController.text.trim(),
                drivingLicenceNumber: drivingLicenseNumber.text.trim(),
                registeredDateTime: DateTime.now(),
              );
              ProfileServices.registerDriver(driverData, context);
            },
            color: black,
            child: registerButtonPressed
                ? CircularProgressIndicator(
                    color: white,
                  )
                : Text(
                    'Registrarse',
                    style: AppTextStyles.body16Bold.copyWith(color: white),
                  ),
          ),
        ],
      ),
    ));
  }
}
