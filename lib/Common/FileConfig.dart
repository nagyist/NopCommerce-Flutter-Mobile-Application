/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Utils/ApplicationStorage.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileConfig {

  permissionCheck({required BuildContext context,required String messageType})async{

    if(CheckDeviceType().isIOS())
    {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [Permission.photos,].request();
        if(statuses[Permission.photos]==PermissionStatus.permanentlyDenied){
          DialogBoxWidget().permissionBox(context: context, message: messageType);
        }
        return false;
      }else{
        return true;
      }

    }else{

      var status = await Permission.storage.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [Permission.storage,].request();
        if(statuses[Permission.storage]==PermissionStatus.permanentlyDenied){
          DialogBoxWidget().permissionBox(context: context, message: messageType);
        }
        return false;
      }else{
        return true;
      }
    }
  }


  saveFile({required BuildContext context, required String base64,required String fileName,required String fileType}) async
  {
    bool permissionGranted = await permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      if(CheckDeviceType().isIOS())
      {
        var bytes = base64Decode(base64.replaceAll('\n', ''));
        Directory? downloadsDirectory = await getApplicationDocumentsDirectory();
        final file = File("${downloadsDirectory.path}/$fileName.$fileType");
        await file.writeAsBytes(bytes.buffer.asUint8List());
        OpenFile.open("${downloadsDirectory.path}/$fileName.$fileType");
      }else{
        DateTime now = DateTime.now();
        String dateTimeName= DateFormat("yyyyMMddHms").format(now);

        fileName += "_$dateTimeName";

        String appFolder = await saveFolderPath();
        if(appFolder == "" || appFolder == null)
        {
          Directory directory = await getApplicationDocumentsDirectory();
          appFolder = directory.path;
        }

        var bytes = base64Decode(base64.replaceAll('\n', ''));

        String fileFullPath = "$appFolder/$fileName.$fileType";
        final file = File(fileFullPath);

        await file.writeAsBytes(bytes.buffer.asUint8List());
        OpenFile.open(fileFullPath);
      }
    }

  }

  Future<String> saveFolderPath() async {
    Directory? directory;
    try {
      directory = await getExternalStorageDirectory();
      String newPath = "";
      List<String> paths = directory!.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath +"/"+ ApplicationStorage.APPLICATION_ANDROID_FOLDER_NAME;
      directory = Directory(newPath);

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        return directory.path;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }
}