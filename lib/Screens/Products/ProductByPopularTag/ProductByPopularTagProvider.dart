/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/GetCatalogRootModel.dart';
import 'package:nopcommerce/Models/ProductBoxModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductsByTagModel.dart';
import 'package:nopcommerce/Screens/Products/ProductTag/Model/GetPopularProductTagsModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductByCategoryService.dart';
import 'package:nopcommerce/Services/ProductTagService.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';

class ProductByPopularTagProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isLazyLoader = false;
  int selectedPage = 6;
  int pageNumber=1;
  int pageSize=0;
  int selectedSortRadioGroup = 1;
  int orderBy=0;
  int tagId=0;
  int selectedAttribute=0;
  int minPrice=0;
  int maxPrice=10000000;
  int totalPages=0;
  String selectedSort = "";
  String filterAttributes='';
  String filterAttributesDrawer='';
  List<DropDownModel> sortList = [];
  List<DropDownModel> page=[];
  List<int> filterByAttributes=[];
  List<int> pageNumberList=[];
  List<ProductBoxModel> products=[];
  late List<GetCatalogRootModel> getCatalogRootModel;
  late GetProductsByTagModel getProductsByTagModel;
  late GetPopularProductTagsModel getPopularProductTagsModel;
  RangeValues currentRangeValues =  RangeValues(0, 1000);
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

  pageLoadData({required BuildContext context,required int id }){
    isPageLoader = true;
    isAPILoader = false;
    this.tagId=id;
    selectedSort = "";
    filterAttributes='';
    filterAttributesDrawer='';
    selectedPage = 6;
    pageNumber=1;
    pageSize=0;
    selectedSortRadioGroup = 1;
    orderBy=0;
    selectedAttribute=0;
    minPrice=0;
    maxPrice=10000000;
    totalPages=0;
    filterByAttributes.clear();
    sortList = [];
    page=[];
    filterByAttributes=[];
    pageNumberList=[];
    products=[];
    notifyListeners();
    getProductTagData(context: context, minPrice: minPrice, maxPrice: maxPrice, orderBy: orderBy, pageSize: pageSize, pageNumber: pageNumber, filterAttributes: filterAttributes);

  }

  getProductTagData({required BuildContext context, required int minPrice, required int maxPrice, required int orderBy, required int pageSize, required int pageNumber, required String filterAttributes})async{

    isAPILoader = true;
    notifyListeners();
    Response response = await ProductTagService().getProductByPopularTag(context: context, param: '/$tagId?Price=$minPrice-$maxPrice&OrderBy=$orderBy&PageSize=$pageSize&PageNumber=$pageNumber&specs=$filterAttributes');
    if(response.statusCode==200){
      getProductsByTagModel=getProductsByTagModelFromJson(response.body);
      products.clear();
      products.addAll(getProductsByTagModel.catalogProductsModel.products);
      if(getProductsByTagModel.catalogProductsModel.priceRangeFilter.enabled)
      {
        currentRangeValues =  RangeValues(getProductsByTagModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.from.toDouble(), getProductsByTagModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.to.toDouble());
      }
      sortList.clear();
      for(var i in getProductsByTagModel.catalogProductsModel.availableSortOptions){
        if(selectedSort == "")
        {
          if(i.selected){
            selectedSort=i.text;
            List<AvailableSortOption> list= getProductsByTagModel.catalogProductsModel.availableSortOptions.where((element) => element.text==selectedSort).toList();
            getProductsByTagModel.catalogProductsModel.orderBy=int.parse(list[0].value);
          }
        }
        sortList.add(DropDownModel(text: i.text ,value:i.value,));
      }
      page.clear();
      for(var i in getProductsByTagModel.catalogProductsModel.pageSizeOptions){
        if(i.selected==true){
          pageSize=int.parse(i.text);
          selectedPage=pageSize;
        }
        page.add(DropDownModel(text: i.text ,value:i.value,));
      }
      pageNumberList.clear();
      int i=1;
      while(i<=getProductsByTagModel.catalogProductsModel.totalPages){
        pageNumberList.add(i);
        i++;
      }
      totalPages = getProductsByTagModel.catalogProductsModel.totalPages;

      if(getProductsByTagModel.catalogProductsModel.specificationFilter.enabled) {
        filterByAttributes.clear();
        for (var i in getProductsByTagModel.catalogProductsModel.specificationFilter.attributes) {
          for (var j in i.values) {
            if (j.selected) {
              filterByAttributes.add(j.id);
            }
          }
        }
      }
      if(getProductsByTagModel.catalogProductsModel.priceRangeFilter.enabled)
      {
        selectedAttribute = 0;
      }else if(getProductsByTagModel.catalogProductsModel.specificationFilter.enabled){
        selectedAttribute = 1;
      }else{
        selectedAttribute = 3;
      }
      isAPILoader=false;
    }
    getPopularProductTagsData(context: context);
    notifyListeners();
  }

  getPopularProductTagsData({required BuildContext context})async{

    Response response = await ProductTagService().getProductTag(context: context);
    if(response.statusCode==200){
      getPopularProductTagsModel=getPopularProductTagsModelFromJson(response.body);
    }
    getCatalogRoot(context: context);
    notifyListeners();
  }

  getCatalogRoot({required BuildContext context})async{

    Response response = await ProductByCategoryService().catalogRoot(context: context);
    if(response.statusCode==200){
      getCatalogRootModel=getCatalogRootModelFromJson(response.body);
    }
    getHeaderData(context: context);
    notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      headerModel = headerInfoResponseModelFromJson(response.body);
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }
    isPageLoader = false;
    isAPILoader=false;
    notifyListeners();

  }

  doneOnclickEvent({required BuildContext context})async
  {
    isAPILoader = true;
    notifyListeners();
    filterAttributesDrawer='$filterByAttributes';
    filterAttributesDrawer = filterAttributesDrawer.substring(1, filterAttributesDrawer.length-1);
    pageNumber = 1;
    Navigator.pop(context);
    if(maxPrice!=0){
      getProductTagData(context: context, minPrice: minPrice, maxPrice: maxPrice, orderBy: getProductsByTagModel.catalogProductsModel.orderBy, pageSize: getProductsByTagModel.catalogProductsModel.pageSize, pageNumber: pageNumber, filterAttributes: filterAttributesDrawer);
    }else{
      FlushBarMessage().failedMessage(context: context, title: StringConstants.INVALID_SLIDER_PRICE_MESSAGE);
      isAPILoader = false;
    }
    notifyListeners();
  }

  filterAttributesOnclickEvent(StateSetter setState, e,){
    setState(() {
      e.selected=!e.selected;
      if(e.selected==true){
        filterByAttributes.add(int.parse(e.value));
      }else{
        filterByAttributes.remove(int.parse(e.value));
      }
    });
  }

  Future loadMoreProduct({required BuildContext context}) async {

    if(getProductsByTagModel.catalogProductsModel.pageNumber!=getProductsByTagModel.catalogProductsModel.totalPages)
    {
      isLazyLoader = true;
      notifyListeners();
      Response response=await ProductTagService().getProductByPopularTag(context: context, param: '/$tagId?Price=$minPrice-$maxPrice&OrderBy=${getProductsByTagModel.catalogProductsModel.orderBy}&PageSize=${getProductsByTagModel.catalogProductsModel.pageSize}&PageNumber=${getProductsByTagModel.catalogProductsModel.pageNumber+1}&specs=$filterByAttributes');
      if(response.statusCode==200){
        getProductsByTagModel=getProductsByTagModelFromJson(response.body);
      }
      products.addAll(getProductsByTagModel.catalogProductsModel.products);
      isLazyLoader = false;
    }
    notifyListeners();
  }

  sortByChange({required String val,required BuildContext context})async{
    selectedSort = val;
    List<AvailableSortOption> list= getProductsByTagModel.catalogProductsModel.availableSortOptions.where((element) => element.text==selectedSort).toList();
    getProductsByTagModel.catalogProductsModel.orderBy=int.parse(list[0].value);
    isAPILoader=true;
    await getProductTagData(context: context, minPrice: minPrice, maxPrice: maxPrice, orderBy: getProductsByTagModel.catalogProductsModel.orderBy, pageSize: getProductsByTagModel.catalogProductsModel.pageSize, pageNumber: pageNumber, filterAttributes: filterAttributesDrawer);
    isAPILoader=false;
    notifyListeners();
  }

  clearFilter({required BuildContext context})async{
   filterByAttributes.clear();
   notifyListeners();
   filterAttributesDrawer='$filterByAttributes';
   filterAttributesDrawer = filterAttributesDrawer.substring(1, filterAttributesDrawer.length-1);
   pageNumber = 1;
   minPrice=0;
   maxPrice=100000000;
   getProductTagData(context: context, minPrice: minPrice, maxPrice: maxPrice, orderBy: getProductsByTagModel.catalogProductsModel.orderBy, pageSize:  getProductsByTagModel.catalogProductsModel.pageSize, pageNumber: pageNumber, filterAttributes: filterAttributesDrawer);
   notifyListeners();
  }

}