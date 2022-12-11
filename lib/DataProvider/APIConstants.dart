/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


class APIConstants {
  static const String STORE_KEY = 'Your StoreKey/AppKey here';
  static const String BASE_URL = 'Your URL here';

  static const String WISHLIST_SHARE_BASEURL = BASE_URL + "wishlist/";

  static const String GET_LOCAL_STRING_RESOURCES_API = 'api/PublicGeneral/GetLocaleStringResources';
  static const String GET_PING_API = 'api/PublicGeneral/Ping';
  static const String GET_SETTING_API = 'api/PublicGeneral/GetSettings';
  static const String GET_STORE_ID_API = 'api/PublicCommon/GetStoreId';
  static const String LOGOUT_API = 'api/PublicCustomer/Logout';
  static const String GET_USER_INFO_API = 'api/PublicCustomer/GetInfo';
  static const String PUT_USER_INFO_API = 'api/PublicCustomer/UpdateInfo';
  static const String POST_LOGIN_API = 'api/PublicCustomer/Login';
  static const String GET_LOGIN_API = 'api/PublicCustomer/GetLogin';
  static const String GET_REGISTER_API = 'api/PublicCustomer/GetRegister';
  static const String POST_REGISTER_API = 'api/PublicCustomer/Register';
  static const String CHECK_REGISTER_API = 'api/PublicCustomer/CheckUsernameAvailability';
  static const String GET_STATE_API = 'api/PublicCommon/GetStates';
  static const String GET_CUSTOMER_PROFILE_API = 'api/PublicForum/GetCustomerProfile';
  static const String GET_CHANGE_PASSWORD = "api/PublicCustomer/ChangePassword";
  static const String FORGET_PASSWORD_API = "api/PublicCustomer/PasswordRecovery";
  static const String GIFT_CARD_BALANCE_API = "api/PublicCustomer/GetCheckGiftCardBalance";
  static const String APPLY_GIFT_CARD_BALANCE_API = "api/PublicCustomer/CheckGiftCardBalance";
  static const String GET_LANGUAGE_API = "api/PublicCommon/GetLanguages";
  static const String SET_LANGUAGE_API = "api/PublicCommon/SetLanguage";
  static const String GET_CURRENCY_API = "api/PublicCommon/GetCurrencies";
  static const String SET_CURRENCY_API = "api/PublicCommon/SetCurrency";
  static const String NAVIGATION_API = 'api/PublicCustomer/GetCustomerNavigation';
  static const String GET_TAX_TYPE_API = "api/PublicCommon/GetTaxTypes";
  static const String SET_TAX_TYPE_API = "api/PublicCommon/SetTaxType";
  static const String GET_HOME_PAGE_CATEGORIES_API = 'api/PublicCategory/GetHomepageCategories';
  static const String GET_HOME_PAGE_POLLS_API = "api/PublicGeneral/GetHomepagePolls";
  static const String POST_HOME_PAGE_POLLS_API = "api/PublicGeneral/PollsVote";
  static const String GET_NIVO_SLIDER_API = "api/PublicGeneral/GetNivoSlider";
  static const String GET_HEADER_INFO_API = "api/PublicGeneral/GetHeaderInfo";
  static const String GET_FOOTER_INFO_API = "api/PublicGeneral/GetFooterInfo";
  static const String GET_TOPIC_BLOCK_API = "api/PublicGeneral/GetTopic";
  static const String GET_TOPIC_BLOCK_BY_ID_API = "api/PublicGeneral/GetTopic";
  static const String GET_TOP_MENU_API = "api/PublicCategory/GetTopMenu";
  static const String GET_CATALOG_ROOT_API = "api/PublicCategory/GetRootCategories";
  static const String GET_CATALOG_PRODUCTS_API = "api/PublicCategory/GetCategory";
  static const String GET_CATALOG_SUB_CATEGORIES_API = "api/PublicCategory/GetCatalogSubCategories";
  static const String GET_CUSTOMER_ORDERS_API = "api/PublicOrder/GetCustomerOrders";
  static const String GET_ORDER_DETAILS_API = "api/PublicOrder/GetOrderDetails";
  static const String REPAYMENT_DETAILS_API = "api/PublicOrder/RetryPayment";
  static const String CANCEL_RECURRING_PAYMENT_API = "api/PublicOrder/CancelRecurringPayment";
  static const String RETRY_LAST_RECURRING_PAYMENT_API = 'api/PublicOrder/RetryLastRecurringPayment';
  static const String SET_ORDER_API = "api/PublicOrder/ReOrder";
  static const String GET_PDF_INVOICE_API = 'api/PublicOrder/GetPdfInvoice';
  static const String GET_SHIPMENT_DETAILS_API = "api/PublicOrder/GetShipmentDetails";
  static const String GET_ORDER_NOTE_FILE_API = 'api/PublicDownload/GetOrderNoteFile';
  static const String REFRESH_TOKEN_API = "api/PublicCustomer/RefreshToken";
  static const String GUEST_TOKEN_API = "api/PublicCustomer/GetGuestToken";
  static const String GET_ALL_ADDRESSES_API = "api/PublicCustomer/GetAddresses";
  static const String GET_ADDRESS_BY_ID_API = "api/PublicCustomer/GetAddress";
  static const String UPDATE_ADDRESS_API = "api/PublicCustomer/UpdateAddress";
  static const String DELETE_ADDRESS_API = 'api/PublicCustomer/DeleteAddress';
  static const String GET_ADD_ADDRESS_API = 'api/PublicCustomer/GetAddAddress';
  static const String POST_ADD_ADDRESS_API = 'api/PublicCustomer/AddAddress';
  static const String ADDRESS_ATTRIBUTES_API = 'api/PublicCommon/GetAddressAttributes';
  static const String GET_DOWNLOADABLE_PRODUCT_API = "api/PublicCustomer/GetDownloadableProducts";
  static const String GET_DOWNLOADABLE_PRODUCT_DETAILS_API = 'api/PublicDownload/GetDownloadableProduct';
  static const String GET_ORDER_ITEM_LICENSE_API = 'api/PublicDownload/GetOrderItemLicense';
  static const String GET_SAMPLE_PRODUCT_DETAILS_API = 'api/PublicDownload/GetProductSample';
  static const String GET_WISH_LIST_API = "api/PublicShoppingCart/GetWishlist";
  static const String GET_CART_API = "api/PublicShoppingCart/GetCart";
  static const String GET_CART_ORDER_TOTAL_API = "api/PublicShoppingCart/GetOrderTotals";
  static const String GET_CROSS_SELL_PRODUCT_API = "api/PublicProduct/GetCrossSellProducts";
  static const String UPDATE_CART_QUANTITY_API = "api/PublicShoppingCart/UpdateCartItemsQuantity";
  static const String REMOVE_CART_ITEM_API = "api/PublicShoppingCart/DeleteCartItems";
  static const String POST_CART_CHANGE_ATTRIBUTE_API = "api/PublicShoppingCart/ChangeCheckoutAttribute";
  static const String POST_CART_UPLOAD_FILE_ATTRIBUTE_API = "api/PublicShoppingCart/UploadFileCheckoutAttribute";
  static const String PRODUCT_UPLOAD_FILE_ATTRIBUTE_API = "api/PublicShoppingCart/UploadFileProductAttribute";
  static const String START_CHECKOUT_API = "api/PublicShoppingCart/StartCheckout";
  static const String CART_ESTIMATE_SHIPPING_API = "api/PublicShoppingCart/GetEstimateShipping";
  static const String CART_POST_ESTIMATE_SHIPPING_API = "api/PublicShoppingCart/EstimateShipping";
  static const String SELECT_SHIPPING_OPTION_API = "api/PublicShoppingCart/SelectShippingOption";
  static const String GET_DISCOUNT_COUPON_API = "api/PublicShoppingCart/ApplyDiscountCoupon";
  static const String DELETE_DISCOUNT_COUPON_API = "api/PublicShoppingCart/RemoveDiscountCoupon";
  static const String GET_GIFT_CARD_COUPON_API = "api/PublicShoppingCart/ApplyGiftCard";
  static const String DELETE_GIFT_CARD_COUPON_API = "api/PublicShoppingCart/RemoveGiftCardCode";
  static const String POST_IMPERSONATE_API = "api/PublicCustomer/Impersonate";
  static const String STOP_IMPERSONATION_API = "api/PublicCustomer/StopImpersonation";
  static const String DELETE_WISHLIST_ITEMS_API = 'api/PublicShoppingCart/DeleteWishlistItems';
  static const String UPDATE_WISHLIST_ITEMS_QUANTITY_API = 'api/PublicShoppingCart/UpdateWishlistItemsQuantity';
  static const String ADD_ITEMS_TO_CART_FROM_WISHLIST_API = 'api/PublicShoppingCart/MoveWishlistItemsToCart';
  static const String EMAIL_WISHLIST_API = 'api/PublicShoppingCart/EmailWishlist';
  static const String GET_EMAIL_WISHLIST_API = 'api/PublicShoppingCart/GetEmailWishlist';
  static const String GET_HOME_PAGE_BEST_SELLERS_API = "api/PublicProduct/GetBestSellers";
  static const String GET_HOME_PAGE_PRODUCTS_API = "api/PublicProduct/GetHomepageProducts";
  static const String PRODUCT_DETAILS_ATTRIBUTE_CHANGE_API = 'api/PublicProduct/ChangeProductAttribute';
  static const String PRODUCT_EMAIL_A_FRIEND_API = 'api/PublicProduct/ProductEmailAFriend';
  static const String GET_PRODUCT_EMAIL_A_FRIEND_API = 'api/PublicProduct/GetProductEmailAFriend';
  static const String PRODUCT_DETAILS_API = 'api/PublicProduct/GetProductDetails';
  static const String RELATED_PRODUCT_API = 'api/PublicProduct/GetRelatedProducts';
  static const String ALSO_PURCHASED_PRODUCT_API = 'api/PublicProduct/GetProductsAlsoPurchased';
  static const String GET_SUBSCRIBE_API = 'api/PublicBackInStockSubscription/GetSubscribe';
  static const String GET_PRODUCT_BY_CATEGORIES_API = 'api/PublicProduct/GetProductsByCategory';
  static const String PRODUCT_ESTIMATE_SHIPPING_API = "api/PublicProduct/EstimateShipping";
  static const String GET_PRODUCT_REVIEWS_API = 'api/PublicProduct/GetProductReviews';
  static const String SET_PRODUCT_REVIEW_HELPFULNESS_API = 'api/PublicProduct/SetProductReviewHelpfulness';
  static const String ADD_PRODUCT_REVIEWS_API = 'api/PublicProduct/AddProductReviews';
  static const String GET_RECENTLY_VIEWED_PRODUCTS_API = "api/PublicProduct/GetRecentlyViewedProducts";
  static const String GET_NEW_PRODUCT_API = "api/PublicProduct/GetNewProducts";
  static const String GET_PRODUCT_BY_TAG_API = 'api/PublicProduct/GetTagProducts';
  static const String GET_POPULAR_PRODUCT_TAGS_API = 'api/PublicProduct/GetPopularProductTags';
  static const String GET_BLOG_TAGS_API = 'api/PublicBlog/GetBlogTags';
  static const String GET_BLOGS_API = 'api/PublicBlog/GetBlogs';
  static const String GET_BLOG_MONTHS_API = 'api/PublicBlog/GetBlogMonths';
  static const String GET_BLOG_DETAILS_API = 'api/PublicBlog/GetBlogPost';
  static const String ADD_BLOG_COMMENT_API = 'api/PublicBlog/AddBlogComment';
  static const String CONTACTUS_API = "api/PublicGeneral/ContactUs";
  static const String GET_CONTACTUS_API = "api/PublicGeneral/GetContactUs";
  static const String SET_ADD_TO_CART_API = 'api/PublicShoppingCart/AddToCart';
  static const String SET_ADD_TO_WISHLIST_API = 'api/PublicShoppingCart/AddToWishlist';
  static const String GET_VENDOR_API = "api/PublicVendor/GetApplyVendor";
  static const String GET_VENDOR_ATTRIBUTES_API = "api/PublicVendor/GetVendorAttributes";
  static const String GET_VENDOR_INFO_API = "api/PublicVendor/GetInfo";
  static const String VENDOR_UPDATE_INFO_API = "api/PublicVendor/UpdateInfo";
  static const String DELETE_VENDOR_PICTURE_API = "api/PublicVendor/DeletePicture";
  static const String GET_APPLY_VENDOR_API = "api/PublicVendor/GetApplyVendor";
  static const String APPLY_VENDOR_API = "api/PublicVendor/ApplyVendor";
  static const String GET_ALL_VENDOR_API = "api/PublicVendor/GetVendors";
  static const String GET_VENDOR_BY_ID_API = "api/PublicVendor/GetVendor";
  static const String GET_VENDOR_PRODUCTS_BY_ID_API = "api/PublicVendor/GetVendorProducts";
  static const String GET_CONTACT_VENDOR_API = "api/PublicGeneral/GetContactVendor";
  static const String CONTACT_VENDOR_API = "api/PublicGeneral/ContactVendor";
  static const String BILLING_ADDRESSES_API = "api/PublicCheckout/GetBillingAddresses";
  static const String SHIPPING_ADDRESSES_API = "api/PublicCheckout/GetShippingAddresses";
  static const String SHIPPING_METHODS_API = "api/PublicCheckout/GetShippingMethods";
  static const String SELECT_SHIPPING_METHODS_API = "api/PublicCheckout/SelectShippingMethod";
  static const String SELECT_BILLING_ADDRESS_API = "api/PublicCheckout/SelectBillingAddress";
  static const String SELECT_SHIPPING_ADDRESS_API = "api/PublicCheckout/SelectShippingAddress";
  static const String ADD_BILLING_ADDRESS_API = "api/PublicCheckout/AddBillingAddress";
  static const String ADD_SHIPPING_ADDRESS_API = "api/PublicCheckout/AddShippingAddress";
  static const String PICKUP_POINT_API = "api/PublicCheckout/GetPickupPoints";
  static const String PAYMENT_METHODS_API = "api/PublicCheckout/GetPaymentMethods";
  static const String PAYMENT_INFO_API = "api/PublicCheckout/GetPaymentInfo";
  static const String ORDER_SUMMARY_API = "api/PublicCheckout/GetOrderSummary";
  static const String SELECT_PAYMENT_METHODS_API = "api/PublicCheckout/SelectPaymentMethod";
  static const String VALIDATION_PAYMENT_API = "api/PublicCheckout/ValidatePaymentInfo";
  static const String CONFIRM_ORDER_API = "api/PublicCheckout/ConfirmOrder";
  static const String GET_COMPLETE_ORDER = "api/PublicCheckout/GetOrderCompleted";
  static const String NEWSLETTER_API = "api/PublicGeneral/SubscribeNewsletter";
  static const String GET_SUBSCRIBE_NEWSLETTER_API = "api/PublicGeneral/GetSubscribeNewsletter";
  static const String MANUFACTURE_API = 'api/PublicManufacturer/GetManufacturers';
  static const String GET_PRODUCT_BY_MANUFACTURE_API = 'api/PublicManufacturer/GetManufacturer';
  static const String PRODUCT_BY_MANUFACTURE_API = 'api/PublicManufacturer/GetManufacture';
  static const String GET_SEARCH_TERM_API = "api/PublicSearch/GetSearchTermAutoComplete";
  static const String GET_SEARCH_PRODUCTS_API = "api/PublicSearch/SearchProducts";
  static const String SEARCH_PRODUCTS_API = "api/PublicSearch/GetSearch";
  static const String GET_COUNTRY_API = "api/PublicCommon/GetCountries";
  static const String GET_TIME_ZONE_API = "api/PublicCommon/GetTimeZones";
  static const String GET_GTPR_CONSENTS_API = "api/PublicCustomer/GetGdprTools";
  static const String GET_CUSTOMER_ATTRIBUTES_API = "api/PublicCustomer/GetCustomerAttributes";
  static const String GET_MY_PRODUCT_REVIEW_API = 'api/PublicProduct/GetCustomerProductReviews';
  static const String DELETE_GDPR_TOOL_API = 'api/PublicCustomer/DeleteGdprTools';
  static const String EXPORT_GDPR_TOOL_API = 'api/PublicCustomer/ExportGdprTools';
  static const String GET_FORUM_GROUP_API = 'api/PublicForum/GetForums';
  static const String GET_FORUM_ACTIVE_DISCUSSION_SMALL_API = 'api/PublicForum/GetActiveDiscussionsSmall';
  static const String GET_FORUM_ACTIVE_DISCUSSION_API = 'api/PublicForum/GetActiveDiscussions';
  static const String GET_FORUM_SEARCH_API = 'api/PublicForum/SearchForum';
  static const String GET_FORUM_BY_GROUP_ID_API = 'api/PublicForum/GetForumGroup';
  static const String GET_FORUM_DETAILS_API = 'api/PublicForum/GetForum';
  static const String POST_WATCH_FORUM_API = 'api/PublicForum/WatchForum';
  static const String GET_FORUM_TOPIC_API = 'api/PublicForum/GetTopic';
  static const String GET_FORUM_TOPIC_CREATE_API = 'api/PublicForum/GetCreateTopic';
  static const String GET_FORUM_TOPIC_UPDATE_API = 'api/PublicForum/GetUpdateTopic';
  static const String POST_FORUM_TOPIC_CREATE_API = 'api/PublicForum/CreateTopic';
  static const String POST_FORUM_TOPIC_UPDATE_API = 'api/PublicForum/UpdateTopic';
  static const String POST_FORUM_TOPIC_POST_VOTE_API = 'api/PublicForum/VotePost';
  static const String DELETE_FORUM_TOPIC_API = 'api/PublicForum/DeleteTopic';
  static const String POST_FORUM_WATCH_TOPIC_API = 'api/PublicForum/WatchTopic';
  static const String GET_FORUM_MOVE_TOPIC_API = 'api/PublicForum/GetMoveTopic';
  static const String POST_FORUM_MOVE_TOPIC_API = 'api/PublicForum/MoveTopic';
  static const String GET_CREATE_POST_API = 'api/PublicForum/GetCreatePost';
  static const String GET_UPDATE_POST_API = 'api/PublicForum/GetUpdatePost';
  static const String POST_CREATE_POST_API = 'api/PublicForum/CreatePost';
  static const String POST_UPDATE_POST_API = 'api/PublicForum/UpdatePost';
  static const String DELETE_POST_API = 'api/PublicForum/DeletePost';
  static const String DELETE_SUBSCRIPTION_API = 'api/PublicForum/DeleteCustomerForumSubscriptions';
  static const String GET_FORUM_SUBSCRIPTION_API = 'api/PublicForum/GetCustomerForumSubscriptions';
  static const String GET_CUSTOMER_SUBSCRIPTION_API = 'api/PublicBackInStockSubscription/GetCustomerSubscriptions';
  static const String ADD_SUBSCRIPTION_API = 'api/PublicBackInStockSubscription/Subscribe';
  static const String REMOVE_SUBSCRIPTION_API = 'api/PublicBackInStockSubscription/RemoveCustomerSubscriptions';
  static const String GET_HOME_PAGE_NEWS_API = "api/PublicNews/GetHomepageNews";
  static const String GET_ALL_NEWS_API = "api/PublicNews/GetAllNews";
  static const String GET_NEWS_DETAILS_API = "api/PublicNews/GetNewsItem";
  static const String ADD_NEWS_COMMENT_API = "api/PublicNews/AddNewsComment";
  static const String GET_CUSTOMER_RETURN_REQUEST_API = "api/PublicReturnRequest/GetCustomerReturnRequests";
  static const String GET_CUSTOMER_REWARD_POINTS_API = "api/PublicOrder/GetCustomerRewardPoints";
  static const String GET_RETURN_REQUEST_API = "api/PublicReturnRequest/GetReturnRequest";
  static const String RETURN_REQUEST_API = "api/PublicReturnRequest/ReturnRequest";
  static const String UPLOAD_FILE_RETURN_REQUEST_API = "api/PublicReturnRequest/UploadFileReturnRequest";
  static const String DOWNLOAD_PDF_API = "api/PublicDownload/GetFileUpload";
  static const String GET_INBOX_MESSAGE_API = 'api/PublicPrivateMessages/GetInboxMessages';
  static const String GET_SENT_MESSAGE_API = 'api/PublicPrivateMessages/GetSentMessages';
  static const String GET_MESSAGE_DETAILS_API = 'api/PublicPrivateMessages/GetMessage';
  static const String DELETE_INBOX_MESSAGE_API = 'api/PublicPrivateMessages/DeleteInboxMessages';
  static const String DELETE_SENT_MESSAGE_API = 'api/PublicPrivateMessages/DeleteSentMessages';
  static const String POST_REPLY_MESSAGE_API = 'api/PublicPrivateMessages/SendMessage';
  static const String GET_REPLY_MESSAGE_API = 'api/PublicPrivateMessages/GetSendMessage';
  static const String DELETE_PM_DETAIL_MESSAGE_API = 'api/PublicPrivateMessages/DeleteMessage';
  static const String PUT_PM_UNREAD_MESSAGE_API = 'api/PublicPrivateMessages/MarkAsUnread';
  static const String GET_AVATAR_API = 'api/PublicCustomer/GetAvatar';
  static const String UPLOAD_AVATAR_API = 'api/PublicCustomer/UploadAvatar';
  static const String DELETE_AVATAR_API = 'api/PublicCustomer/DeleteAvatar';
  static const String FIREBASE_REGISTER_USER_API = 'api/PushNotification/RegisterClient';
  static const String USER_AGREEMENT_API = 'api/PublicCustomer/GetUserAgreement';

}