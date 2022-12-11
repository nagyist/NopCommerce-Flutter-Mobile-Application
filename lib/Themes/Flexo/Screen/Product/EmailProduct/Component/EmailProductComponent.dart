/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/EmailProduct/EmailProductProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:provider/provider.dart';

class EmailProductComponent{

  GlobalKey<FormState> form=new GlobalKey<FormState>();
  getEmailProductComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var emailProductProvider = context.watch<EmailProductProvider>();

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){

        return Form(
          key: form,
          child: Container(
            child: Column(
              children: [
                SizedBox(height: FlexoValues.heightSpace2Px),

                TextFieldWidget(
                  width: FlexoValues.controlsWidth,
                  controller: emailProductProvider.friendEmailController,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: localResourceProvider.getResourseByKey("products.emailAFriend.friendEmail.hint"),
                  required: true,
                  errorMsg: localResourceProvider.getResourseByKey("products.emailAFriend.friendEmail.required"),
                  heading: localResourceProvider.getResourseByKey("products.emailAFriend.friendEmail"),
                ),

                SizedBox(height: FlexoValues.heightSpace2Px,),

                TextFieldWidget(
                  width: FlexoValues.controlsWidth,
                  controller: emailProductProvider.yourEmailController,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: localResourceProvider.getResourseByKey("products.emailAFriend.yourEmailAddress.hint"),
                  required: true,
                  errorMsg: localResourceProvider.getResourseByKey("products.emailAFriend.yourEmailAddress.required"),
                  heading: localResourceProvider.getResourseByKey("products.emailAFriend.yourEmailAddress"),
                ),

                SizedBox(height: FlexoValues.heightSpace2Px,),

                TextFieldWidget(
                  width: FlexoValues.controlsWidth,
                  controller: emailProductProvider.messageController,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: localResourceProvider.getResourseByKey("products.emailAFriend.personalMessage.hint"),
                  required: false,
                  maxLine: 5,
                  heading: localResourceProvider.getResourseByKey("products.emailAFriend.personalMessage"),
                ),

                SizedBox(height: FlexoValues.heightSpace3Px,),

                ButtonWidget().getButton(
                    text: localResourceProvider.getResourseByKey('products.emailAFriend.button').toString().toUpperCase(),
                    width: FlexoValues.controlsWidth,
                    onClick: ()
                    {
                      KeyboardUtil.hideKeyboard(context);
                      if(form.currentState!.validate()){
                        emailProductProvider.submitOnClickEvent(context: context);
                      }
                    },
                    isApiLoad: emailProductProvider.isAPILoader
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}