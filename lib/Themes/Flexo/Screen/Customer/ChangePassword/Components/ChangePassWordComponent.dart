/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldConfirmPasswordWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/ChangePassword/ChangePasswordProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FormErrorsWidget.dart';
import 'package:provider/provider.dart';

class ChangePassWordComponent{

  getChangePassWordComponent({required BuildContext context})
  {
    var changePasswordProvider = context.watch<ChangePasswordProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    return StatefulBuilder(builder: (context, setState){
      return Container(
        child: Form(
          key: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: FlexoValues.widthSpace2Px),
                  Column(
                    children: [
                      Container(
                        width: FlexoValues.controlsWidth,
                        child: FormErrorWidget(errors: changePasswordProvider.errors),
                      ),
                      SizedBox(height: FlexoValues.widthSpace2Px),
                    ],
                  ),
                ],
              ),

              TextFieldWidget(
                textFieldType: TextFieldType.Password,
                width: FlexoValues.controlsWidth,
                controller: changePasswordProvider.passwordController,
                errorMsg:localResourceProvider.getResourseByKey("account.changePassword.fields.oldPassword.required"),
                required: true,
                hintText: localResourceProvider.getResourseByKey("account.changePassword.fields.oldPassword"),
                icon:Ionicons.lock_closed_outline,
              ),

              SizedBox(height:FlexoValues.heightSpace2Px),

              TextFieldWidget(
                textFieldType: TextFieldType.Password,
                width: FlexoValues.controlsWidth,
                controller: changePasswordProvider.newPasswordController,
                errorMsg:localResourceProvider.getResourseByKey("account.changePassword.fields.confirmNewPassword.required"),
                required: true,
                hintText: localResourceProvider.getResourseByKey("account.passwordRecovery.newPassword"),
                icon: Ionicons.lock_closed_outline,
              ),

              SizedBox(height:FlexoValues.heightSpace2Px),

              TextFieldConfirmPasswordWidget(
                width:FlexoValues.controlsWidth,
                controller:changePasswordProvider.confirmPassController ,
                controller2:changePasswordProvider.newPasswordController ,
                errorMsg:localResourceProvider.getResourseByKey("account.changePassword.fields.confirmNewPassword.required"),
                errorMsgConfirmPassword:localResourceProvider.getResourseByKey("account.changePassword.fields.newPassword.enteredPasswordsDoNotMatch"),
                required: true,
                hintText: localResourceProvider.getResourseByKey("account.changePassword.fields.confirmNewPassword"),
                icon: Ionicons.lock_closed_outline,
                isPassword: true,
              ),

              SizedBox(height: FlexoValues.widthSpace4Px,),

              ButtonWidget().getButton(
                  text:localResourceProvider.getResourseByKey('account.changePassword.button').toString().toUpperCase(),
                  width: FlexoValues.controlsWidth,
                  onClick: ()async
                  {
                    KeyboardUtil.hideKeyboard(context);
                    if(await CheckConnectivity().checkInternet(context)){
                      if(form.currentState!.validate()) {
                        changePasswordProvider.updateButtonClickEvent(context: context);
                      }
                     }
                    },
                  isApiLoad: false
              )
            ],
          ),
        ),
      );
    });
  }
}