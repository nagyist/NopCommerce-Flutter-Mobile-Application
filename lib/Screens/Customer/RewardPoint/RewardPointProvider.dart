/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/RewardPoint/Model/GetCustomerRewardPointModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/RewardPointService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class RewardPointProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isLazyLoader=false;
  int pageNumber=1;
  List<RewardPoint> rewardPoints=[];
  late GetCustomerRewardPointsModel getCustomerRewardPointsModel;
  HeaderInfoResponseModel headerModel = new HeaderInfoResponseModel(
      isAuthenticated: false,
      customerName: "",
      shoppingCartEnabled: false,
      shoppingCartItems: 0,
      wishlistEnabled: false,
      wishlistItems: 0,
      allowPrivateMessages: false,
      unreadPrivateMessages: "",
      alertMessage: "",
      registrationType: "",
      customProperties: CustomProperties()
  );

  pageLoadData({required BuildContext context,required int pageNumbers}){
    this.pageNumber=pageNumbers;
    getCustomerRewardPoints(context: context);
    notifyListeners();
  }

  getCustomerRewardPoints({required BuildContext context})async{

    Response response = await RewardPointService().customerRewardPoint(context: context, param: '?pageNumber=$pageNumber');
    if(response.statusCode==200){
      storage.setItem(StringConstants.CACHE_REWARD_POINT, response.body);
      getCustomerRewardPointsModel=getCustomerRewardPointsModelFromJson(response.body);
      rewardPoints.addAll(getCustomerRewardPointsModel.rewardPoints);
    }
    getHeaderData(context: context);
   notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_HEADER, response.body);
      headerModel = headerInfoResponseModelFromJson(response.body);
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }else{
      storage.setItem(StringConstants.CACHE_HEADER, null);
    }
    isPageLoader = false;
    isAPILoader=false;
    notifyListeners();
  }

  Future loadMoreRewardsPoints({required BuildContext context}) async {

    if(getCustomerRewardPointsModel.pagerModel.currentPage!=getCustomerRewardPointsModel.pagerModel.totalPages){
      isLazyLoader = true;
      notifyListeners();
      Response response = await RewardPointService().customerRewardPoint(context: context, param: '?pageNumber=${getCustomerRewardPointsModel.pagerModel.currentPage+1}');
      if(response.statusCode==200){
        getCustomerRewardPointsModel=getCustomerRewardPointsModelFromJson(response.body);
        rewardPoints.addAll(getCustomerRewardPointsModel.rewardPoints);
        isLazyLoader=false;
      }
    }
    notifyListeners();
  }

  loadCacheData({required BuildContext context})async{

    isPageLoader = true;
    isAPILoader = false;
    isLazyLoader=false;
    pageNumber=1;
    rewardPoints.clear();

    getCacheCustomerRewardPoints(context: context);
    getCacheHeader(context: context);
  }

  getCacheCustomerRewardPoints({required BuildContext context})async{
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_REWARD_POINT);
    if(res != null)
    {
      getCustomerRewardPointsModel = getCustomerRewardPointsModelFromJson(res);
      rewardPoints.addAll(getCustomerRewardPointsModel.rewardPoints);
      isPageLoader = false;
      notifyListeners();
      return getCustomerRewardPointsModel;
    }else{
      return null;
    }
  }

  getCacheHeader({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_HEADER);
    if(res != null)
    {
      headerModel = headerInfoResponseModelFromJson(res);
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      return headerModel;
    }else{
      return null;
    }
  }
}