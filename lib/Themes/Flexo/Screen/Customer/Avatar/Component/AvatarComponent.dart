/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/Avatar/AvatarProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:provider/provider.dart';

class AvatarComponent{

  getAvatarComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var avatarProvider = context.watch<AvatarProvider>();
    return StatefulBuilder(builder: (context, setState){
      return  Container(
       width: FlexoValues.deviceWidth,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: FlexoValues.deviceWidth * 0.06,),

                (avatarProvider.imageFile == null || avatarProvider.imageFile == "" || avatarProvider.imageFile.path == ""  ||avatarProvider.imageFile.path == null) && avatarProvider.getAvatarResponseModel.avatarUrl.isEmpty ?
                Container(
                  child:FlexoTextWidget().contentText17(text: StringConstants.NO_FILE_SELECTED,)
                ) :
                Container(
                  height:FlexoValues.deviceWidth * 0.3,
                  width: FlexoValues.deviceWidth * 0.3,
                  child:avatarProvider.imageNetwork? CachedNetworkImage(imageUrl: avatarProvider.getAvatarResponseModel.avatarUrl,):Image.file(avatarProvider.imageFile,),
                ),

                SizedBox(height: FlexoValues.deviceWidth * 0.06,),

                Container(
                  width:FlexoValues.deviceWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      avatarProvider.getAvatarResponseModel.avatarUrl.isNotEmpty ?
                      GestureDetector(
                        onTap: ()async{

                          DialogBoxWidget().deleteItemDialogBox(
                              context: context,
                              title: localResourceProvider.getResourseByKey("common.deleteConfirmation"),
                              cancelText: localResourceProvider.getResourseByKey("common.cancel"),
                              submitText: localResourceProvider.getResourseByKey("common.delete"),
                              isCancelable: true,
                              onSubmit: () async
                              {
                                if(await CheckConnectivity().checkInternet(context)){
                                  avatarProvider.deleteButtonClickEvent(context: context);
                                }
                              }
                          );
                        },
                        child: Container(
                          width:FlexoValues.deviceWidth * 0.96,
                          height:FlexoValues.deviceHeight * 0.07,
                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: avatarProvider.getAvatarResponseModel.avatarUrl.isEmpty ? FlexoColorConstants.BUTTON_COLOR_GREY : Colors.red,
                          ),
                          child: Text(
                            localResourceProvider.getResourseByKey("account.avatar.removeAvatar").toString().toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:FlexoColorConstants.BUTTON_TEXT_COLOR,
                                fontSize: FlexoValues.fontSize17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ) :

                      avatarProvider.imageFile == null || avatarProvider.imageFile == "" || avatarProvider.imageFile.path == ""  ||avatarProvider.imageFile.path == null ?

                      GestureDetector(
                        onTap: ()async{
                           if(await CheckConnectivity().checkInternet(context) ){
                             avatarProvider.openFileExplorer(context: context);
                           }
                        },
                        child: Container(
                          width: FlexoValues.deviceWidth * 0.96,
                          height: FlexoValues.deviceHeight * 0.07,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:FlexoColorConstants.BROWSE_BUTTON_COLOR,
                              border: Border.all(
                                  color:FlexoColorConstants.BROWSE_BUTTON_BORDER_COLOR
                              )
                          ),
                          child: FlexoTextWidget().browseButtonText(text: StringConstants.BROWSE_BUTTON),
                        ),
                      ) :
                      Container(
                        width: FlexoValues.controlsWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            GestureDetector(
                              onTap: ()async{
                                 if(await CheckConnectivity().checkInternet(context) ){
                                   avatarProvider.openFileExplorer(context: context);
                                 }
                              },
                              child: Container(
                                width: FlexoValues.deviceWidth * 0.47,
                                height:FlexoValues.deviceHeight* 0.07,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: FlexoColorConstants.BROWSE_BUTTON_COLOR,
                                    border: Border.all(
                                        color: FlexoColorConstants.BROWSE_BUTTON_BORDER_COLOR
                                    )
                                ),
                                child: FlexoTextWidget().browseButtonText(text: StringConstants.BROWSE_BUTTON),
                              ),
                            ),

                            GestureDetector(
                              onTap : ()async
                              {
                                if(avatarProvider.size){
                                 if(await CheckConnectivity().checkInternet(context))
                                 {
                                  if(avatarProvider.getAvatarResponseModel.avatarUrl.isEmpty){
                                    if (avatarProvider.imageFile == null || avatarProvider.imageFile == "" || avatarProvider.imageFile.path == ""  ||avatarProvider.imageFile.path == null){
                                      FlushBarMessage().failedMessage(context: context, title: StringConstants.SELECTED_IMAGE);
                                    }
                                    else{
                                      avatarProvider.uploadButtonClickEvent(context: context, imgBase64: avatarProvider.base64, imageName:  avatarProvider.imageName);
                                    }
                                  }
                                   }
                                }else{
                                  FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("account.avatar.uploadRules"));
                                }
                              },
                              child: Container(
                                width: FlexoValues.deviceWidth * 0.47,
                                height: FlexoValues.deviceHeight * 0.07,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: FlexoColorConstants.BUTTON_COLOR,
                                ),
                                child: Text(
                                  localResourceProvider.getResourseByKey("common.upload").toString().toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:TextStyle(
                                      color:FlexoColorConstants.BUTTON_TEXT_COLOR,
                                      fontSize: FlexoValues.fontSize17,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                  child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("account.avatar.uploadRules")),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}