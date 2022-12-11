/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/AppliedDiscountsWithCode.dart';
import 'package:nopcommerce/Models/AttributeValueModel.dart';
import 'package:nopcommerce/Models/CountryStateModel.dart';
import 'package:nopcommerce/Models/GetTopicBlockModel.dart';
import 'package:nopcommerce/Models/GiftCardDataModel.dart';
import 'package:nopcommerce/Models/OrderTotals.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckout.dart';
import 'package:nopcommerce/Screens/Checkout/OnePageCheckout.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingChangeRequestModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingRequestModel.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Screens/Home/Models/HomeModel/NivoSliderModel.dart';
import 'package:nopcommerce/Screens/Home/Models/ShoppingCartModel/CartEstimateShippingRequestModel.dart';
import 'package:nopcommerce/Models/CurrencyResponseModel.dart';
import 'package:nopcommerce/Screens/Home/Models/GetCustomerNavigationModel.dart';
import 'package:nopcommerce/Models/GetLanguageModel.dart';
import 'package:nopcommerce/Models/TaxTypeModel.dart';
import 'package:nopcommerce/Models/CommonStateModel.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Models/UploadFileModel.dart';
import 'package:nopcommerce/Models/ProductBoxModel.dart';
import 'package:nopcommerce/Screens/Home/Models/ShoppingCartModel/CartAttributeChangeResponseModel.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Screens/Customer/Login/Login.dart';
import 'package:nopcommerce/Screens/Home/Models/GetTopMenuModel.dart';
import 'package:nopcommerce/Models/CommonProductResponseModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/CustomerService.dart';
import 'package:nopcommerce/Services/HomeService.dart';
import 'package:nopcommerce/Services/ShoppingCartService.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/MainScreen/CategoryPage/CategoryPage.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/MainScreen/HomePage/HomePage.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/MainScreen/ProfilePage/ProfilePage.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/MainScreen/ShoppingCartPage/ShoppingCart.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/HomeModel/GetHomepageCategoriesModel.dart';
import 'Models/HomeModel/GetNivoSliderModel.dart';
import 'Models/ShoppingCartModel/CartFilterEstimateShippingResponseModel.dart';
import 'Models/ShoppingCartModel/DiscountCouponResponseModel.dart';
import 'Models/ShoppingCartModel/EstimateShippingResponseModel.dart';
import 'Models/ShoppingCartModel/GetCartModel.dart';
import 'Models/ShoppingCartModel/GiftCardResponseModel.dart';
import 'Models/ShoppingCartModel/OrderTotalResponseModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class HomeProvider extends ChangeNotifier{

  bool isStartCheckoutCheckbox=false;

  List<Widget> homeTabs = [
    HomePage(),
    CategoryPage(),
    ShoppingCartPage(),
    ProfilePage(),
  ];
  late GetNivoSliderModel nivoSliderModel;
  bool networkHomeLoader = true;
  bool networkCategoryLoader = true;
  bool networkCartLoader = true;
  bool networkProfileLoader = true;
  bool categoryLoader = true;
  bool profileLoader = true;
  bool isNivoLoader = true;
  bool isHomePageRefresh = false;
  bool isTopMenuLoader = true;
  bool isHomePageCategoryLoader = true;
  bool isHomePageProductsLoader = true;
  bool isHomePageBestSellerLoader = true;
  bool isHeaderLoader = true;
  bool isExpandCategory=false;
  bool isCartLoader=true;
  bool isProfileLoad=true;
  bool isCartDataRefresh=false;
  bool isDiscountApplied=false;
  bool isGiftCardApplied=false;
  int selected=-1;
  int currentTabIndex = 0;
  Map<int,bool> categoryExpandList={};
  List<NivoSlider> nivoSlider=[];
  ScrollController homeScrollController = ScrollController();
  ScrollController categoryScrollController = ScrollController();
  ScrollController cartScrollController = ScrollController();
  ScrollController profileScrollController = ScrollController();
  String discountCouponMsg="";
  String giftCardCouponMsg="";
  TextEditingController discountCodeController = new TextEditingController();
  TextEditingController giftCardController = new TextEditingController();
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

  List<GetHomepageCategoriesModel> getHomepageCategoriesModel=[];
  List<ProductBoxModel> getHomepageProductsModel = [];
  List<ProductBoxModel> getHomepageBestSellerModel = [];

  late GetTopMenuModel getTopMenuModel;
  late GetCartModel getCartModel;
  List<ProductBoxModel> crossSellProduct = [];
  late OrderTotals orderTotalResponseModel;
  var estimateShippingResponseModel;

  late ProductEstimateShippingRequestModel productEstimateShippingRequestModel;
  late CartEstimateShippingRequestModel cartEstimateShippingRequestModel;
  late CartFilterEstimateShippingResponseModel cartFilterEstimateShippingResponseModel;
  ProductEstimateShippingChangeRequestModel preEstimateShipping = new ProductEstimateShippingChangeRequestModel(zipPostalCode: "",city: "",stateId: 0,countryId: 0,productId: 0,date: "",name: "",price: "",stateName: "",countryName: "");

  Map<int,bool> isCartItemDeleteMap={};

  late GetTopicBlockModel getTopicBlockModel;
  String topicTitle="";
  String topicBody="";


  late GiftCardResponseModel giftCardModel;
  Map<String, int> radioMap = {};
  List<Value> checkList=[];
  Map<int, TextEditingController> datePickerMap = {};
  Map<int, String> fileUploadMap = {};
  String fileGuid='';
  bool removeShow=true;
  UploadFileModel uploadFileModel = new UploadFileModel(success: false, uploadedFileGuid: "", message: "");

  Map<String,String> cartChangedAttributes={};
  Map<String,String> startCheckoutMap={};


  String _fileName="";
  String _filePath="";
  String base64="";
  List<PlatformFile>? _paths;
  String? _extension;
  List<DropDownModel> availableCountryList=[];
  List<DropDownModel> availableStateList=[];
  List<DropDownModel> filterStateList=[];
  List<StateModel> stateModelList=[];
  bool estimateShipping= false;
  int selectedCountry=0;
  int selectedState=0;
  String selectedCountryName="";
  String selectedStateName="";

  Map<String, String> attributes = {};
  late EstimateShippingResponseModel estimateShippingModel;
  late Directory downloadsDirectory;
  late TaxTypeModel taxTypeModel;

  late GetLanguagesModel getLanguagesModel;
  late CurrencyResponseModel  currencyResponseModel;
  late GetCustomerNavigationModel getCustomerNavigationModel;
  List<CustomerNavigationItem> customerNavigationItems=[];

  readConditionBox({required BuildContext context,required String title,required String body}) async
  {
    DialogBoxWidget().informationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("checkout.termsOfService"), body: body, heading: title);
  }

  loadCacheData({required BuildContext context}) async
  {
    isCartDataRefresh = true;
    isProfileLoad = true;
    notifyListeners();

    await getCacheCategoryList();

    var cacheNivoSlider = await getCacheNivoSlider();
    if(cacheNivoSlider != null)
    {
      nivoSliderModel = cacheNivoSlider;
      nivoSliderModel.picture1Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture1Url, nivoSliderModel.link1, nivoSliderModel.text1, nivoSliderModel.altText1)): null;
      nivoSliderModel.picture2Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture2Url, nivoSliderModel.link2, nivoSliderModel.text2, nivoSliderModel.altText2)): null;
      nivoSliderModel.picture3Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture3Url, nivoSliderModel.link3, nivoSliderModel.text3, nivoSliderModel.altText3)): null;
      nivoSliderModel.picture4Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture4Url, nivoSliderModel.link4, nivoSliderModel.text4, nivoSliderModel.altText4)): null;
      nivoSliderModel.picture5Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture5Url, nivoSliderModel.link5, nivoSliderModel.text5, nivoSliderModel.altText5)): null;

      isNivoLoader = false;
      notifyListeners();
    }

    await getCacheHomeCategory();
    await getCacheHomeProducts();
    await getCacheHomeBestSeller();

    await getCacheCartData();

    await getCacheCartCrossSell();

    await getCacheCartOrderTotal();

    var cacheCartEstimateShipping = await getCacheCartEstimateShipping();

    if(cacheCartEstimateShipping != null)
    {
      if(estimateShippingResponseModel != null)
      {
        isCartLoader = false;
        notifyListeners();
      }else{
        isCartLoader = false;
        notifyListeners();
      }
    }else{
      isCartLoader = false;
      notifyListeners();
    }

    var cacheLanguage = await getCacheLanguage();

    if(cacheLanguage != null)
    {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt(SharedPreferencesValues.SHARED_PREFERENCE_LANGUAGE_ID, getLanguagesModel.currentLanguageId);

    }
    await getCacheCurrency();

    await getCacheTaxType();

    var cacheHeader = await getCacheHeader();

    if(cacheHeader != null)
    {
      if(!isHeaderLoader)
      {
        if(headerModel.isAuthenticated)
        {
          var cacheNavigator = await getCacheNavigator();
          if(cacheNavigator != null)
          {
            isProfileLoad =false;
            notifyListeners();
          }

        }else {
          isProfileLoad =false;
          notifyListeners();
        }
      }
    }
  }

  setPageIndex({required BuildContext context,required int tabIndex})
  {
    this.currentTabIndex = tabIndex;
    notifyListeners();
  }

  homePageRefresh({required BuildContext context})
  {
    pageLoadData(context: context);
  }

  pageLoadData({required BuildContext context}) async
  {
    isHomePageRefresh = true;
    isCartDataRefresh = true;
    notifyListeners();

    Response response = await HomeService().getNivoSlider(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_NIVO_SLIDER, response.body);
      });

      nivoSliderModel = getNivoSliderModelFromJson(response.body);
      nivoSliderModel.picture1Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture1Url, nivoSliderModel.link1, nivoSliderModel.text1, nivoSliderModel.altText1)): null;
      nivoSliderModel.picture2Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture2Url, nivoSliderModel.link2, nivoSliderModel.text2, nivoSliderModel.altText2)): null;
      nivoSliderModel.picture3Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture3Url, nivoSliderModel.link3, nivoSliderModel.text3, nivoSliderModel.altText3)): null;
      nivoSliderModel.picture4Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture4Url, nivoSliderModel.link4, nivoSliderModel.text4, nivoSliderModel.altText4)): null;
      nivoSliderModel.picture5Url.isNotEmpty ? nivoSlider.add(NivoSlider(nivoSliderModel.picture5Url, nivoSliderModel.link5, nivoSliderModel.text5, nivoSliderModel.altText5)): null;

    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_NIVO_SLIDER, null);
      });
    }
    isNivoLoader = false;
    notifyListeners();
    getHeaderData(context: context);
    getHomeCategories(context: context);
    getTopMenuData(context: context);
    getCartData(context: context);
    getLanguage(context: context);
  }

  getHomeCategories({required BuildContext context}) async {
    Response response = await HomeService().getHomeCategoryData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HOME_CATEGORY, response.body);
      });
      getHomepageCategoriesModel = getHomepageCategoriesModelFromJson(response.body);
      isHomePageCategoryLoader = false;
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HOME_CATEGORY, null);
      });
    }
    notifyListeners();
    getHomepageProduct(context: context);
  }
  getHomepageProduct({required BuildContext context})async{
    Response response =await HomeService().getHomeProductsData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HOME_PRODUCTS, response.body);
      });
      getHomepageProductsModel = commonProductResponseModelFromJson(response.body);
      isHomePageProductsLoader = false;
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HOME_PRODUCTS, null);
      });
    }

    notifyListeners();
    getHomepageBestSeller(context: context);
  }
  getHomepageBestSeller({required BuildContext context})async{
    Response response =await HomeService().getHomeBestSellerData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HOME_BESTSELLER, response.body);
      });
      getHomepageBestSellerModel = commonProductResponseModelFromJson(response.body);
      isHomePageBestSellerLoader = false;
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HOME_BESTSELLER, null);
      });
    }
    isHomePageBestSellerLoader = false;
    networkHomeLoader = false;
    isHomePageRefresh = false;
    notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HEADER, response.body);
      });
      headerModel = headerInfoResponseModelFromJson(response.body);
      isHeaderLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HEADER, null);
      });
    }
    notifyListeners();
  }

  getTopMenuData({required BuildContext context}) async {
    Response response = await HomeService().getTopMenuData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_TOP_MENU, response.body);
      });
      getTopMenuModel = getTopMenuModelFromJson(response.body);
      isTopMenuLoader = false;
      categoryLoader = false;
      notifyListeners();
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_TOP_MENU, null);
      });
    }
    networkCategoryLoader = false;
    notifyListeners();
  }


  getCartData({required BuildContext context})async {

    isCartDataRefresh = true;
    notifyListeners();

    Response response = await ShoppingCartService().getCartData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_DATA, response.body);
      });
      isCartDataRefresh = false;
      getCartModel = getCartModelFromJson(response.body);

    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_DATA, null);
      });
    }
    getCrossSellProducts(context: context);
    notifyListeners();
  }

  updateCartData({required BuildContext context})async {
    getCartData(context: context);
  }

  getCrossSellProducts({required BuildContext context})async {

    Response response = await ShoppingCartService().getCrossProductCartData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_CROSS_SELL, response.body);
      });
      crossSellProduct = commonProductResponseModelFromJson(response.body);
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_CROSS_SELL, null);
      });
    }
    getTotalOrderData(context: context);

  }

  getTotalOrderData({required BuildContext context})async {

    isCartDataRefresh=true;
    notifyListeners();

    Response response = await ShoppingCartService().getCartTotalData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_ORDER_TOTAL, response.body);
      });
      orderTotalResponseModel = orderTotalResponseModelFromJson(response.body);
      isCartDataRefresh = false;
      notifyListeners();
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_ORDER_TOTAL, null);
      });
    }

    getTopicBlockForHome(context: context);

    notifyListeners();

  }

  updateTotalOrderData({required BuildContext context})async {

    isCartDataRefresh=true;
    notifyListeners();

    Response response = await ShoppingCartService().getCartTotalData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_ORDER_TOTAL, response.body);
      });
      orderTotalResponseModel = orderTotalResponseModelFromJson(response.body);
      isCartDataRefresh = false;
      notifyListeners();
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_ORDER_TOTAL, null);
      });
    }

    updateHeaderData(context: context);

    notifyListeners();

  }

  updateHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HEADER, response.body);
      });
      headerModel = headerInfoResponseModelFromJson(response.body);
      isHeaderLoader = false;
      isCartLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_HEADER, null);
      });
    }
    notifyListeners();
  }

  getTopicBlockForHome({required BuildContext context}) async {
    Response response = await CommonService().getTopicBlock(context: context,topic: "conditionsofuse");
    await storage.ready.then((_){
      storage.setItem(StringConstants.CACHE_CART_TOPIC_BLOCK, response.body);
    });
    if(response.statusCode == 200)
    {
      getTopicBlockModel = getTopicBlockModelFromJson(response.body);
      topicTitle = getTopicBlockModel.title;
      topicBody = getTopicBlockModel.body;
    }
    notifyListeners();

    getEstimateShipping(context: context);

  }

  getEstimateShipping({required BuildContext context})async {
    Response response = await ShoppingCartService().getCartEstimateShippingData(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_ESTIMATE_SHIPPING, response.body);
      });
      estimateShippingResponseModel=estimateShippingResponseModelFromJson(response.body);
      isCartDataRefresh = false;
      estimateShippingData(context: context);
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CART_ESTIMATE_SHIPPING, null);
      });
      estimateShippingResponseModel=null;
      isCartLoader = false;
      networkCartLoader = false;
      isCartDataRefresh = false;
    }
    notifyListeners();
  }


  estimateShippingData({required BuildContext context})async {

    if(getCartModel.items.isNotEmpty){

      if(estimateShippingResponseModel != null)
      {
        EstimateShippingResponseModel estimateShipping = estimateShippingResponseModel;
        List<CountryStateModel> availableCountries = estimateShipping.availableCountries.where((element) => element.selected).toList();
        if(availableCountries.isNotEmpty)
        {
          preEstimateShipping.countryId = int.parse(availableCountries[0].value);
        }else{
          preEstimateShipping.countryId = int.parse(estimateShipping.availableCountries[0].value);
        }

        List<CountryStateModel> availableStates = estimateShipping.availableStates.where((element) => element.selected).toList();
        if(availableStates.isNotEmpty)
        {
          preEstimateShipping.stateId = int.parse(availableStates[0].value);
        }else{
          preEstimateShipping.stateId = int.parse(estimateShipping.availableStates[0].value);
        }

        cartEstimateShippingRequestModel = CartEstimateShippingRequestModel(context: context,countryId: preEstimateShipping.countryId,stateId: preEstimateShipping.stateId,city: estimateShipping.city == null ? "" :estimateShipping.city,zipPostalCode: estimateShipping.zipPostalCode == null ? "" : estimateShipping.zipPostalCode,attributes: {});
        final body ='{ '
            '"zipPostalCode": "${cartEstimateShippingRequestModel.zipPostalCode}",'
            '"city": "${cartEstimateShippingRequestModel.city}",'
            '"countryId": ${cartEstimateShippingRequestModel.countryId},'
            '"stateProvinceId": ${cartEstimateShippingRequestModel.stateId},'
            '"attributes": ${cartEstimateShippingRequestModel.attributes},'
            '}';

        Response response = await ShoppingCartService().postCartEstimateShippingData(context: context, body: body);
        if(response.statusCode == 200)
        {
          cartFilterEstimateShippingResponseModel = cartFilterEstimateShippingResponseModelFromJson(response.body);

          List<ShippingOption> shippingOptions = cartFilterEstimateShippingResponseModel.shippingOptions.where((element) => element.selected).toList();
          String name="";
          String price="";
          String date="";
          if(shippingOptions.isNotEmpty)
          {
            name = shippingOptions[0].name;
            date = shippingOptions[0].deliveryDateFormat;
            price = shippingOptions[0].price;
          }else{
            name = cartFilterEstimateShippingResponseModel.shippingOptions[0].name;
            date = cartFilterEstimateShippingResponseModel.shippingOptions[0].deliveryDateFormat;
            price = cartFilterEstimateShippingResponseModel.shippingOptions[0].price;
          }

          preEstimateShipping = new ProductEstimateShippingChangeRequestModel(productId: 0, zipPostalCode: estimateShipping.zipPostalCode == null?
          "" : estimateShipping.zipPostalCode, city: estimateShipping.city == null ?
          "" : estimateShipping.city, countryId: preEstimateShipping.countryId, stateId: preEstimateShipping.stateId, name: name, date: date, price: price, stateName: "",countryName: "");
          notifyListeners();
        }
      }
      isCartLoader = false;
      networkCartLoader = false;
      notifyListeners();

    }else{
      isCartLoader = false;
      networkCartLoader = false;
      notifyListeners();
    }

  }

  getTaxData({required BuildContext context})async{
    Response response = await CommonService().getTaxType(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_TAX_TYPE, response.body);
      });
      taxTypeModel = taxTypeModelFromJson(response.body);
      notifyListeners();
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_TAX_TYPE, null);
      });
    }

    categoryLoader = false;
    notifyListeners();

    getNavigationData(context: context);
  }

  getNavigationData({required BuildContext context})async
  {
    if(!isHeaderLoader)
    {
      if(headerModel.isAuthenticated)
      {
        Response response = await CommonService().getCustomerNavigation(context: context);
        if(response.statusCode == 200)
        {
          await storage.ready.then((_){
            storage.setItem(StringConstants.CACHE_NAVIGATOR, response.body);
          });
          getCustomerNavigationModel = getCustomerNavigationModelFromJson(response.body);
          customerNavigationItems = getCustomerNavigationModel.customerNavigationItems;
          isProfileLoad = false;
          profileLoader = false;
          networkProfileLoader = false;
          notifyListeners();
        }else{
          await storage.ready.then((_){
            storage.setItem(StringConstants.CACHE_NAVIGATOR, null);
          });
        }

      }else {
        isProfileLoad =false;
        profileLoader =false;
        networkProfileLoader =false;
        notifyListeners();
      }
    }
  }

  getLanguage({required BuildContext context})async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    Response response = await CommonService().getLanguages(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_LANGUAGE, response.body);
      });
      getLanguagesModel = getLanguagesModelFromJson(response.body);
      preferences.setInt(SharedPreferencesValues.SHARED_PREFERENCE_LANGUAGE_ID, getLanguagesModel.currentLanguageId);
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_LANGUAGE, null);
      });
    }

    getCurrencyData(context: context);
  }

  getCurrencyData({required BuildContext context})async{
    Response response = await CommonService().getCurrency(context: context);
    if(response.statusCode == 200)
    {
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CURRENCY, response.body);
      });
      currencyResponseModel = currencyResponseModelFromJson(response.body);
    }else{
      await storage.ready.then((_){
        storage.setItem(StringConstants.CACHE_CURRENCY, null);
      });
    }
    getTaxData(context: context);
  }

  updateLanguage({required BuildContext context, required String selectedValue}) async
  {
    if(await CheckConnectivity().checkInternet(context))
    {
      isProfileLoad = true;
      getLanguagesModel.currentLanguageId = int.parse(selectedValue);
      notifyListeners();

      Response response = await CommonService().postLanguages(context: context,params: "/$selectedValue");

      if(response.statusCode == 200)
      {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setInt(SharedPreferencesValues.SHARED_PREFERENCE_LANGUAGE_ID, int.parse(selectedValue));

        await LocalResourceProvider().loadLocalResources();

        await getNavigationData(context: context);
      }
      isProfileLoad = false;
      notifyListeners();

    }
  }

  updateCurrency({required BuildContext context, required String selectedValue}) async
  {
    if(await CheckConnectivity().checkInternet(context))
    {
      isProfileLoad = true;
      currencyResponseModel.currentCurrencyId = int.parse(selectedValue);
      notifyListeners();

      await CommonService().postCurrency(context: context,params: "/$selectedValue");

      isProfileLoad = false;
      notifyListeners();
    }
  }
  updateTax({required BuildContext context, required String taxType}) async{

    if(await CheckConnectivity().checkInternet(context)) {
      isProfileLoad = true;
      taxTypeModel.currentTaxType = taxType;
      notifyListeners();

      Response response = await CommonService().postTaxType(context: context, params: "/$taxType");
      if (response.statusCode == 200) {
        Response response1 = await CommonService().getTaxType(context: context);
        if (response1.statusCode == 200) {
          taxTypeModel = taxTypeModelFromJson(response1.body);
          notifyListeners();
        }
      }
      isProfileLoad = false;
      notifyListeners();
    }
  }

  changeTabIndex({required newIndex})
  {
    currentTabIndex = newIndex;
    notifyListeners();
  }

  onTapHandler({required BuildContext context,required int index}) {

    updateHeaderData(context: context);
    updateCartData(context: context);

    if(index == 0 && currentTabIndex == 0)
    {
      if(homeScrollController.position.minScrollExtent != 0)
      {
        homeScrollController.animateTo(
            homeScrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
        notifyListeners();
      }

    }else if(index == 1 && currentTabIndex == 1)
    {
      if(categoryScrollController.position.minScrollExtent != 0)
      {
        categoryScrollController.animateTo(
            categoryScrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
        notifyListeners();
      }
    }else if(index == 2 && currentTabIndex == 2)
    {
      discountCouponMsg="";
      giftCardCouponMsg="";
      isDiscountApplied=false;
      isGiftCardApplied=false;

      if(cartScrollController.position.minScrollExtent != 0)
      {
        cartScrollController.animateTo(
            cartScrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
        notifyListeners();
      }

    }else if(index == 3 && currentTabIndex == 3)
    {
      if(profileScrollController.position.minScrollExtent != 0)
      {
        profileScrollController.animateTo(
            profileScrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
        notifyListeners();
      }

    }else{
      if(index == 1)
      {
        categoryExpandList = {};
      }
      discountCouponMsg="";
      giftCardCouponMsg="";
      this.currentTabIndex = index;
      notifyListeners();
    }
  }

  changeCategoryStatus()
  {
    isExpandCategory = !isExpandCategory;
    notifyListeners();
  }

  initialExpandListStatus({required int listId, required status})
  {
    categoryExpandList[listId]=status;
  }

  changeExpandListStatus({required int listId, required bool status})
  {
    categoryExpandList[listId]=status;
    notifyListeners();
  }

  removeCartItemClickEvent({required BuildContext context,required int id}) async {

    if(await CheckConnectivity().checkInternet(context))
    {
      List<int> ids=[];
      ids.add(id);

      final body='{ '
          '"cartItemIds": $ids,'
          '"prepareCart": true'
          '}';

      Response response = await ShoppingCartService().deleteCartData(context: context,body: body);
      if(response.statusCode == 200)
      {
        isCartItemDeleteMap[id] = true;
        getCartData(context: context);
        getHeaderData(context: context);
        notifyListeners();
      }
    }

  }

  updateCartClickEvent({required BuildContext context}) async {
    isCartDataRefresh = true;
    notifyListeners();

    List<Map<String,int>> updateCartMap=[];
    for(var item in getCartModel.items)
    {
      updateCartMap.add(
          {
            '"cartItemId"':item.id,
            '"quantity"':item.quantity
          });
    }
    var body = '$updateCartMap';

    Response response = await ShoppingCartService().updateCartQuantity(context: context,body: body);

    if(response.statusCode == 200)
    {
      getCartModel = getCartModelFromJson(response.body);
      updateTotalOrderData(context: context);
    }
  }

  openFileExplorer({required BuildContext context,required int attributeID}) async {

    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isCartDataRefresh = true;
      notifyListeners();

      try {
        _paths = (await FilePicker.platform.pickFiles(onFileLoading: (FilePickerStatus status) => print('f$status'),allowedExtensions: (_extension?.isNotEmpty ?? false)? _extension?.replaceAll(' ', '').split(','): null,))?.files;
      } on PlatformException catch (e) {
        print("ERROR: $e");
      } catch (ex) {

      }

      _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _filePath = _paths != null ? _paths!.map((e) => e.path).toString() : '...';

      _filePath=_filePath.substring(1,_filePath.length-1);
      _fileName=_fileName.substring(1,_fileName.length-1);

      if(_paths != null && _paths != "")
      {
        List<int> bytes = File(_filePath).readAsBytesSync();
        String base64File = base64Encode(bytes);
        base64=base64File;
        await attributeUploadFile(context: context,attributeID: attributeID);
      }else{
        isCartDataRefresh = false;
      }
      notifyListeners();
    }

  }

  attributeUploadFile({required BuildContext context,required int attributeID}) async
  {

    final body='{ '
        '"fileBase64String": "$base64",'
        '"fileName": "$_fileName"'
        '}';
    Response response = await ShoppingCartService().postCartUploadFileAttributeChange(context: context, body: body, params: "/$attributeID");
    if(response.statusCode == 200)
    {
      uploadFileModel=uploadFileModelFromJson(response.body);
      if(uploadFileModel.success)
      {
        fileUploadMap[attributeID] = _fileName;
        fileGuid=uploadFileModel.uploadedFileGuid;
        FlushBarMessage().successMessage(context: context, title: uploadFileModel.message);
      }else{
        FlushBarMessage().failedMessage(context: context,title: uploadFileModel.message);
      }
    }
    removeShow=true;
    isCartDataRefresh = false;
    notifyListeners();
  }

  attributeOnChanged({required BuildContext context}) async
  {
    isCartDataRefresh=true;
    notifyListeners();

    String prefixString = "checkout_attribute_";
    for(var i in getCartModel.checkoutAttributes) {
      List<String> idList = [];
      if (i.attributeControlType == AttributeControlType.Checkboxes || i.attributeControlType == AttributeControlType.ReadonlyCheckboxes) {
        idList.clear();

        for(var j in i.values) {
          if(j.isPreSelected) {
            idList.add('${j.id}');
          }
        }

        String atr='"${idList.join(",")}"';
        cartChangedAttributes['"$prefixString${i.id}"'] = atr;
      } else {
        if (i.defaultValue != null) {

          idList.add('"${i.defaultValue}"');
          cartChangedAttributes['"$prefixString${i.id}"']  = '"${i.defaultValue}"';
        } else {
          cartChangedAttributes['"$prefixString${i.id}"']  = "''";
        }
      }
    }


    Response response = await ShoppingCartService().postCartAttributeChange(context: context, body: '$cartChangedAttributes');
    print("Att change ${response.statusCode}");
    if(response.statusCode == 200)
    {
      orderTotalResponseModel = cartAttributeChangeResponseModelFromJson(response.body).orderTotals;
      print("orderTotalResponseModel ${orderTotalResponseModel.orderTotal}");

      getTotalOrderData(context: context);
      isCartDataRefresh=false;
      notifyListeners();
    }
  }

  getStateDataByCountryId({required BuildContext context,required int countryId,required EstimateShippingResponseModel estimateShippingResponseModel})async
  {

    stateModelList.clear();
    Response response = await CommonService().getStateData(context: context,countryId: countryId);
    if(response.statusCode == 200)
    {
      stateModelList = getStatesModelFromJson(response.body);
      filterStateList.clear();
      for(var item in stateModelList)
      {
        filterStateList.add(new DropDownModel(text: item.name, value: item.name));
      }

      selectedState = stateModelList[0].id;
    }
  }

  prepareCartContentData()
  {
    if (estimateShippingResponseModel != null) {
      estimateShippingModel = estimateShippingResponseModel;
      for (var item in estimateShippingModel.availableCountries) {
        availableCountryList.add(new DropDownModel(text: item.text, value: item.text));
      }

      for (var item in estimateShippingModel.availableStates) {
        availableStateList.add(new DropDownModel(text: item.text, value: item.text));
      }
    }
    availableCountryList.clear();
    availableStateList.clear();
  }

  discountCouponClickEvent({required BuildContext context})
  async {
    isDiscountApplied = false;
    discountCouponMsg = "";
    notifyListeners();

    if(discountCodeController.text.toString().isNotEmpty)
    {
      isCartDataRefresh = true;
      FocusScope.of(context).requestFocus(new FocusNode());
      notifyListeners();

      Response response = await ShoppingCartService().postDiscountCoupon(context: context,params: '/${discountCodeController.text.toString()}?prepareOrderTotals=true');
      if(response.statusCode == 200)
      {
        DiscountCouponResponseModel discountModel = discountCouponResponseModelFromJson(response.body);

        orderTotalResponseModel = discountModel.orderTotals;
        isDiscountApplied = discountModel.discountBox.isApplied;
        if(discountModel.discountBox.isApplied)
        {
          getDiscountCartData(context: context, discountModel: discountModel);

        }else{
          discountCouponMsg = discountModel.discountBox.messages.join(",");
          discountCodeController.text="";
          isCartDataRefresh = false;
          notifyListeners();
        }

        getTotalOrderData(context: context);
        notifyListeners();
      }else{

        discountCodeController.text="";
        isCartDataRefresh = false;
      }

    }else{
      isCartDataRefresh = false;
      discountCouponMsg = LocalResourceProvider().getResourseByKey("shoppingCart.discountCouponCode.empty");
      notifyListeners();
    }
  }

  getDiscountCartData({required BuildContext context,required DiscountCouponResponseModel discountModel}) async
  {
    Response response = await ShoppingCartService().getCartData(context: context);
    if(response.statusCode == 200)
    {
      getCartModel.discountBox = getCartModelFromJson(response.body).discountBox;

      discountCouponMsg = discountModel.discountBox.messages.join(",");
      discountCodeController.text="";
      isCartDataRefresh = false;
      notifyListeners();
    }
  }

  removeDiscountCouponClickEvent({required BuildContext context, required AppliedDiscountsWithCode appliedDiscountsWithCode})
  async {
    isDiscountApplied = false;
    discountCouponMsg = "";
    isCartDataRefresh = true;
    FocusScope.of(context).requestFocus(new FocusNode());
    notifyListeners();

    Response response = await ShoppingCartService().removeDiscountCoupon(context: context,params: "/${appliedDiscountsWithCode.id.toString()}?prepareOrderTotals=true");
    if(response.statusCode == 200)
    {
      orderTotalResponseModel = orderTotalResponseModelFromJson(response.body);
      getCartModel.discountBox.appliedDiscountsWithCodes.removeWhere((element) => element.id == appliedDiscountsWithCode.id);

      getTotalOrderData(context: context);
      notifyListeners();
    }

    isCartDataRefresh = false;
    notifyListeners();
  }

  giftCardCouponCodeClickEvent({required BuildContext context})async
  {
    giftCardCouponMsg="";
    isGiftCardApplied=false;
    isCartDataRefresh = true;
    FocusScope.of(context).requestFocus(new FocusNode());
    notifyListeners();

    if(giftCardController.text.trim().toString().isNotEmpty)
    {
      Response response = await ShoppingCartService().postGiftCardCoupon(context: context,params: '/${giftCardController.text.trim().toString()}?prepareOrderTotals=true');
      if(response.statusCode == 200)
      {
        giftCardModel = giftCardResponseModelFromJson(response.body);
        orderTotalResponseModel = giftCardModel.orderTotals;

        isGiftCardApplied = giftCardModel.giftCardBox.isApplied;
        giftCardCouponMsg = giftCardModel.giftCardBox.message;
        getTotalOrderData(context: context);
        notifyListeners();

      }
    }else{
      isGiftCardApplied = false;
      giftCardCouponMsg = LocalResourceProvider().getResourseByKey("shoppingCart.discountCouponCode.empty");
      notifyListeners();
    }

    giftCardController.text="";
    isCartDataRefresh = false;
    notifyListeners();
  }

  removeGiftCardClickEvent({required BuildContext context, required GiftCardData giftCardData})async
  {
    giftCardCouponMsg="";
    isGiftCardApplied=false;
    isCartDataRefresh=true;
    notifyListeners();

    Response response = await ShoppingCartService().removeGiftCardCoupon(context: context,params: "/${giftCardData.id.toString()}?prepareOrderTotals=true");
    if(response.statusCode == 200)
    {
      getTotalOrderData(context: context);
      notifyListeners();
    }
    isCartDataRefresh=false;
    notifyListeners();
  }

  downloadPDF({required BuildContext context}) async
  {
    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isCartDataRefresh = true;
      notifyListeners();

      Response response = await ShoppingCartService().getPdfDownload(context: context,params: "/$fileGuid");
      if(response.statusCode == 200)
      {
        String base64 = base64Encode(response.bodyBytes);
        var fileType =response.headers["content-disposition"].toString().split(";");
        var separateName = fileType[1].split("=");
        var fileName = separateName[1].split(".");

        FileConfig().saveFile(context: context, base64: base64, fileName: fileName[0], fileType: fileName[1]);
      }
    }
    isCartDataRefresh = false;
    notifyListeners();

  }

  startCheckout({required BuildContext context})async {
    KeyboardUtil.hideKeyboard(context);
    int productsWarnings = 0;

    for(var product in getCartModel.items)
    {
      productsWarnings = productsWarnings + product.warnings.length;
    }

    if(productsWarnings == 0)
    {
      String uploadedFileGuid = "";
      if (uploadFileModel != null) {
        uploadedFileGuid = uploadFileModel.uploadedFileGuid;
      }
      isCartDataRefresh = true;
      notifyListeners();

      String prefixString = "checkout_attribute_";

      for(var i in getCartModel.checkoutAttributes) {
        List<String> idList = [];

        if (i.attributeControlType == AttributeControlType.Checkboxes || i.attributeControlType == AttributeControlType.ReadonlyCheckboxes) {

          for(var j in i.values) {
            if(j.isPreSelected) {
              idList.add('${j.id}');
            }
          }

          String atr='"${idList.join(",")}"';
          startCheckoutMap['"$prefixString${i.id}"'] = atr;
        }else if(i.attributeControlType == AttributeControlType.FileUpload){
          startCheckoutMap['"$prefixString${i.id}"'] = '"$uploadedFileGuid"';

        }else if(i.attributeControlType == AttributeControlType.Datepicker){

          startCheckoutMap['"$prefixString${i.id}_day"'] = '"${i.selectedDay}"';
          startCheckoutMap['"$prefixString${i.id}_month"'] = '"${i.selectedMonth}"';
          startCheckoutMap['"$prefixString${i.id}_year"'] = '"${i.selectedYear}"';

        }else {
          if (i.defaultValue != null) {

            idList.add('"${i.defaultValue}"');
            startCheckoutMap['"$prefixString${i.id}"']  = '"${i.defaultValue}"';
          } else {
            startCheckoutMap['"$prefixString${i.id}"']  = '""';
          }
        }
      }
      Response response = await ShoppingCartService().startCheckout(context: context, body: '$startCheckoutMap');
      if(response.statusCode == 200)
      {
        if(headerModel.isAuthenticated)
        {
          LocalResourceProvider().getSettingByName("orderSettings.onePageCheckoutEnabled")=='False'?
          Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckout())).then((value)
          {
            getCartData(context: context);
            getHeaderData(context: context);
          }) :
          Navigator.push(context, PageTransition(type: selectedTransition, child: OnePageCheckout())).then((value)
          {
            getCartData(context: context);
            getHeaderData(context: context);
          });
        }else{
          isCartDataRefresh=false;
          notifyListeners();
          Navigator.push(context, PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Checkout))).then((value)
          {
            pageLoadData(context: context);
          });
        }
        isCartDataRefresh=false;
        notifyListeners();
      }else{
        isCartDataRefresh=false;
        notifyListeners();
      }


      isStartCheckoutCheckbox = false;
      notifyListeners();
    }else{
      cartScrollController.animateTo(
          cartScrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      notifyListeners();
    }
  }

  removeFileAttribute({required BuildContext context, required int attributeId})
  {
    removeShow=false;
    fileUploadMap[attributeId]='';
    notifyListeners();
  }

  logoutUser({required BuildContext context}) async
  {
    isProfileLoad = true;
    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    LocalStorage storage = new LocalStorage(StringConstants.CACHE_DATABASE_NAME);

    Response response = await CustomerService().logoutUser(context: context);
    print("Logout ${response.statusCode}");
    if(response.statusCode == 200){
      preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN, false);
      preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN, false);
      await storage.ready.then((_)async{
        await storage.clear();
      });
      storage.setItem(StringConstants.CACHE_TOP_MENU,null);
      storage.setItem(StringConstants.CACHE_NIVO_SLIDER,null);
      storage.setItem(StringConstants.CACHE_HOME_CATEGORY,null);
      storage.setItem(StringConstants.CACHE_HOME_PRODUCTS,null);
      storage.setItem(StringConstants.CACHE_HOME_BESTSELLER,null);
      storage.setItem(StringConstants.CACHE_CART_DATA,null);
      storage.setItem(StringConstants.CACHE_CART_CROSS_SELL,null);
      storage.setItem(StringConstants.CACHE_CART_ORDER_TOTAL,null);
      storage.setItem(StringConstants.CACHE_CART_ESTIMATE_SHIPPING,null);
      storage.setItem(StringConstants.CACHE_TAX_TYPE,null);
      storage.setItem(StringConstants.CACHE_LANGUAGE,null);
      storage.setItem(StringConstants.CACHE_CURRENCY,null);
      storage.setItem(StringConstants.CACHE_NAVIGATOR,null);
      storage.setItem(StringConstants.CACHE_HEADER,null);
      storage.setItem(StringConstants.CACHE_WISHLIST,null);
      storage.setItem(StringConstants.CACHE_USERINFO,null);
      storage.setItem(StringConstants.CACHE_ADDRESS_LIST,null);
      storage.setItem(StringConstants.CACHE_ORDER_LIST,null);
      storage.setItem(StringConstants.CACHE_DOWNLOAD_PRODUCTS_LIST,null);
      storage.setItem(StringConstants.CACHE_BACK_IN_STOCK,null);
      storage.setItem(StringConstants.CACHE_REWARD_POINT,null);
      storage.setItem(StringConstants.CACHE_AVATAR,null);
      storage.setItem(StringConstants.CACHE_PRODUCT_REVIEW,null);
      storage.setItem(StringConstants.CACHE_PRODUCTS_BY_CATEGORY,null);
      storage.setItem(StringConstants.CACHE_POPULAR_TAGS,null);
      storage.setItem(StringConstants.CACHE_CATALOG_ROOT,null);
      storage.setItem(StringConstants.CACHE_MANUFACTURERS,null);
      storage.setItem(StringConstants.CACHE_PRODUCT_DETAILS,null);
      storage.setItem(StringConstants.CACHE_RELATED_PRODUCTS,null);
      storage.setItem(StringConstants.CACHE_PRODUCT_DETAILS_REVIEW,null);
      storage.setItem(StringConstants.CACHE_PRODUCT_ALSO_PURCHASE,null);
      storage.setItem(StringConstants.CACHE_PRODUCT_BY_MANUFACTURER,null);
      storage.setItem(StringConstants.CACHE_CART_TOPIC_BLOCK,null);
      storage.setItem(StringConstants.CACHE_CONTACTUS_TOPIC_BLOCK,null);
      storage.setItem(StringConstants.CACHE_NEWS_LIST,null);
      storage.setItem(StringConstants.CACHE_NEWS_DETAILS,null);
      storage.setItem(StringConstants.CACHE_NEW_PRODUCTS,null);
      storage.setItem(StringConstants.CACHE_CONTACTUS,null);
      storage.dispose();
      isProfileLoad = false;
      notifyListeners();
      Navigator.pushReplacement(context,PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Login)));
    }else{
      preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN, false);
      preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN, false);
      await storage.ready.then((_)async{
        await storage.clear();
      });
      storage.deleteItem(StringConstants.CACHE_TOP_MENU);
      storage.deleteItem(StringConstants.CACHE_NIVO_SLIDER);
      storage.deleteItem(StringConstants.CACHE_HOME_CATEGORY);
      storage.deleteItem(StringConstants.CACHE_HOME_PRODUCTS);
      storage.deleteItem(StringConstants.CACHE_HOME_BESTSELLER);
      storage.deleteItem(StringConstants.CACHE_CART_DATA);
      storage.deleteItem(StringConstants.CACHE_CART_CROSS_SELL);
      storage.deleteItem(StringConstants.CACHE_CART_ORDER_TOTAL);
      storage.deleteItem(StringConstants.CACHE_CART_ESTIMATE_SHIPPING);
      storage.deleteItem(StringConstants.CACHE_TAX_TYPE);
      storage.deleteItem(StringConstants.CACHE_LANGUAGE);
      storage.deleteItem(StringConstants.CACHE_CURRENCY);
      storage.deleteItem(StringConstants.CACHE_NAVIGATOR);
      storage.deleteItem(StringConstants.CACHE_HEADER);
      storage.deleteItem(StringConstants.CACHE_WISHLIST);
      storage.deleteItem(StringConstants.CACHE_USERINFO);
      storage.deleteItem(StringConstants.CACHE_ADDRESS_LIST);
      storage.deleteItem(StringConstants.CACHE_ORDER_LIST);
      storage.deleteItem(StringConstants.CACHE_DOWNLOAD_PRODUCTS_LIST);
      storage.deleteItem(StringConstants.CACHE_BACK_IN_STOCK);
      storage.deleteItem(StringConstants.CACHE_REWARD_POINT);
      storage.deleteItem(StringConstants.CACHE_AVATAR);
      storage.deleteItem(StringConstants.CACHE_PRODUCT_REVIEW);
      storage.deleteItem(StringConstants.CACHE_PRODUCTS_BY_CATEGORY);
      storage.deleteItem(StringConstants.CACHE_POPULAR_TAGS);
      storage.deleteItem(StringConstants.CACHE_CATALOG_ROOT);
      storage.deleteItem(StringConstants.CACHE_MANUFACTURERS);
      storage.deleteItem(StringConstants.CACHE_PRODUCT_DETAILS);
      storage.deleteItem(StringConstants.CACHE_RELATED_PRODUCTS);
      storage.deleteItem(StringConstants.CACHE_PRODUCT_DETAILS_REVIEW);
      storage.deleteItem(StringConstants.CACHE_PRODUCT_ALSO_PURCHASE);
      storage.deleteItem(StringConstants.CACHE_PRODUCT_BY_MANUFACTURER);
      storage.deleteItem(StringConstants.CACHE_CART_TOPIC_BLOCK);
      storage.deleteItem(StringConstants.CACHE_CONTACTUS_TOPIC_BLOCK);
      storage.deleteItem(StringConstants.CACHE_NEWS_LIST);
      storage.deleteItem(StringConstants.CACHE_NEWS_DETAILS);
      storage.deleteItem(StringConstants.CACHE_NEW_PRODUCTS);
      storage.deleteItem(StringConstants.CACHE_CONTACTUS);
      isProfileLoad = false;
      notifyListeners();
      Navigator.pushReplacement(context,PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Login)));
    }
  }

  getCacheNivoSlider() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_NIVO_SLIDER);
      if(res != null)
      {
        nivoSliderModel = getNivoSliderModelFromJson(res);
        return nivoSliderModel;
      }else{
        return null;
      }
    });
  }

  getCacheHomeCategory() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_HOME_CATEGORY);
      if(res != null)
      {
        getHomepageCategoriesModel = getHomepageCategoriesModelFromJson(res);
        isHomePageCategoryLoader = false;
        notifyListeners();
        return getHomepageCategoriesModel;
      }else{
        return null;
      }
    });
  }

  getCacheCategoryList() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_TOP_MENU);
      if(res != null)
      {
        getTopMenuModel = getTopMenuModelFromJson(res);
        isTopMenuLoader = false;
        notifyListeners();
        return getTopMenuModel;
      }else{
        return null;
      }
    });
  }

  getCacheHomeProducts() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_HOME_PRODUCTS);
      if(res != null)
      {
        getHomepageProductsModel = commonProductResponseModelFromJson(res);
        isHomePageProductsLoader = false;
        notifyListeners();
        return getHomepageProductsModel;
      }else{
        return null;
      }
    });
  }

  getCacheHomeBestSeller() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_HOME_BESTSELLER);

      if(res != null)
      {
        getHomepageBestSellerModel = commonProductResponseModelFromJson(res);
        isHomePageBestSellerLoader = false;
        notifyListeners();
        return getHomepageBestSellerModel;
      }else{
        getHomepageBestSellerModel.clear();
        return null;
      }
    });

  }

  getCacheCartData() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_CART_DATA);
      if(res != null)
      {
        getCartModel = getCartModelFromJson(res);
        return getCartModel;
      }else{
        return null;
      }
    });
  }

  getCacheCartCrossSell() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_CART_CROSS_SELL);
      if(res != null)
      {
        crossSellProduct = commonProductResponseModelFromJson(res);
        return crossSellProduct;
      }else{
        return null;
      }
    });
  }

  getCacheCartOrderTotal() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_CART_ORDER_TOTAL);
      if(res != null)
      {
        orderTotalResponseModel = orderTotalResponseModelFromJson(res);
        return orderTotalResponseModel;
      }else{
        return null;
      }
    });

  }

  getCacheCartEstimateShipping() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_CART_ESTIMATE_SHIPPING);
      if(res != null)
      {
        estimateShippingResponseModel = estimateShippingResponseModelFromJson(res);
        return estimateShippingResponseModel;
      }else{
        return null;
      }
    });

  }

  getCacheTaxType() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_TAX_TYPE);
      if(res != null)
      {
        taxTypeModel = taxTypeModelFromJson(res);
        return taxTypeModel;
      }else{
        return null;
      }
    });
  }

  getCacheLanguage() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_LANGUAGE);
      if(res != null)
      {
        getLanguagesModel = getLanguagesModelFromJson(res);
        return getLanguagesModel;
      }else{
        return null;
      }
    });
  }

  getCacheCurrency() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_CURRENCY);
      if(res != null)
      {
        currencyResponseModel = currencyResponseModelFromJson(res);
        return currencyResponseModel;
      }else{
        return null;
      }
    });
  }

  getCacheNavigator() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_NAVIGATOR);
      if(res != null)
      {
        getCustomerNavigationModel = getCustomerNavigationModelFromJson(res);
        customerNavigationItems = getCustomerNavigationModel.customerNavigationItems;
        return getCustomerNavigationModel;
      }else{
        return null;
      }
    });
  }

  getCacheHeader() async {
    await storage.ready.then((_)
    {
      String res = storage.getItem(StringConstants.CACHE_HEADER);
      if(res != null)
      {
        headerModel = headerInfoResponseModelFromJson(res);
        isHeaderLoader = false;
        notifyListeners();
        return headerModel;
      }else{
        return null;
      }
    });
  }


  updateEstimateData({required BuildContext context,required ProductEstimateShippingChangeRequestModel requestModel})
  {
    estimateShippingModel.countryId = requestModel.countryId;
    estimateShippingModel.zipPostalCode=requestModel.zipPostalCode;
    estimateShippingModel.city=requestModel.city;
    estimateShippingModel.stateProvinceId=requestModel.stateId;
    preEstimateShipping = ProductEstimateShippingChangeRequestModel(productId: 0, zipPostalCode: requestModel.zipPostalCode, city: requestModel.city, countryId: requestModel.countryId, stateId: requestModel.stateId, name: requestModel.name, date: requestModel.date, price: requestModel.price, stateName: requestModel.stateName,countryName: requestModel.countryName);
    notifyListeners();
    selectShippingOption(context: context, shippingOption: requestModel);
  }

  selectShippingOption({required BuildContext context, required ProductEstimateShippingChangeRequestModel shippingOption})async
  {
    isCartDataRefresh = true;
    notifyListeners();
    final body='{ '
        '"ZipPostalCode": "${shippingOption.zipPostalCode == null || shippingOption.zipPostalCode == "" ? shippingOption.city : shippingOption.zipPostalCode}",'
        '"CountryId": "${shippingOption.countryId}",'
        '"StateProvinceId": "${shippingOption.stateId}",'
        '"PrepareOrderTotals": true'
        '}';
    Response response = await ShoppingCartService().postSelectShippingOption(context: context,params: "/${shippingOption.name}",body: body);
    if(response.statusCode == 200)
    {
      orderTotalResponseModel = orderTotalResponseModelFromJson(response.body);
    }
    isCartDataRefresh = false;
    notifyListeners();
  }
}