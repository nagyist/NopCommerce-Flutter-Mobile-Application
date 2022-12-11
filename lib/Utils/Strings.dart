/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:intl/intl.dart';

class StringConstants {

  static const String VERSION_NAME = "Version 1.3";

  static const String ERROR_MESSAGE_500 = 'Server not responding! please try again latter';
  static const String STORAGE_PERMISSION_MESSAGE = 'Allow NopSuite to access to photos, media and files on your device';
  static const String NO_INTERNET_MESSAGE = 'Please check your internet connectivity and try again!';
  static const String WISHLIST_UPDATE_MESSAGE = 'Your Wishlist is Updated';
  static const String NOT_VENDOR_MESSAGE = 'You Are Not Vendor';
  static const String INVALID_SLIDER_PRICE_MESSAGE = 'Please change prices';
  static const String PRODUCT_REVIEW_SUCCESS_MESSAGE = "Product Review Submitted";
  static const String BROWSE_BUTTON = "BROWSE";
  static const String SETTINGS_BUTTON = "Settings";
  static const String NOT_NOW_BUTTON = "Not Now";
  static const String DATE_FORMAT = "MM/dd/yyyy";
  static const String IOS_DROPDOWN_CONFIRM_BUTTON_STRING = "Confirm";
  static const String IOS_DROPDOWN_CANCEL_BUTTON_STRING = "Cancel";
  static const String ANDROID_DROPDOWN_CONFIRM_BUTTON_STRING = "Confirm";
  static const String ANDROID_DROPDOWN_CANCEL_BUTTON_STRING = "Cancel";
  static const String CONTROL_OK_BUTTON_STRING = "Ok";
  static const String CONTROL_CANCEL_BUTTON_STRING = "Cancel";
  static const String CONTROL_CLOSE_BUTTON_STRING = "Close";
  static const String ADD_TO_COMPARE='Product Successfully added into Compare Product Page';

  static const String ANDROID_DOWNLOAD_PATH = "/storage/emulated/0/Download/";
  static const String DOWNLOAD_APP_SETTINGS_MESSAGE = "Please do not close or background the application while configure data!";
  static const String API_LOADER_MESSAGE = "please wait while process is complete";
  static const String NO_FILE_SELECTED = "No file selected";
  static const String SELECTED_IMAGE = "Please Select Image";
  static const String FILTER_DRAWER_HEADER = "FILTER";
  static const String FILTER_BUTTON_STRING = "FILTER";
  static const String SORT_BUTTON_STRING = "SORT";
  static const String DOWNLOAD_STRING = "Download";
  static const String PRODUCT_DESCRIPTION = 'Product Description';
  static const String APPLY_BUTTON = 'Apply';
  static const String LICENSE_ID = 'The licenseId work remain ';
  static const String AVATAR_UPLOAD = 'Your Avatar is uploaded successfully';
  static const String SELECT_CHECKBOX = 'Please Select CheckBox';
  static const String DEFAULT_GUID = "00000000-0000-0000-0000-000000000000";

  static const String CACHE_DATABASE_NAME = "NopSuite";
  static const String CACHE_TOP_MENU = "TopMenu";
  static const String CACHE_NIVO_SLIDER = "NivoSlider";
  static const String CACHE_HOME_CATEGORY = "HomeCategory";
  static const String CACHE_HOME_PRODUCTS = "HomeProducts";
  static const String CACHE_HOME_BESTSELLER = "HomeBestSeller";
  static const String CACHE_CART_DATA = "CartData";
  static const String CACHE_CART_CROSS_SELL = "CartCrossSell";
  static const String CACHE_CART_ORDER_TOTAL = "CartOrderTotal";
  static const String CACHE_CART_ESTIMATE_SHIPPING = "CartEstimateShipping";
  static const String CACHE_TAX_TYPE = "CartTaxType";
  static const String CACHE_LANGUAGE = "Language";
  static const String CACHE_CURRENCY = "Currency";
  static const String CACHE_NAVIGATOR = "Navigator";
  static const String CACHE_HEADER = "HeaderData";
  static const String CACHE_WISHLIST = "WishList";
  static const String CACHE_USERINFO = "UserInfo";
  static const String CACHE_ADDRESS_LIST = "AddressList";
  static const String CACHE_ORDER_LIST = "OrderList";
  static const String CACHE_DOWNLOAD_PRODUCTS_LIST = "DownloadProductsList";
  static const String CACHE_BACK_IN_STOCK = "BackInStock";
  static const String CACHE_REWARD_POINT = "RewardPoint";
  static const String CACHE_AVATAR = "Avatar";
  static const String CACHE_PRODUCT_REVIEW = "ProductReview";
  static const String CACHE_PRODUCTS_BY_CATEGORY = "ProductsByCategory";
  static const String CACHE_POPULAR_TAGS = "PopularTags";
  static const String CACHE_CATALOG_ROOT = "CatalogRoot";
  static const String CACHE_MANUFACTURERS = "Manufacturers";
  static const String CACHE_PRODUCT_DETAILS = "ProductDetails";
  static const String CACHE_RELATED_PRODUCTS = "RelatedProducts";
  static const String CACHE_PRODUCT_DETAILS_REVIEW = "ProductDetailsReview";
  static const String CACHE_PRODUCT_ALSO_PURCHASE = "ProductAlsoPurchase";
  static const String CACHE_PRODUCT_BY_MANUFACTURER = "ProductByManufacturer";
  static const String CACHE_CART_TOPIC_BLOCK = "CartTopicBlock";
  static const String CACHE_CONTACTUS_TOPIC_BLOCK = "ContactUsTopicBlock";
  static const String CACHE_NEWS_LIST = "NewsList";
  static const String CACHE_NEWS_DETAILS = "NewsDetails";
  static const String CACHE_NEW_PRODUCTS = "NewProducts";
  static const String CACHE_CONTACTUS = "ContactUs";

}
DateTime now = DateTime.now();
String dateTimeName= DateFormat("yyyyMMddHms").format(now);




