/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/AddAddressRequestModel.dart';
import 'package:nopcommerce/Models/AddressAttributesValuesModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/GetTopicBlockModel.dart';
import 'package:nopcommerce/Models/OrderTotals.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutPaypalView/CheckoutPaypalView.dart';
import 'package:nopcommerce/Screens/Checkout/Models/GetPaymentInfoNetBankingModel.dart';
import 'package:nopcommerce/Screens/Checkout/Models/GetPaymentMethodsModel450.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutCompleteOrder.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutConfirmOrder.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutPaymentInfo.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutPaymentMethod.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetails.dart';
import 'package:nopcommerce/Screens/Customer/OrderConfirmPage/OrderConfirmPage.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Screens/Home/Models/ShoppingCartModel/OrderTotalResponseModel.dart';
import 'package:nopcommerce/Services/CheckoutService.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Enum/VersionType.dart';
import '../../Utils/SharedPreferences.dart';
import 'Models/ConfirmOrderModel.dart';
import 'Models/GetCustomerAddressesModel.dart';
import 'Models/GetOrderCompletedResponseModel.dart';
import 'Models/GetOrderSummaryModel.dart';
import 'Models/GetPaymentInfoModel.dart';
import 'Models/GetPaymentMethodsModel.dart';
import 'Models/GetPickupPointsModel.dart';
import 'Models/GetShippingMethodsModel.dart';
import 'Models/ManualPaymentModel.dart';
import 'Models/PaypalStandardModel.dart';
import 'Models/PurchaseOrderModel.dart';
import 'Models/ValidatePaymentInfoResponseModel.dart';
import 'MultiPageCheckout/MultiPageCheckoutShippingAddress.dart';
import 'MultiPageCheckout/MultiPageCheckoutShippingMethod.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class CheckoutProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  late GetCustomerAddressesModel getBillingAddressesModel;
  late GetCustomerAddressesModel getShippingAddressesModel;
  List<DropDownModel> billingAddressDropdownList = [];
  List<DropDownModel> shippingAddressDropdownList = [];
  List<DropDownModel> billingStateDropdownList = [];
  List<DropDownModel> shippingStateDropdownList = [];

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

  bool isBillingAddressTabCompleted = false;
  bool isShippingAddressTabCompleted = false;
  bool isShippingMethodTabCompleted = false;
  bool isPaymentMethodTabCompleted = false;
  bool isConfirmOrderTabCompleted = false;
  bool isPaymentInformationMethodTabCompleted =false;
  bool isBillingAddress = true;
  bool isShippingAddress = false;
  bool isShippingMethod = false;
  bool isPaymentMethod = false;
  bool isConfirmOrder = false;
  bool isOnlyRewardPoints=false;
  bool isPaymentInformationMethod =false;
  bool isPaymentWorking=false;
  bool isPaymentMethodAndPaymentInfo=false;
  bool shipToSameAddressEnable=true;

  bool isShippableProduct = false;
  bool isOrderSummeryLoad = false;
  bool isBillingAddressLoad = false;
  bool isShippingAddressLoad = false;
  bool isPickupPointsLoad = false;
  bool isShippingMethodsLoad = false;
  bool isPaymentMethodsLoad = false;
  bool isPaymentInfoLoad = false;
  bool isConfirmOrderLoad = false;

  bool isPickupPointEnable = false;
  //bool isShippingMethodsEnable = false;
  bool isShippingDataLoad = false;

  bool isTermsOfServiceCheck = false;
  bool isRewardPointEnable = false;

  String selectedBillingAddress = "";
  String selectedShippingAddress = "";
  String selectedPickupPoints = "";
  String selectedPaymentMethod = "";
  String selectedShippingMethodName = "";

  late GetShippingMethodsModel getShippingMethodsModel;
  late GetPickupPointsModel getPickupPointsModel;
  // late GetPaymentMethodsModel getPaymentMethodsModel;
  late GetPaymentMethods paymentMethodsModel450;
  late GetPaymentInfoModel getPaymentInfoModel;
  late ManualPaymentModel manualPaymentModel;
  late GetPaymentInfoNetBankingModel getPaymentInfoNetBankingModel;
  late PaypalStandardModel paypalStandardModel;
  late PurchaseOrderModel purchaseOrderModel;
  late ValidatePaymentInfoResponseModel validatePaymentInfo;
  late GetOrderSummaryModel getOrderSummaryModel;
  late OrderTotals orderTotalResponseModel;
  late ConfirmOrderModel confirmOrderModel;
  late GetTopicBlockModel getTopicBlockModel;

  String billingAddressTabIndex='1';
  String shippingAddressTabIndex='2';
  String shippingMethodTabIndex='3';
  String paymentMethodTabIndex='4';
  String paymentInformationTabIndex='5';
  String confirmOrderTabIndex='6';

  TextEditingController firstNameBillingController = new TextEditingController();
  TextEditingController lastNameBillingController = new TextEditingController();
  TextEditingController emailBillingController = new TextEditingController();
  TextEditingController companyNameBillingController = new TextEditingController();
  TextEditingController cityBillingController = new TextEditingController();
  TextEditingController countyBillingController = new TextEditingController();
  TextEditingController address1BillingController = new TextEditingController();
  TextEditingController address2BillingController = new TextEditingController();
  TextEditingController zipCodeBillingController = new TextEditingController();
  TextEditingController phoneNumberBillingController = new TextEditingController();
  TextEditingController faxNumberBillingController = new TextEditingController();
  TextEditingController firstNameShippingController = new TextEditingController();
  TextEditingController lastNameShippingController = new TextEditingController();
  TextEditingController emailShippingController = new TextEditingController();
  TextEditingController companyNameShippingController = new TextEditingController();
  TextEditingController cityShippingController = new TextEditingController();
  TextEditingController countyShippingController = new TextEditingController();
  TextEditingController address1ShippingController = new TextEditingController();
  TextEditingController address2ShippingController = new TextEditingController();
  TextEditingController zipCodeShippingController = new TextEditingController();
  TextEditingController phoneNumberShippingController = new TextEditingController();
  TextEditingController faxNumberShippingController = new TextEditingController();

  pageLoadData({required BuildContext context}) async
  {
    isPageLoader = true;
    isAPILoader = false;
    billingAddressDropdownList = [];
    shippingAddressDropdownList = [];
    billingStateDropdownList = [];
    shippingStateDropdownList = [];
    isBillingAddressTabCompleted = false;
    isShippingAddressTabCompleted = false;
    isShippingMethodTabCompleted = false;
    isPaymentMethodTabCompleted = false;
    isConfirmOrderTabCompleted = false;
    isPaymentInformationMethodTabCompleted =false;
    isBillingAddress = true;
    isShippingAddress = false;
    isShippingMethod = false;
    isPaymentMethod = false;
    isConfirmOrder = false;
    isOnlyRewardPoints=false;
    isPaymentInformationMethod =false;
    isPaymentWorking=false;
    isPaymentMethodAndPaymentInfo=false;
    shipToSameAddressEnable=true;
    isPickupPointEnable = false;
    isShippableProduct = false;
    isTermsOfServiceCheck = false;
    isShippingDataLoad = false;
    isRewardPointEnable = false;
    isOrderSummeryLoad = false;
    selectedBillingAddress = "";
    selectedShippingAddress = "";
    selectedPickupPoints = "";
    selectedPaymentMethod = "";
    selectedShippingMethodName = "";

    isShippableProduct = false;
    isOrderSummeryLoad = false;
    isBillingAddressLoad = false;
    isShippingAddressLoad = false;
    isPickupPointsLoad = false;
    isShippingMethodsLoad = false;
    isPaymentMethodsLoad = false;
    isPaymentInfoLoad = false;
    isConfirmOrderLoad = false;

    firstNameBillingController.clear();
    lastNameBillingController.clear();
    emailBillingController.clear();
    companyNameBillingController.clear();
    cityBillingController.clear();
    countyBillingController.clear();
    address1BillingController.clear();
    address2BillingController.clear();
    zipCodeBillingController.clear();
    phoneNumberBillingController.clear();
    faxNumberBillingController.clear();

    firstNameShippingController.clear();
    lastNameShippingController.clear();
    emailShippingController.clear();
    companyNameShippingController.clear();
    cityShippingController.clear();
    countyShippingController.clear();
    address1ShippingController.clear();
    address2ShippingController.clear();
    zipCodeShippingController.clear();
    phoneNumberShippingController.clear();
    faxNumberShippingController.clear();

    notifyListeners();
    checkShippableProducts(context: context);
  }

  checkShippableProducts({required BuildContext context}) async
  {
    Response response = await CheckoutService().getShippingMethods(context: context);
    if(response.statusCode == 200)
    {
      isShippableProduct = true;
    }else{
      isShippableProduct = false;
    }

    if(LocalResourceProvider().getSettingByName("ordersettings.disablebillingaddresscheckoutstep")=='False') {
      billingAddressTabIndex = '1';
      shippingAddressTabIndex = '2';
      shippingMethodTabIndex = '3';
      paymentMethodTabIndex = '4';
      paymentInformationTabIndex = '5';
      confirmOrderTabIndex = '6';
    }else{
      billingAddressTabIndex = '1';
      shippingAddressTabIndex = '1';
      shippingMethodTabIndex = '2';
      paymentMethodTabIndex = '3';
      paymentInformationTabIndex = '4';
      confirmOrderTabIndex = '5';
      isShippingAddress = true;
    }

    if(!isShippableProduct){
      billingAddressTabIndex = '1';
      shippingAddressTabIndex = '';
      shippingMethodTabIndex = '';
      paymentMethodTabIndex = '2';
      paymentInformationTabIndex = '3';
      confirmOrderTabIndex = '4';
    }
    notifyListeners();
    if(LocalResourceProvider().getSettingByName("ordersettings.disablebillingaddresscheckoutstep")=='False') {
      billingAddress(context: context);
    }else{
      shippingAddress(context: context);
    }

  }

  billingAddress({required BuildContext context}) async
  {
    Response response = await CheckoutService().getBillingAddress(context: context, params: "?prepareAdd=true");
    if(response.statusCode == 200)
    {
      billingAddressDropdownList.clear();
      getBillingAddressesModel = getCustomerAddressesModelFromJson(response.body);

      firstNameBillingController.text = getBillingAddressesModel.newAddress.firstName;
      lastNameBillingController.text = getBillingAddressesModel.newAddress.lastName;
      emailBillingController.text = getBillingAddressesModel.newAddress.email;
      companyNameBillingController.text = getBillingAddressesModel.newAddress.company;
      cityBillingController.text = getBillingAddressesModel.newAddress.city;
      address1BillingController.text = getBillingAddressesModel.newAddress.address1;
      address2BillingController.text = getBillingAddressesModel.newAddress.address2;
      zipCodeBillingController.text = getBillingAddressesModel.newAddress.zipPostalCode;
      phoneNumberBillingController.text = getBillingAddressesModel.newAddress.phoneNumber;
      faxNumberBillingController.text = getBillingAddressesModel.newAddress.faxNumber;

      if(getBillingAddressesModel.addresses.isNotEmpty)
      {
        for(var address in getBillingAddressesModel.addresses)
        {
          var billingAddressLine = "";
          billingAddressLine += address.firstName;
          billingAddressLine += " " + address.lastName;

          if (address.streetAddressEnabled && address.address1 != null)
          {
            billingAddressLine += ", " + address.address1;
          }
          if (address.cityEnabled && address.city != null)
          {
            billingAddressLine += ", " + address.city;
          }
          if (address.countyEnabled && address.county != null)
          {
            billingAddressLine += ", " + address.county;
          }
          if (address.stateProvinceEnabled && address.stateProvinceName != null)
          {
            billingAddressLine += ", " + address.stateProvinceName;
          }
          if (address.zipPostalCodeEnabled && address.zipPostalCode != null)
          {
            billingAddressLine += " " + address.zipPostalCode;
          }
          if (address.countryEnabled && address.countryName != null)
          {
            billingAddressLine += ", " + address.countryName;
          }
          billingAddressDropdownList.add(new DropDownModel(text: billingAddressLine, value: address.id.toString()));
        }
        selectedBillingAddress = getBillingAddressesModel.addresses[0].id.toString();
      }

      billingAddressDropdownList.add(new DropDownModel(text: LocalResourceProvider().getResourseByKey("checkout.newaddress"), value: "0"));

      if(getBillingAddressesModel.addresses.isEmpty)
      {
        selectedBillingAddress = "0";
      }

      getBillingAddressesModel.newAddress.countryId = int.parse(getBillingAddressesModel.newAddress.availableCountries[0].value);
      getBillingAddressesModel.newAddress.countryName = getBillingAddressesModel.newAddress.availableCountries[0].text;

      billingStateDropdownList.clear();
      for(var address in getBillingAddressesModel.newAddress.availableStates)
      {
        billingStateDropdownList.add(new DropDownModel(text: address.text, value: address.value));
      }

      getBillingAddressesModel.newAddress.stateProvinceId = int.parse(billingStateDropdownList[0].value);
      getBillingAddressesModel.newAddress.stateProvinceName = billingStateDropdownList[0].text;

      isBillingAddressLoad = true;

    }else if(response.statusCode == 404){
      isBillingAddressLoad = false;
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else if(response.statusCode == 400){
      isBillingAddressLoad = false;
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }

    getOrderSummeryData(context: context);
  }

  shippingAddress({required BuildContext context}) async
  {

    Response response1 = await CheckoutService().getPickupPoints(context: context);
    if(response1.statusCode == 200)
    {
      getPickupPointsModel = getPickupPointsModelFromJson(response1.body);
      selectedPickupPoints = getPickupPointsModel.pickupPoints[0].id;
      isPickupPointsLoad = true;
      notifyListeners();
    }else if(response1.statusCode == 404){
      isPickupPointsLoad = false;
      FlushBarMessage().failedMessage(context: context, title: response1.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      isPickupPointsLoad = false;
      notifyListeners();
    }

    Response response = await CheckoutService().getShippingAddress(context: context, params: '?prepareAdd=true');
    if(response.statusCode == 200)
    {
      shippingAddressDropdownList.clear();
      getShippingAddressesModel = getCustomerAddressesModelFromJson(response.body);
      firstNameShippingController.text = getShippingAddressesModel.newAddress.firstName;
      lastNameShippingController.text = getShippingAddressesModel.newAddress.lastName;
      emailShippingController.text = getShippingAddressesModel.newAddress.email;
      companyNameShippingController.text = getShippingAddressesModel.newAddress.company;
      cityShippingController.text = getShippingAddressesModel.newAddress.city;
      address1ShippingController.text = getShippingAddressesModel.newAddress.address1;
      address2ShippingController.text = getShippingAddressesModel.newAddress.address2;
      zipCodeShippingController.text = getShippingAddressesModel.newAddress.zipPostalCode;
      phoneNumberShippingController.text = getShippingAddressesModel.newAddress.phoneNumber;
      faxNumberShippingController.text = getShippingAddressesModel.newAddress.faxNumber;
      if(getShippingAddressesModel.addresses.isNotEmpty)
      {
        for(var address in getShippingAddressesModel.addresses)
        {
          var shippingAddressLine = "";
          shippingAddressLine += address.firstName;
          shippingAddressLine += " " + address.lastName;

          if (address.streetAddressEnabled && address.address1 != null)
          {
            shippingAddressLine += ", " + address.address1;
          }
          if (address.cityEnabled && address.city != null)
          {
            shippingAddressLine += ", " + address.city;
          }
          if (address.countyEnabled && address.county != null)
          {
            shippingAddressLine += ", " + address.county;
          }
          if (address.stateProvinceEnabled && address.stateProvinceName != null)
          {
            shippingAddressLine += ", " + address.stateProvinceName;
          }
          if (address.zipPostalCodeEnabled && address.zipPostalCode != null)
          {
            shippingAddressLine += " " + address.zipPostalCode;
          }
          if (address.countryEnabled && address.countryName != null)
          {
            shippingAddressLine += ", " + address.countryName;
          }
          shippingAddressDropdownList.add(new DropDownModel(text: shippingAddressLine, value: address.id.toString()));
        }
        selectedShippingAddress = getShippingAddressesModel.addresses[0].id.toString();
      }

      shippingAddressDropdownList.add(new DropDownModel(text: LocalResourceProvider().getResourseByKey("checkout.newaddress"), value: "0"));

      if(getShippingAddressesModel.addresses.isEmpty)
      {
        selectedBillingAddress = "0";
      }

      getShippingAddressesModel.newAddress.countryId = int.parse(getShippingAddressesModel.newAddress.availableCountries[0].value);
      getShippingAddressesModel.newAddress.countryName = getShippingAddressesModel.newAddress.availableCountries[0].text;

      shippingStateDropdownList.clear();
      for(var address in getShippingAddressesModel.newAddress.availableStates)
      {
        shippingStateDropdownList.add(new DropDownModel(text: address.text, value: address.value));
      }

      getShippingAddressesModel.newAddress.stateProvinceId = int.parse(shippingStateDropdownList[0].value);
      getShippingAddressesModel.newAddress.stateProvinceName = shippingStateDropdownList[0].text;

      isShippingAddressLoad = true;

    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
      isShippingAddressLoad = false;
    }else{
      isShippingAddressLoad = false;
    }
    getOrderSummeryData(context: context);
  }

  getShippingMethods({required BuildContext context,required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    Response response = await CheckoutService().getShippingMethods(context: context);
    if(response.statusCode == 200)
    {
      if(response.body != "" && response.body != null)
      {
        getShippingMethodsModel = getShippingMethodsModelFromJson(response.body);

        List<ShippingMethod> shippingMethods = getShippingMethodsModel.shippingMethods.where((element) => element.selected).toList();
        if(shippingMethods.isNotEmpty)
        {
          selectedShippingMethodName = '${shippingMethods[0].name}___${shippingMethods[0].shippingRateComputationMethodSystemName}';
        }else{
          selectedShippingMethodName = '${getShippingMethodsModel.shippingMethods[0].name}___${getShippingMethodsModel.shippingMethods[0].shippingRateComputationMethodSystemName}';
        }

        isShippingMethodsLoad = true;

        scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);

        if(isShippableProduct){

          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = true;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isBillingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutShippingMethod()));
          }

        }else{

          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = false;
          isPaymentMethod = true;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isBillingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
          }
        }
      }



    }else if(response.statusCode == 404){
      isShippingMethodsLoad = false;
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else if(response.statusCode == 400){
      isShippingMethodsLoad = false;
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }else{
      isShippingMethodsLoad = false;
    }
    notifyListeners();
  }

  getOrderSummeryData({required BuildContext context}) async
  {
    Response response = await CheckoutService().getOrderSummery(context: context);
    if(response.statusCode == 200) {
      getOrderSummaryModel = getOrderSummaryModelFromJson(response.body);
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else if(response.statusCode == 400){
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }
    getOrderTotal(context: context);
  }

  getOrderTotal({required BuildContext context}) async
  {
    Response response = await CheckoutService().getOrderTotal(context: context);
    if(response.statusCode == 200)
    {
      orderTotalResponseModel = orderTotalResponseModelFromJson(response.body);
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else if(response.statusCode == 400){
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }
    isAPILoader = false;
    notifyListeners();
    getTopicBlock(context: context);

  }

  getTopicBlock({required BuildContext context}) async
  {
    Response response = await CommonService().getTopicBlock(context: context,topic: "conditionsofuse");
    if(response.statusCode == 200)
    {
      getTopicBlockModel = getTopicBlockModelFromJson(response.body);
    }else if(response.statusCode == 400){
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }
    getHeaderData(context: context);
  }

  getHeaderData({required BuildContext context})async {
    Response response = await CommonService().getHeaderData(context: context);
    storage.setItem(StringConstants.CACHE_HEADER, response.body);
    if(response.statusCode == 200)
    {
      headerModel = headerInfoResponseModelFromJson(response.body);
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("common.notification"), content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }
    isPageLoader = false;
    notifyListeners();
  }

  billingDropdownOnChange({required BuildContext context,required String value})
  {
    billingStateDropdownList = [];
    getBillingAddressesModel.newAddress.countryId = int.parse(getBillingAddressesModel.newAddress.availableCountries[0].value);
    getBillingAddressesModel.newAddress.countryName = getBillingAddressesModel.newAddress.availableCountries[0].text;

    billingStateDropdownList.clear();
    for(var address in getBillingAddressesModel.newAddress.availableStates)
    {
      billingStateDropdownList.add(new DropDownModel(text: address.text, value: address.value));
    }

    getBillingAddressesModel.newAddress.stateProvinceId = int.parse(billingStateDropdownList[0].value);
    getBillingAddressesModel.newAddress.stateProvinceName = billingStateDropdownList[0].text;

    selectedBillingAddress = value;
    notifyListeners();
  }

  shippingDropdownOnChange({required BuildContext context,required String value})
  {
    shippingStateDropdownList = [];
    getShippingAddressesModel.newAddress.countryId = int.parse(getShippingAddressesModel.newAddress.availableCountries[0].value);
    getShippingAddressesModel.newAddress.countryName = getShippingAddressesModel.newAddress.availableCountries[0].text;

    shippingStateDropdownList.clear();
    for(var address in getShippingAddressesModel.newAddress.availableStates)
    {
      shippingStateDropdownList.add(new DropDownModel(text: address.text, value: address.value));
    }

    getShippingAddressesModel.newAddress.stateProvinceId = int.parse(shippingStateDropdownList[0].value);
    getShippingAddressesModel.newAddress.stateProvinceName = shippingStateDropdownList[0].text;

    selectedShippingAddress = value;
    notifyListeners();
  }

  billingStatesByCountryId({required BuildContext context, required int countryId})async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CommonService().getStateData(context: context,countryId: countryId);
    if(response.statusCode == 200)
    {
      billingStateDropdownList.clear();
      List<StateModel> stateModelList = stateModelFromJson(response.body);
      for(var item in stateModelList)
      {
        billingStateDropdownList.add(new DropDownModel(text: item.name, value: item.id.toString()));
      }

      getBillingAddressesModel.newAddress.stateProvinceId = stateModelList[0].id;
      getBillingAddressesModel.newAddress.stateProvinceName = stateModelList[0].name;

    }
    isAPILoader = false;
    notifyListeners();
  }

  shippingStatesByCountryId({required BuildContext context, required int countryId})async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CommonService().getStateData(context: context,countryId: countryId);
    if(response.statusCode == 200)
    {
      shippingStateDropdownList.clear();
      List<StateModel> stateModelList = stateModelFromJson(response.body);
      for(var item in stateModelList)
      {
        shippingStateDropdownList.add(new DropDownModel(text: item.name, value: item.id.toString()));
      }

      getShippingAddressesModel.newAddress.stateProvinceId = stateModelList[0].id;
      getShippingAddressesModel.newAddress.stateProvinceName = stateModelList[0].name;

      isAPILoader = false;
      notifyListeners();
    }
  }

  addNewBillingAddress({required BuildContext context,required ScrollController scrollController ,required AddAddressRequestModel addAddressRequestModel,required Map<String, List<AddressAttributesValues>> billingCheckBoxMap, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Map<String, String> customerAttributesSelected = {};
    String prefixString = "address_attribute_";
    for(var item in getBillingAddressesModel.newAddress.customAddressAttributes)
    {
      if(item.attributeControlType == AttributeControlType.Checkboxes || item.attributeControlType == AttributeControlType.ReadonlyCheckboxes)
      {
        List<int> selectCheckbox=[];
        for(var cItem in item.values)
        {
          if(cItem.isPreSelected)
          {
            selectCheckbox.add(cItem.id);
          }
        }
        String checkboxString = selectCheckbox.join(",");
        customerAttributesSelected['"$prefixString${item.id}"'] = '"$checkboxString"';
      }else{
        String value="";
        if(item.defaultValue == null || item.defaultValue == "null")
        {
          value = "";
        }else{
          value = "${item.defaultValue}";
        }
        customerAttributesSelected['"$prefixString${item.id}"'] = '"$value"';
      }
    }

    final body = '{'
        '"firstName": "${addAddressRequestModel.firstName}",'
        '"lastName": "${addAddressRequestModel.lastName}",'
        '"email": "${addAddressRequestModel.email}",'
        '"company": "${addAddressRequestModel.company}",'
        '"countryId": ${addAddressRequestModel.countryId},'
        '"stateProvinceId": ${addAddressRequestModel.stateProvinceId},'
        '"county":"${addAddressRequestModel.county}",'
        '"city": "${addAddressRequestModel.city}",'
        '"address1": "${addAddressRequestModel.address1}",'
        '"address2": "${addAddressRequestModel.address2}",'
        '"zipPostalCode": "${addAddressRequestModel.zipPostalCode}",'
        '"phoneNumber": "${addAddressRequestModel.phoneNumber}",'
        '"faxNumber": "${addAddressRequestModel.faxNumber}",'
        '"customAddressAttributes": $customerAttributesSelected'
        '}';

    Response response = await CheckoutService().postAddBillingAddress(context: context, body: body);
    if(response.statusCode == 200)
    {
      if(isShippableProduct)
      {
        if(shipToSameAddressEnable)
        {
          addShipToSameAddress(context: context, body: body,scrollController: scrollController,isMultiCheckout: isMultiCheckout);
        }else{
          getShippingAddress(context: context,scrollController: scrollController,isMultiCheckout: isMultiCheckout);
        }
      }else{
        Response response = await CheckoutService().getPaymentMethods(context: context);
        if(response.statusCode == 200)
        {
          paymentMethodsModel450 = getPaymentMethodsFromJson(response.body);
          if(paymentMethodsModel450.paymentMethods.isNotEmpty)
          {
            List<PaymentMethod> paymentMethods = paymentMethodsModel450.paymentMethods.where((element) => element.selected).toList();
            if(paymentMethods.isNotEmpty)
            {
              selectedPaymentMethod = paymentMethods[0].paymentMethodSystemName;
            }else{
              selectedPaymentMethod = paymentMethodsModel450.paymentMethods[0].paymentMethodSystemName;
            }
          }

          isPaymentMethodAndPaymentInfo = true;
          isPaymentMethodsLoad = true;

          scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);


          isBillingAddress = false;
          isShippingAddress =false;
          isShippingMethod = false;
          isPaymentMethod = true;
          isConfirmOrder = false;
          isPaymentInformationMethod =false;
          isBillingAddressTabCompleted=true;

          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
          }
        }else if(response.statusCode == 404){
          isPaymentMethodsLoad = false;
          FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
        }else{
          isPaymentMethodsLoad = false;
          isPaymentMethodAndPaymentInfo = false;
          notifyListeners();
        }
        isAPILoader = false;
        notifyListeners();
      }

    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }
    isAPILoader = false;
    notifyListeners();

  }

  updateBillingAddress({required BuildContext context,required ScrollController scrollController , required int addressId, required bool shipToSameAddress, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

      Response response1 = await CheckoutService().uploadBillingAddress(context: context, params: "/$addressId?shipToSameAddress=$shipToSameAddress");
      if(response1.statusCode == 200)
      {
        if(isShippableProduct)
        {
          if(shipToSameAddressEnable)
          {
            await updateBillingToShippingAddress(context: context, addressId: addressId, scrollController: scrollController, isMultiCheckout: isMultiCheckout);
          }
          else{
            await getShippingAddress(context: context,scrollController: scrollController, isMultiCheckout: isMultiCheckout);
          }
        }else{

          Response response = await CheckoutService().getPaymentMethods(context: context);
          if(response.statusCode == 200)
          {
            paymentMethodsModel450 = getPaymentMethodsFromJson(response.body);
            if(paymentMethodsModel450.paymentMethods.isNotEmpty)
            {
              List<PaymentMethod> paymentMethods = paymentMethodsModel450.paymentMethods.where((element) => element.selected).toList();
              if(paymentMethods.isNotEmpty)
              {
                selectedPaymentMethod = paymentMethods[0].paymentMethodSystemName;
              }else{
                selectedPaymentMethod = paymentMethodsModel450.paymentMethods[0].paymentMethodSystemName;
              }
            }

            isPaymentMethodAndPaymentInfo = true;
            isPaymentMethodsLoad = true;

            scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);


            isBillingAddress = false;
            isShippingAddress =false;
            isShippingMethod = false;
            isPaymentMethod = true;
            isConfirmOrder = false;
            isPaymentInformationMethod =false;
            isBillingAddressTabCompleted=true;

            notifyListeners();

            if(isMultiCheckout)
            {
              isAPILoader = false;
              notifyListeners();
              Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
            }
          }else if(response.statusCode == 404){
            isPaymentMethodsLoad = false;
            FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
            Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
          }else{
            isPaymentMethodsLoad = false;
            isPaymentMethodAndPaymentInfo = false;
            notifyListeners();
          }
          isAPILoader = false;
          notifyListeners();
        }

      }else if(response1.statusCode == 404){
        FlushBarMessage().failedMessage(context: context, title: response1.body.replaceAll('"', ""));
        Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
      }

    isAPILoader = false;
    notifyListeners();
  }

  updateBillingToShippingAddress({required BuildContext context, required int addressId,required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CheckoutService().uploadShippingAddress(context: context, params: "/$addressId");
    if(response.statusCode == 200)
    {

      Response response = await CheckoutService().getPickupPoints(context: context);
      if(response.statusCode == 200)
      {
        getPickupPointsModel = getPickupPointsModelFromJson(response.body);
        selectedPickupPoints = getPickupPointsModel.pickupPoints[0].id;
        isPickupPointsLoad = true;
        notifyListeners();

        getShippingMethods(context: context,scrollController: scrollController,isMultiCheckout: isMultiCheckout);

      }else if(response.statusCode == 404){
        isPickupPointsLoad = false;
        FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
        Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
      }else{
        isPickupPointsLoad = false;
        notifyListeners();
      }
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }

  }

  updateShippingAddress({required BuildContext context,required ScrollController scrollController, required int addressId, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CheckoutService().uploadShippingAddress(context: context, params: "/$addressId");
    if(response.statusCode == 200)
    {

      if (!isPickupPointEnable) {

        Response response1 = await CheckoutService().getShippingMethods(context: context);
        if(response1.statusCode == 200)
        {
          if(response1.body != "" && response1.body != null)
          {
            getShippingMethodsModel = getShippingMethodsModelFromJson(response1.body);

            List<ShippingMethod> shippingMethods = getShippingMethodsModel.shippingMethods.where((element) => element.selected).toList();
            if(shippingMethods.isNotEmpty)
            {
              selectedShippingMethodName = '${shippingMethods[0].name}___${shippingMethods[0].shippingRateComputationMethodSystemName}';
            }else{
              selectedShippingMethodName = '${getShippingMethodsModel.shippingMethods[0].name}___${getShippingMethodsModel.shippingMethods[0].shippingRateComputationMethodSystemName}';
            }

            isShippingMethodsLoad = true;

            scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);
            isBillingAddress = false;
            isShippingAddress = false;
            isShippingMethod = true;
            isPaymentMethod = false;
            isConfirmOrder = false;
            isPaymentInformationMethod = false;
            isShippingAddressTabCompleted = true;
            notifyListeners();

            if(isMultiCheckout)
            {
              isAPILoader = false;
              notifyListeners();
              Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutShippingMethod()));
            }
          }
        }else if(response1.statusCode == 404){
          isShippingMethodsLoad = false;
          FlushBarMessage().failedMessage(context: context, title: response1.body.replaceAll('"', ""));
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
        }else if(response1.statusCode == 400){
          isShippingMethodsLoad = false;
          InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response1.body);
          FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
        }else{
          isShippingMethodsLoad = false;
        }

      }else{

        Response response1 = await CheckoutService().getPaymentMethods(context: context);
        if(response1.statusCode == 200)
        {
          paymentMethodsModel450 = getPaymentMethodsFromJson(response1.body);
          if(paymentMethodsModel450.paymentMethods.isNotEmpty)
          {
            List<PaymentMethod> paymentMethods = paymentMethodsModel450.paymentMethods.where((element) => element.selected).toList();
            if(paymentMethods.isNotEmpty)
            {
              selectedPaymentMethod = paymentMethods[0].paymentMethodSystemName;
            }else{
              selectedPaymentMethod = paymentMethodsModel450.paymentMethods[0].paymentMethodSystemName;
            }
          }

          isPaymentMethodAndPaymentInfo = true;
          isPaymentMethodsLoad = true;

          scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = false;
          isPaymentMethod = true;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isShippingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
          }

        }else if(response1.statusCode == 404){
          isPaymentMethodsLoad = false;
          FlushBarMessage().failedMessage(context: context, title: response1.body.replaceAll('"', ""));
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
        }else{
          isPaymentMethodsLoad = false;
          isPaymentMethodAndPaymentInfo = false;
          notifyListeners();
        }
        isAPILoader = false;
        notifyListeners();
      }
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }

    isAPILoader = false;
    notifyListeners();
  }

  addShipToSameAddress({required BuildContext context,required var body,required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CheckoutService().postAddShippingAddress(context: context, body: body);
    if(response.statusCode == 200)
    {
      Response response = await CheckoutService().getPickupPoints(context: context);
      if(response.statusCode == 200)
      {
        getPickupPointsModel = getPickupPointsModelFromJson(response.body);
        selectedPickupPoints = getPickupPointsModel.pickupPoints[0].id;
        isPickupPointsLoad = true;
        notifyListeners();

        getShippingMethods(context: context,scrollController: scrollController,isMultiCheckout: isMultiCheckout);

      }else if(response.statusCode == 404){
        isPickupPointsLoad = false;
        FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
        Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
      }else{
        isPickupPointsLoad = false;
        notifyListeners();
      }
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }
  }


  getShippingAddress({required BuildContext context,required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    Response response = await CheckoutService().getShippingAddress(context: context, params: '?prepareAdd=true');
    if(response.statusCode == 200)
    {
      shippingAddressDropdownList.clear();
      getShippingAddressesModel = getCustomerAddressesModelFromJson(response.body);
      if(getShippingAddressesModel.addresses.isNotEmpty)
      {
        for(var address in getShippingAddressesModel.addresses)
        {
          var billingAddressLine = "";
          billingAddressLine += address.firstName;
          billingAddressLine += " " + address.lastName;

          if (address.streetAddressEnabled && address.address1 != null)
          {
            billingAddressLine += ", " + address.address1;
          }
          if (address.cityEnabled && address.city != null)
          {
            billingAddressLine += ", " + address.city;
          }
          if (address.countyEnabled && address.county != null)
          {
            billingAddressLine += ", " + address.county;
          }
          if (address.stateProvinceEnabled && address.stateProvinceName != null)
          {
            billingAddressLine += ", " + address.stateProvinceName;
          }
          if (address.zipPostalCodeEnabled && address.zipPostalCode != null)
          {
            billingAddressLine += " " + address.zipPostalCode;
          }
          if (address.countryEnabled && address.countryName != null)
          {
            billingAddressLine += ", " + address.countryName;
          }
          shippingAddressDropdownList.add(new DropDownModel(text: billingAddressLine, value: address.id.toString()));
        }
        selectedShippingAddress = getShippingAddressesModel.addresses[0].id.toString();
      }

      shippingAddressDropdownList.add(new DropDownModel(text: LocalResourceProvider().getResourseByKey("checkout.newaddress"), value: "0"));

      if(getShippingAddressesModel.addresses.isEmpty)
      {
        selectedBillingAddress = "0";
      }

      getShippingAddressesModel.newAddress.countryId = int.parse(getShippingAddressesModel.newAddress.availableCountries[0].value);
      getShippingAddressesModel.newAddress.countryName = getShippingAddressesModel.newAddress.availableCountries[0].text;

      shippingStateDropdownList.clear();
      for(var address in getShippingAddressesModel.newAddress.availableStates)
      {
        shippingStateDropdownList.add(new DropDownModel(text: address.text, value: address.value));
      }

      getShippingAddressesModel.newAddress.stateProvinceId = int.parse(shippingStateDropdownList[0].value);
      getShippingAddressesModel.newAddress.stateProvinceName = shippingStateDropdownList[0].text;
      isShippingAddressLoad = true;
      notifyListeners();

    }else if(response.statusCode == 404){
      isShippingAddressLoad = false;
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      isShippingAddressLoad = false;
    }

    getPickupPoints(context: context,scrollController: scrollController,isMultiCheckout: isMultiCheckout);
  }

  shippingAddressBackButton({required BuildContext context})
  {
    isBillingAddress = true;
    isShippingAddress = false;
    isShippingMethod = false;
    isPaymentMethod = false;
    isConfirmOrder = false;
    isPaymentInformationMethod =false;
    isBillingAddressTabCompleted = false;
    isShippingAddressTabCompleted = false;
    notifyListeners();
  }

  addNewShippingAddress({required BuildContext context, required ScrollController scrollController,required AddAddressRequestModel addAddressRequestModel,required Map<String, List<AddressAttributesValues>> billingCheckBoxMap, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Map<String, String> customerAttributesSelected = {};
    String prefixString = "address_attribute_";
    for(var item in getBillingAddressesModel.newAddress.customAddressAttributes)
    {
      if(item.attributeControlType == AttributeControlType.Checkboxes || item.attributeControlType == AttributeControlType.ReadonlyCheckboxes)
      {
        List<int> selectCheckbox=[];
        for(var cItem in item.values)
        {
          if(cItem.isPreSelected)
          {
            selectCheckbox.add(cItem.id);
          }
        }
        String checkboxString = selectCheckbox.join(",");
        customerAttributesSelected['"$prefixString${item.id}"'] = '"$checkboxString"';
      }else{
        String value="";
        if(item.defaultValue == null || item.defaultValue == "null")
        {
          value = "";
        }else{
          value = "${item.defaultValue}";
        }
        customerAttributesSelected['"$prefixString${item.id}"'] = '"$value"';
      }
    }

    final body = '{'
        '"firstName": "${addAddressRequestModel.firstName}",'
        '"lastName": "${addAddressRequestModel.lastName}",'
        '"email": "${addAddressRequestModel.email}",'
        '"company": "${addAddressRequestModel.company}",'
        '"countryId": ${addAddressRequestModel.countryId},'
        '"stateProvinceId": ${addAddressRequestModel.stateProvinceId},'
        '"county":"${addAddressRequestModel.county}",'
        '"city": "${addAddressRequestModel.city}",'
        '"address1": "${addAddressRequestModel.address1}",'
        '"address2": "${addAddressRequestModel.address2}",'
        '"zipPostalCode": "${addAddressRequestModel.zipPostalCode}",'
        '"phoneNumber": "${addAddressRequestModel.phoneNumber}",'
        '"faxNumber": "${addAddressRequestModel.faxNumber}",'
        '"customAddressAttributes": $customerAttributesSelected'
        '}';

    Response response = await CheckoutService().postAddShippingAddress(context: context, body: body);
    if(response.statusCode == 200)
    {
      if (!isPickupPointEnable) {

        Response response1 = await CheckoutService().getShippingMethods(context: context);
        if(response1.statusCode == 200)
        {
          if(response1.body != "" && response1.body != null)
          {
            getShippingMethodsModel = getShippingMethodsModelFromJson(response1.body);

            List<ShippingMethod> shippingMethods = getShippingMethodsModel.shippingMethods.where((element) => element.selected).toList();
            if(shippingMethods.isNotEmpty)
            {
              selectedShippingMethodName = '${shippingMethods[0].name}___${shippingMethods[0].shippingRateComputationMethodSystemName}';
            }else{
              selectedShippingMethodName = '${getShippingMethodsModel.shippingMethods[0].name}___${getShippingMethodsModel.shippingMethods[0].shippingRateComputationMethodSystemName}';
            }

            isShippingMethodsLoad = true;

            scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);
            isBillingAddress = false;
            isShippingAddress = false;
            isShippingMethod = true;
            isPaymentMethod = false;
            isConfirmOrder = false;
            isPaymentInformationMethod = false;
            isShippingAddressTabCompleted = true;
            notifyListeners();

            if(isMultiCheckout)
            {
              isAPILoader = false;
              notifyListeners();
              Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutShippingMethod()));
            }
          }
        }else if(response1.statusCode == 404){
          isShippingMethodsLoad = false;
          FlushBarMessage().failedMessage(context: context, title: response1.body.replaceAll('"', ""));
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
        }else if(response1.statusCode == 400){
          isShippingMethodsLoad = false;
          InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response1.body);
          FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
        }else{
          isShippingMethodsLoad = false;
        }

      }else{

        Response response1 = await CheckoutService().getPaymentMethods(context: context);
        if(response1.statusCode == 200)
        {
          paymentMethodsModel450 = getPaymentMethodsFromJson(response1.body);
          if(paymentMethodsModel450.paymentMethods.isNotEmpty)
          {
            List<PaymentMethod> paymentMethods = paymentMethodsModel450.paymentMethods.where((element) => element.selected).toList();
            if(paymentMethods.isNotEmpty)
            {
              selectedPaymentMethod = paymentMethods[0].paymentMethodSystemName;
            }else{
              selectedPaymentMethod = paymentMethodsModel450.paymentMethods[0].paymentMethodSystemName;
            }
          }

          isPaymentMethodAndPaymentInfo = true;
          isPaymentMethodsLoad = true;

          scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = false;
          isPaymentMethod = true;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isShippingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
          }

        }else if(response1.statusCode == 404){
          isPaymentMethodsLoad = false;
          FlushBarMessage().failedMessage(context: context, title: response1.body.replaceAll('"', ""));
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
        }else{
          isPaymentMethodsLoad = false;
          isPaymentMethodAndPaymentInfo = false;
          notifyListeners();
        }
        isAPILoader = false;
        notifyListeners();
      }

    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }
    isAPILoader = false;
    notifyListeners();

  }

  updatePickupPointShippingMethod({required BuildContext context, required ScrollController scrollController, required String shippingMethodName, required bool isPickup, required pickupPointName, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    var body =
        '{'
        '"shippingMethodName": "$shippingMethodName",'
        '"isPickup": $isPickup,'
        '"pickupPointName": "$pickupPointName"'
        '}';

    Response response = await CheckoutService().uploadShippingMethod(context: context, body: body);
    if(response.statusCode == 200)
    {
      if (!isPickupPointEnable) {

          scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = true;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isShippingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutShippingMethod()));
          }

      }else{

        Response response1 = await CheckoutService().getPaymentMethods(context: context);
        if(response1.statusCode == 200)
        {
          paymentMethodsModel450 = getPaymentMethodsFromJson(response1.body);
          if(paymentMethodsModel450.paymentMethods.isNotEmpty)
          {
            List<PaymentMethod> paymentMethods = paymentMethodsModel450.paymentMethods.where((element) => element.selected).toList();
            if(paymentMethods.isNotEmpty)
            {
              selectedPaymentMethod = paymentMethods[0].paymentMethodSystemName;
            }else{
              selectedPaymentMethod = paymentMethodsModel450.paymentMethods[0].paymentMethodSystemName;
            }
          }

          isPaymentMethodAndPaymentInfo = true;
          isPaymentMethodsLoad = true;

          scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = false;
          isPaymentMethod = true;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isShippingAddressTabCompleted = true;

          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
          }
        }else if(response1.statusCode == 404){
          isPaymentMethodsLoad = false;
          FlushBarMessage().failedMessage(context: context, title: response1.body.replaceAll('"', ""));
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
        }else{
          isPaymentMethodsLoad = false;
          isPaymentMethodAndPaymentInfo = false;
          notifyListeners();
        }
        isAPILoader = false;
        notifyListeners();

      }
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }

    isAPILoader = false;
    notifyListeners();
  }

  updateShippingMethod({required BuildContext context, required ScrollController scrollController, required String shippingMethodName, required bool isPickup, required pickupPointName, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    var body =
        '{'
          '"ShippingMethodName": "$shippingMethodName",'
          '"IsPickup": $isPickup,'
          '"PickupIsPickupPointName": "$pickupPointName"'
        '}';

    Response response = await CheckoutService().uploadShippingMethod(context: context, body: body);
    if(response.statusCode == 200)
    {
      await getPaymentMethods(context: context,scrollController: scrollController,isMultiCheckout: isMultiCheckout);
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }

    isAPILoader = false;
    notifyListeners();
  }

  getPickupPoints({required BuildContext context,required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CheckoutService().getPickupPoints(context: context);
    if(response.statusCode == 200)
    {
      getPickupPointsModel = getPickupPointsModelFromJson(response.body);
      selectedPickupPoints = getPickupPointsModel.pickupPoints[0].id;
      isPickupPointsLoad = true;
      notifyListeners();
    }else if(response.statusCode == 404){
      isPickupPointsLoad = false;
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      isPickupPointsLoad = false;
      notifyListeners();
    }

    if (!shipToSameAddressEnable) {
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);

      if(isShippableProduct){

          isBillingAddress = false;
          isShippingAddress = true;
          isShippingMethod = false;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isBillingAddressTabCompleted = true;
          notifyListeners();
          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutShippingAddress()));
          }

      }else{

          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = false;
          isPaymentMethod = true;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isBillingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
          }
      }
    }
    else{
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      if(isShippableProduct){

          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = true;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isBillingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutShippingMethod()));
          }
      }else{
          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = false;
          isPaymentMethod = true;
          isConfirmOrder = false;
          isPaymentInformationMethod = false;
          isBillingAddressTabCompleted = true;
          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
          }
      }
    }

    isShippingDataLoad = true;
    isAPILoader = false;
    notifyListeners();
  }

  pickupPointDropdownOnChange({required BuildContext context,required String value})
  {
    selectedPickupPoints = value;
    notifyListeners();
  }

  shippingMethodBackButton({required BuildContext context,required ScrollController scrollController})
  {
    if(!isAPILoader)
    {
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      if (shipToSameAddressEnable ==false){
        isBillingAddress = false;
        isShippingAddress = true;
        isShippingMethod = false;
        isPaymentMethod = false;
        isConfirmOrder = false;
        isPaymentInformationMethod =false;
        isShippingAddressTabCompleted = false;
        isShippingMethodTabCompleted = false;
        notifyListeners();

      }else{
        isBillingAddress = true;
        isShippingAddress = false;
        isShippingMethod = false;
        isPaymentMethod = false;
        isConfirmOrder = false;
        isPaymentInformationMethod =false;
        isBillingAddressTabCompleted = false;
        isShippingMethodTabCompleted = false;
        notifyListeners();
      }
      notifyListeners();
    }
  }

  getPaymentMethods({required BuildContext context, required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    isAPILoader = true;
    notifyListeners();

    Response response = await CheckoutService().getPaymentMethods(context: context);

    if(response.statusCode == 200)
     {
       if(preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_CURRENT_VERSION) == VersionType.version450){
         paymentMethodsModel450 = getPaymentMethodsFromJson(response.body);
         if(paymentMethodsModel450.paymentMethods.isNotEmpty)
         {
           List<PaymentMethod> paymentMethods = paymentMethodsModel450.paymentMethods.where((element) => element.selected).toList();
           if(paymentMethods.isNotEmpty)
           {
             selectedPaymentMethod = paymentMethods[0].paymentMethodSystemName;
           }else{
             selectedPaymentMethod = paymentMethodsModel450.paymentMethods[0].paymentMethodSystemName;
           }
         }
       }
       else{
         // getPaymentMethodsModel = getPaymentMethodsModelFromJson(response.body);
         // if(getPaymentMethodsModel.paymentMethods.isNotEmpty)
         // {
         //   List<PaymentMethod> paymentMethods = getPaymentMethodsModel.paymentMethods.where((element) => element.selected).toList();
         //   if(paymentMethods.isNotEmpty)
         //   {
         //     selectedPaymentMethod = paymentMethods[0].paymentMethodSystemName;
         //   }else{
         //     selectedPaymentMethod = getPaymentMethodsModel.paymentMethods[0].paymentMethodSystemName;
         //   }
         // }
       }



       isPaymentMethodAndPaymentInfo = true;
       isPaymentMethodsLoad = true;

       scrollController.animateTo(
           scrollController.position.minScrollExtent,
           duration: Duration(milliseconds: 500),
           curve: Curves.ease);

       isBillingAddress = false;
       isShippingAddress = false;
       isShippingMethod = false;
       isPaymentMethod = true;
       isConfirmOrder = false;
       isPaymentInformationMethod = false;
       isShippingMethodTabCompleted = true;
       if (!isPaymentMethodAndPaymentInfo) {
         isConfirmOrder = true;
         isPaymentMethod = false;
         isPaymentInformationMethod = false;
       }

       notifyListeners();

       if(isMultiCheckout)
       {
         isAPILoader = false;
         notifyListeners();
         Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
       }
     }else if(response.statusCode == 404){
       isPaymentMethodsLoad = false;
       FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
       Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
     }else{
       isPaymentMethodsLoad = false;
       isPaymentMethodAndPaymentInfo = false;
       notifyListeners();
     }


    isAPILoader = false;
    notifyListeners();
  }

  paymentMethodBackButton({required BuildContext context,required ScrollController scrollController})
  {
    if(!isAPILoader)
    {
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);

      if(isShippableProduct){
        if(isPickupPointEnable)
        {
          isBillingAddress = false;
          isShippingAddress = true;
          isShippingMethod = false;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod =false;
          isPaymentMethodTabCompleted =false;
          isShippingMethodTabCompleted = false;
        }
        else
        {
          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = true;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod =false;
          isShippingMethodTabCompleted = false;
          isPaymentMethodTabCompleted=false;
        }
      }else{
        isBillingAddress = true;
        isShippingAddress = false;
        isShippingMethod = false;
        isPaymentMethod = false;
        isConfirmOrder = false;
        isPaymentInformationMethod =false;
        isPaymentMethodTabCompleted=false;
      }
      notifyListeners();
    }
  }

  uploadPaymentMethod({required BuildContext context, required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CheckoutService().uploadPaymentMethod(context: context, params: '/$selectedPaymentMethod'+'?useRewardPoints=$isRewardPointEnable');
    if(response.statusCode == 200)
    {
      getPaymentInfo(context: context,scrollController: scrollController,isMultiCheckout: isMultiCheckout);
    }else if(response.statusCode == 404){
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else if(response.statusCode == 400){

      Response response1 = await CheckoutService().getOrderSummery(context: context);
      if(response1.statusCode == 200) {
        getOrderSummaryModel = getOrderSummaryModelFromJson(response1.body);

        getPaymentInfo(context: context,scrollController: scrollController,isMultiCheckout: isMultiCheckout);

      }else if(response1.statusCode == 400){
        isConfirmOrderLoad = false;
        InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response1.body);
        FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
      }else{
        isConfirmOrderLoad = false;
        notifyListeners();
      }
      isConfirmOrderLoad = true;
    }
  }

  getPaymentInfo({required BuildContext context, required ScrollController scrollController, required bool isMultiCheckout}) async
  {
    Response response = await CheckoutService().getPaymentInfo(context: context);
    if(response.statusCode == 200)
    {
      var getPayment = response.body;
      getPaymentInfoModel = getPaymentInfoModelFromJson(getPayment);
      if(getPaymentInfoModel.paymentMethodName=='Payments.AuthorizeNet'|| getPaymentInfoModel.paymentMethodName=='Payments.BrainTree')
      {
        getPaymentInfoNetBankingModel = getPaymentInfoNetBankingModelFromJson(getPayment);

        if(getPaymentInfoNetBankingModel.expireMonth == '' || getPaymentInfoNetBankingModel.expireMonth == null) {
          getPaymentInfoNetBankingModel.expireMonth = getPaymentInfoNetBankingModel.expireMonths[0].value;
        }
        if(getPaymentInfoNetBankingModel.expireYear == '' || getPaymentInfoNetBankingModel.expireYear == null) {
          getPaymentInfoNetBankingModel.expireYear = getPaymentInfoNetBankingModel.expireYears[0].value;
        }
      }
      else if(getPaymentInfoModel.paymentMethodName=='Payments.PayPalStandard'|| getPaymentInfoModel.paymentMethodName=='Payments.TwoCheckout'){
        paypalStandardModel =paypalStandardModelFromJson(getPayment);
      }else if(getPaymentInfoModel.paymentMethodName=='Payments.PurchaseOrder'){
        purchaseOrderModel =purchaseOrderModelFromJson(getPayment);
      }else if(getPaymentInfoModel.paymentMethodName=='Payments.Manual')
      {
        manualPaymentModel=manualPaymentModelFromJson(getPayment);
        manualPaymentModel.creditCardType = manualPaymentModel.creditCardTypes[0].value;
        manualPaymentModel.expireMonth = manualPaymentModel.expireMonths[0].value;
        manualPaymentModel.expireYear = manualPaymentModel.expireYears[0].value;
      }

      isPaymentInfoLoad = true;
      isOrderSummeryLoad = true;
      isPaymentWorking = true;
      isOnlyRewardPoints = false;
      isBillingAddress = false;
      isShippingAddress = false;
      isShippingMethod = false;
      isPaymentMethod = false;
      isConfirmOrder = false;
      isPaymentInformationMethod = true;
      isPaymentMethodTabCompleted = true;

      isAPILoader = false;
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);

      notifyListeners();

      if(isMultiCheckout)
      {
        isAPILoader = false;
        isPaymentWorking = true;
        isPaymentInformationMethod = true;
        notifyListeners();
        Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentInfo()));
      }

    }
    else if(response.statusCode == 400){
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);

      isOnlyRewardPoints=true;
      isConfirmOrderLoad = true;
      isBillingAddress = false;
      isShippingAddress = false;
      isShippingMethod = false;
      isPaymentMethod = false;
      isConfirmOrder = true;
      isPaymentMethodTabCompleted = true;
      isPaymentInformationMethodTabCompleted = false;

      isAPILoader = false;
      notifyListeners();

      if(isMultiCheckout)
      {
        isAPILoader = false;
        isPaymentWorking = true;
        isPaymentInformationMethod = true;
        notifyListeners();
        Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutConfirmOrder(body: "{}")));
      }
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }else if(response.statusCode == 404){
      isPaymentInfoLoad = false;
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      isPaymentInfoLoad = false;
      isOnlyRewardPoints=true;
      isBillingAddress = false;
      isShippingAddress = false;
      isShippingMethod = false;
      isPaymentMethod = false;
      isConfirmOrder = true;
      isPaymentInformationMethod =false;
      isPaymentMethodTabCompleted = true;

      isAPILoader = false;
      notifyListeners();
    }
  }

  billingAddressTabExpand({required BuildContext context})
  {
    print("isAPILoader $isAPILoader");
    if(!isAPILoader)
    {
      print("False");
      if(isBillingAddressTabCompleted){
        isShippingAddress = false;
        isShippingMethod = false;
        isPaymentMethod = false;
        isConfirmOrder = false;
        isPaymentInformationMethod =false;
        isShippingAddressTabCompleted = false;
        isShippingMethodTabCompleted = false;
        isPaymentMethodTabCompleted = false;
        isConfirmOrderTabCompleted = false;
        isPaymentInformationMethodTabCompleted =false;
        isBillingAddress = true;
      }
      notifyListeners();
    }else{
      print("True");
    }
  }

  shippingAddressTabExpand({required BuildContext context})
  {
    if(!isAPILoader)
    {
      if(isShippingAddressTabCompleted){
          isShippingMethod = false;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod =false;
          isShippingMethodTabCompleted = false;
          isPaymentMethodTabCompleted = false;
          isConfirmOrderTabCompleted = false;
          isPaymentInformationMethodTabCompleted =false;
          isShippingAddress = true;
      }
      notifyListeners();
    }
  }

  shippingMethodTabExpand({required BuildContext context})
  {
    if(!isAPILoader)
    {
      if(isShippingMethodTabCompleted ){
        isPaymentMethod = false;
        isConfirmOrder = false;
        isPaymentInformationMethod =false;
        isPaymentMethodTabCompleted = false;
        isConfirmOrderTabCompleted = false;
        isPaymentInformationMethodTabCompleted =false;
        isShippingMethod = true;
      }
      notifyListeners();
    }
  }

  paymentMethodTabExpand({required BuildContext context})
  {
    if(!isAPILoader)
    {
      if(isPaymentMethodTabCompleted ){
        isConfirmOrder = false;
        isPaymentInformationMethod =false;
        isConfirmOrderTabCompleted = false;
        isPaymentInformationMethodTabCompleted =false;
        isPaymentMethod = true;
      }
      notifyListeners();
    }
  }

  paymentInfoTabExpand({required BuildContext context})
  {
    if(!isAPILoader)
    {
      if(isPaymentInformationMethodTabCompleted ){
        isConfirmOrder = false;
        isConfirmOrderTabCompleted=false;
        isPaymentInformationMethod =!isPaymentInformationMethod;
        isPaymentInformationMethod = true;
      }
      notifyListeners();
    }
  }

  confirmOrderTabExpand({required BuildContext context})
  {
    if(!isAPILoader)
    {
      if(isConfirmOrderTabCompleted ){
        isConfirmOrder = true;
      }
      notifyListeners();
    }
  }

  paymentInfoBackButton({required BuildContext context, required ScrollController scrollController})
  {
    if(!isAPILoader)
    {
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);

      isBillingAddress = false;
      isShippingAddress = false;
      isShippingMethod = false;
      isPaymentMethod = true;
      isConfirmOrder = false;
      isPaymentInformationMethod=false;
      isPaymentInformationMethodTabCompleted = false;
      isConfirmOrderTabCompleted = false;
      notifyListeners();
    }
  }

  paymentInfoNextButton({required BuildContext context, required ScrollController scrollController, required var body, required bool isMultiCheckout}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CheckoutService().validatePaymentInfo(context: context,body: body);
    if(response.statusCode == 200)
    {
      validatePaymentInfo = validatePaymentInfoResponseModelFromJson(response.body);
      if(validatePaymentInfo.success)
      {
        Response response = await CheckoutService().getOrderSummery(context: context);
        if(response.statusCode == 200) {
          getOrderSummaryModel = getOrderSummaryModelFromJson(response.body);

            scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);

            isConfirmOrderLoad = true;
            isBillingAddress = false;
            isShippingAddress = false;
            isShippingMethod = false;
            isPaymentMethod = false;
            isConfirmOrder = true;
            isPaymentInformationMethod = false;
            isPaymentInformationMethodTabCompleted = true;
            isConfirmOrderTabCompleted = true;

          notifyListeners();

          if(isMultiCheckout)
          {
            isAPILoader = false;
            isPaymentWorking = true;
            notifyListeners();
            Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutConfirmOrder(body: body)));
          }

        }else if(response.statusCode == 400){
          isConfirmOrderLoad = false;
          InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
          FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
        }else{
          isConfirmOrderLoad = false;
          notifyListeners();
        }
        isConfirmOrderLoad = true;
      }else{
        isConfirmOrderLoad = false;
        FlushBarMessage().failedMessage(context: context, title: validatePaymentInfo.errors.join("\n"));
      }
    }else if(response.statusCode == 404){
      isConfirmOrderLoad = false;
      FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ""));
      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
    }else{
      isConfirmOrderLoad = false;
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }
    isAPILoader = false;
    notifyListeners();
  }

  confirmOrderBackButton({required BuildContext context, required ScrollController scrollController})
  {

    if(!isAPILoader)
    {
      scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);

      if(isOnlyRewardPoints){
        isBillingAddress = false;
        isShippingAddress = false;
        isShippingMethod = false;
        isPaymentMethod = true;
        isConfirmOrder = false;
        isPaymentInformationMethod=false;
        isConfirmOrderTabCompleted = false;
        isPaymentMethodTabCompleted = true;
      }
      else{
        isBillingAddress = false;
        isShippingAddress = false;
        isShippingMethod = false;
        isPaymentMethod = false;
        isConfirmOrder = false;
        isPaymentMethodTabCompleted = true;
        isPaymentInformationMethod=true;
        isConfirmOrderTabCompleted = false;
      }
      notifyListeners();
    }

  }

  confirmOrderConfirmButton({required BuildContext context, required ScrollController scrollController, required var body,required bool isMultiCheckout}) async
  {

      isAPILoader = true;
      notifyListeners();
      Response response = await CheckoutService().confirmOrder(context: context, body: body);
      Response response1 = await CheckoutService().getOrderCompleteInfo(context: context);
      if(response.statusCode == 200)
      {
        confirmOrderModel = confirmOrderModelFromJson(response.body);
        if(confirmOrderModel.success){
          isBillingAddress = false;
          isShippingAddress = false;
          isShippingMethod = false;
          isPaymentMethod = false;
          isConfirmOrder = false;
          isPaymentInformationMethod =false;
          notifyListeners();

          scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);

          if(confirmOrderModel.redirectionUrl == null || confirmOrderModel.redirectionUrl==''){
            if(LocalResourceProvider().getSettingByName("ordersettings.disableordercompletedpage")=='True') {
              isAPILoader = false;
              notifyListeners();
              if(isMultiCheckout)
              {
                Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutCompleteOrder()));
              }else{
                Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: OrderDetails(orderId: confirmOrderModel.orderId)));
              }
            }else{
              isAPILoader = false;
              notifyListeners();
              Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: OrderConfirmPage(orderId: confirmOrderModel.orderId)));
            }
          }else if(confirmOrderModel.redirectionUrl.isNotEmpty){
            isAPILoader = false;
            notifyListeners();
            Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: CheckoutPaypalView(redirectionUrl: confirmOrderModel.redirectionUrl,orderId: confirmOrderModel.orderId)));
          }
        }
        else if(!confirmOrderModel.success){
          FlushBarMessage().failedMessage(context: context, title: confirmOrderModel.errors.join("\n"));
        }
      }else if(response.statusCode == 404){
        Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0,)));
        FlushBarMessage().failedMessage(context: context, title: response.body.replaceAll('"', ''));
      }else{

        if(response1.statusCode == 200)
        {
          GetOrderCompletedResponseModel getOrderCompletedResponseModel = getOrderCompletedResponseModelFromJson(response1.body);
          if(getOrderCompletedResponseModel.orderId!=null || getOrderCompletedResponseModel.orderId!=0)
          {
            isBillingAddress = false;
            isShippingAddress = false;
            isShippingMethod = false;
            isPaymentMethod = false;
            isConfirmOrder = false;
            isPaymentInformationMethod =false;

            if(LocalResourceProvider().getSettingByName("ordersettings.disableordercompletedpage")=='True') {
              isAPILoader = false;
              notifyListeners();
              Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: OrderDetails(orderId: getOrderCompletedResponseModel.orderId)));
            }else{
              isAPILoader = false;
              notifyListeners();
              Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: OrderConfirmPage(orderId: getOrderCompletedResponseModel.orderId)));
            }

          }
        }
    }
  }
}