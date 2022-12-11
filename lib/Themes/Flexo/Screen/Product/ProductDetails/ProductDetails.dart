/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductReview/ProductReview.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/ProductAttribute.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/AssociatedProducts.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/GiftCardInfo.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/ProductsAlsoPurchased.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/RelatedProducts.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/ProductDetailsShimmer.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/ProductPrice.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/SKU_Man_GTIN_Ven.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/RatingBar/rating_bar.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/ProductType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Components/AddToCart.dart';
import 'Components/DeliveryInfo.dart';
import 'Components/DownloadSample.dart';
import 'Components/ProductAvailability.dart';
import 'Components/ProductDetailsPictures.dart';
import 'Components/ProductEstimateShipping.dart';
import 'Components/ProductSpecifications.dart';
import 'Components/ProductTags.dart';
import 'Components/ProductTierPrices.dart';
import 'Components/RentalInfo.dart';

class FlexoProductDetails extends StatefulWidget {
  final int productId;
  final int updateId;
  final bool isCart;
  FlexoProductDetails({required this.productId,required this.updateId,required this.isCart});

  @override
  State<FlexoProductDetails> createState() => _FlexoProductDetailsState();
}

class _FlexoProductDetailsState extends State<FlexoProductDetails> {

  @override
  void initState() {
    super.initState();

    loadLocalResources();
  }
  loadLocalResources() async
  {
    context.read<LocalResourceProvider>().loadLocalResources();
    if(await CheckConnectivity().checkInternet(context))
    {
      context.read<ProductDetailsProvider>().loadCacheData(context: context,productId: widget.productId,updateId: widget.updateId,isCart: widget.isCart);

    }
    loadData(context: context);
  }

  loadData({required BuildContext context}) async
  {
    context.read<ProductDetailsProvider>().pageLoadData(context: context,productId: widget.productId,updateId: widget.updateId,isCart: widget.isCart);
  }

  getRating(int ratingSum, totalReviews)
  {
    return ((((ratingSum * 100)/totalReviews)/5)/20);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppSettingsProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().searchableAppbar(context: context,backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: productDetailsProvider.headerModel,headerLoader: productDetailsProvider.isPageLoader),
        body: productDetailsProvider.isPageLoader ? SingleChildScrollView(child: ProductDetailsShimmer().getView(),):
        Column(
          children: [

            productDetailsProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      ///Product Top Data
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: Column(
                          children: [
                            SizedBox(height: FlexoValues.widthSpace2Px,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: FlexoTextWidget().headingBoldText17(text: productDetailsProvider.getProductDetailsModel.name,),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),

                            productDetailsProvider.getProductDetailsModel.productType == ProductType.SimpleProduct ?
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  productDetailsProvider.getProductDetailsModel.showSku && productDetailsProvider.getProductDetailsModel.sku != null?
                                  Container(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: FlexoTextWidget().headingBoldText15(text: '${localResourceProvider.getResourseByKey("products.sku")}: ',),
                                          ),
                                          Container(
                                            child: FlexoTextWidget().contentText15(text: productDetailsProvider.getProductDetailsModel.sku,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ):Container(),

                                  SizedBox(height: FlexoValues.heightSpace1Px,),

                                ],
                              ),
                            ) : Container(),

                            Container(
                              child: Column(
                                children: [
                                  productDetailsProvider.getProductDetailsModel.productReviewOverview.allowCustomerReviews?
                                  productDetailsProvider.getProductReviewsModel.items.isEmpty?
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        Navigator.push(context, PageTransition(type: selectedTransition, child: ProductReview(productReviewOverview: productDetailsProvider.getProductDetailsModel.productReviewOverview))).then((value)
                                        {
                                          setState(()
                                          {
                                            productDetailsProvider.getProductDetails(context: context);
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      width: FlexoValues.controlsWidth,
                                      child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey('reviews.overview.first'),),
                                    ),
                                  ):
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        Navigator.push(context, PageTransition(type: selectedTransition, child: ProductReview(productReviewOverview: productDetailsProvider.getProductDetailsModel.productReviewOverview))).then((value)
                                        {
                                          setState(()
                                          {
                                            productDetailsProvider.getProductDetails(context: context);
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      width: FlexoValues.controlsWidth,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          RatingBar.builder(
                                            initialRating: getRating(productDetailsProvider.getProductDetailsModel.productReviewOverview.ratingSum, productDetailsProvider.getProductDetailsModel.productReviewOverview.totalReviews),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: FlexoValues.fontSize18,
                                            ignoreGestures: true,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: FlexoColorConstants.PRODUCT_RATING_COLOR,
                                            ),
                                            onRatingUpdate: (rating) {

                                            },
                                          ),

                                          SizedBox(width: FlexoValues.widthSpace2Px,),

                                          Container(
                                            child: FlexoTextWidget().redirectText16(text: "${productDetailsProvider.getProductDetailsModel.productReviewOverview.totalReviews} "+localResourceProvider.getResourseByKey("reviews.overview.reviews"),),
                                          ),

                                          productDetailsProvider.getProductReviewsModel.addProductReview.canAddNewReview?
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                                                      height: FlexoValues.heightSpace2Px,
                                                      child: VerticalDivider(thickness: 1.0,color: FlexoColorConstants.HIGHLIGHT_COLOR,width: FlexoValues.widthSpace1Px,)
                                                  ),

                                                  Expanded(
                                                    child: Container(
                                                      child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey('reviews.overview.addNew'),maxLines: 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):Container()
                                        ],
                                      ),
                                    ),
                                  ):Container(),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.heightSpace1Px,),

                            Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,height: 1,),
                          ],
                        ),
                      ),

                      ProductDetailsPictures().getView(context: context),

                      Divider(thickness: 1,color: FlexoColorConstants.LIST_BORDER_COLOR,),

                      productDetailsProvider.getProductDetailsModel.displayDiscontinuedMessage?
                      Container(
                        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                        child: Container(
                          width: FlexoValues.controlsWidth,
                          margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                          alignment: Alignment.topLeft,
                          child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("products.discontinued"),),
                        ),
                      ):Container(),

                      SizedBox(height: FlexoValues.widthSpace2Px),

                      productDetailsProvider.getProductDetailsModel.shortDescription == null || productDetailsProvider.getProductDetailsModel.shortDescription == '' ? Container() :
                      Column(
                        children: [

                          StatefulBuilder(builder: (context, setState){
                            return Container(
                              width: FlexoValues.deviceWidth,
                              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: HTML.toTextSpan(
                                    context,
                                    '${productDetailsProvider.getProductDetailsModel.shortDescription}',
                                    defaultTextStyle: TextStyleWidget.contentTextStyle16,
                                    linksCallback: (url)
                                    {
                                      launch(url!);
                                    }
                                ),
                              ),
                            );
                          }),

                          SizedBox(height: FlexoValues.heightSpace2Px),
                        ],
                      ),

                      productDetailsProvider.getProductDetailsModel.productManufacturers.isEmpty ? Container() :
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FlexoTextWidget().headingBoldText15(text: '${localResourceProvider.getResourseByKey("products.manufacturer")}: ',),
                                ),

                                Flexible(
                                  child: Container(
                                      child: Wrap(
                                        children: productDetailsProvider.getProductDetailsModel.productManufacturers.map((e){

                                          return FlexoTextWidget().contentText15(text: productDetailsProvider.getProductDetailsModel.productManufacturers.indexOf(e)!=productDetailsProvider.getProductDetailsModel.productManufacturers.length-1? '${e.name}, ':e.name,);

                                        }).toList(),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: FlexoValues.widthSpace2Px),
                        ],
                      ),

                      productDetailsProvider.getProductDetailsModel.productType == ProductType.SimpleProduct ?
                      Container(
                        child: Column(
                          children: [

                            ProductAvailability().getView(context: context,getProductDetailsModel: productDetailsProvider.getProductDetailsModel),

                            SKUManGTINVen().getView(context: context,getProductDetailsModel: productDetailsProvider.getProductDetailsModel,isSimple: true),

                            DeliveryInfo().getView(context: context,getProductDetailsModel: productDetailsProvider.getProductDetailsModel),

                            DownloadSample().getView(context: context,getProductDetailsModel: productDetailsProvider.getProductDetailsModel),

                            FlexoProductAttribute(getProductDetailsModel: productDetailsProvider.getProductDetailsModel),

                            GiftCardInfo().getView(context: context,giftCard: productDetailsProvider.getProductDetailsModel.giftCard),

                            RentalInfo().getView(context: context,getProductDetailsModel: productDetailsProvider.getProductDetailsModel),

                            ProductPriceWidget().getView(context: context,productPrice: productDetailsProvider.getProductDetailsModel.productPrice),

                            ProductTierPrices().getView(context: context,tierPrices: productDetailsProvider.getProductDetailsModel.tierPrices),

                            AddToCartWidget().getView(context: context,getProductDetailsModel: productDetailsProvider.getProductDetailsModel,isCart: productDetailsProvider.isCart),

                            !productDetailsProvider.isEstimateLoad ? Container() :
                            ProductEstimateShipping().getView(context: context,getProductDetailsModel: productDetailsProvider.getProductDetailsModel,estimateShippingMap: productDetailsProvider.estimateShippingMap,productEstimateShippingModel: productDetailsProvider.productEstimateShippingModelMap[productDetailsProvider.getProductDetailsModel.id]!),
                          ],
                        ),
                      ) : Container(),

                      productDetailsProvider.getProductDetailsModel.fullDescription == null ? Container() :
                      Column(
                        children: [

                          productDetailsProvider.getProductDetailsModel.associatedProducts.isNotEmpty? Container():Divider(thickness: 1,color: FlexoColorConstants.LIST_BORDER_COLOR,),

                          Container(
                            width: FlexoValues.deviceWidth,
                            margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                            child: FlexoTextWidget().headingBoldText16(text: StringConstants.PRODUCT_DESCRIPTION,),
                          ),

                          SizedBox(height: FlexoValues.heightSpace1Px,),

                          Container(
                            width: FlexoValues.deviceWidth,
                            margin: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                            child: HtmlWidget(
                              '${productDetailsProvider.getProductDetailsModel.fullDescription.replaceAll("/images/uploaded", APIConstants.BASE_URL+"images/uploaded")}',
                              textStyle: TextStyleWidget.contentTextStyle16,
                              onTapUrl: (url)=> launch(url),
                            ),
                          ),

                          SizedBox(height: FlexoValues.heightSpace1Px,)
                        ],
                      ),

                      AssociatedProducts().getView(context: context),

                      ProductSpecifications().getView(context: context),

                      ProductTags().getView(context: context),

                      productDetailsProvider.getProductDetailsModel.productType == ProductType.SimpleProduct ?
                        productDetailsProvider.getProductsAlsoPurchasedModel.isNotEmpty ?
                        ProductsAlsoPurchased().getView(context: context,loadData: loadData):
                        Container():
                      Container(),

                      productDetailsProvider.getRelatedProductsModel.isNotEmpty ?
                      RelatedProducts().getView(context: context,loadData: loadData):
                      Container(),

                    ],
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


class ImageSelection{
  int id;
  String imgUrl;
  ImageSelection(this.id,this.imgUrl);
}