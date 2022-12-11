/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Wishlist/EmailWishlist/EmailWishlistProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:provider/provider.dart';

class FlexoEmailWishlist extends StatefulWidget {
  const FlexoEmailWishlist({Key? key}) : super(key: key);

  @override
  State<FlexoEmailWishlist> createState() => _FlexoEmailWishlistState();
}

class _FlexoEmailWishlistState extends State<FlexoEmailWishlist> {
  GlobalKey<FormState> form = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var emailWishlistProvider = context.watch<EmailWishlistProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.wishlist"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: emailWishlistProvider.headerModel,headerLoader: emailWishlistProvider.isPageLoader),
        body: emailWishlistProvider.isPageLoader ? Loaders.pageLoader() :
        Column(
          children: [

            emailWishlistProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: form,
                    child: Column(
                      children: [

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                        TextFieldWidget(
                          width: FlexoValues.controlsWidth,
                          controller: emailWishlistProvider.friendEmailController,
                          hintText: localResourceProvider.getResourseByKey("wishlist.emailAFriend.friendEmail.hint"),
                          required: true,
                          errorMsg: localResourceProvider.getResourseByKey("wishlist.emailAFriend.friendEmail.required"),
                          heading: localResourceProvider.getResourseByKey("wishlist.emailAFriend.friendEmail"),
                          keyBoardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                        TextFieldWidget(
                          width: FlexoValues.controlsWidth,
                          controller: emailWishlistProvider.yourEmailController,
                          hintText: localResourceProvider.getResourseByKey("wishlist.emailAFriend.yourEmailAddress.hint"),
                          required: true,
                          errorMsg: localResourceProvider.getResourseByKey("wishlist.emailAFriend.yourEmailAddress.required"),
                          heading: localResourceProvider.getResourseByKey("wishlist.emailAFriend.yourEmailAddress"),
                          keyBoardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                        TextFieldWidget(
                          width: FlexoValues.controlsWidth,
                          controller: emailWishlistProvider.messageController,
                          hintText: localResourceProvider.getResourseByKey("wishlist.emailAFriend.personalMessage.hint"),
                          required: false,
                          errorMsg: localResourceProvider.getResourseByKey("wishlist.emailAFriend.personalMessage.required"),
                          heading: localResourceProvider.getResourseByKey("wishlist.emailAFriend.personalMessage"),
                          keyBoardType: TextInputType.multiline,
                          maxLine: 5,
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                        ButtonWidget().getButton(
                            text: localResourceProvider.getResourseByKey("wishlist.emailAFriend.button").toString().toUpperCase(),
                            width: FlexoValues.controlsWidth,
                            onClick: ()
                            {
                              KeyboardUtil.hideKeyboard(context);
                              if(form.currentState!.validate())
                              {
                                emailWishlistProvider.shareEmailWishlist(context: context);
                              }
                            },
                            isApiLoad: false
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}