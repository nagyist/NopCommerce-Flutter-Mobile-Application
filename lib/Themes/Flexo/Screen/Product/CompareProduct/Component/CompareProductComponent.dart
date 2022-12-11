/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/CompareProduct/CompareProductProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class CompareProductComponent{

  getCompareProductComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var compareProductProvider = context.watch<CompareProductProvider>();
    final _scrollController = ScrollController();

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Container(
          child: Column(
            children: [

              SizedBox(height: FlexoValues.heightSpace2Px),

              Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    ButtonWidget().getButton(
                        text: localResourceProvider.getResourseByKey("products.compare.clear").toString().toUpperCase(),
                        width: FlexoValues.deviceWidth * 0.3,
                        onClick: ()
                        {
                          compareProductProvider.deleteAllProduct(context: context);
                        },
                        isApiLoad: false
                    ),
                  ],
                ),
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),

              Container(
                width: FlexoValues.deviceWidth,
                alignment: Alignment.centerLeft,
                child: Scrollbar(
                  isAlwaysShown: true,
                  showTrackOnHover: true,
                  interactive: true,
                  thickness: compareProductProvider.compareProductDetailsList.length == 1 ? 0 : 4,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: FlexoColorConstants.LIST_BORDER_COLOR
                                ),
                              ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.controlsHeight,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  right: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  left: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                )
                                            ),
                                          ),

                                          Container(
                                            child: Row(
                                              children: compareProductProvider.compareProductDetailsList.map((product)
                                              {
                                                return Container(
                                                  width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                  height: FlexoValues.controlsHeight,
                                                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          ),
                                                          right: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          )
                                                      )
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        compareProductProvider.deleteProductById(context: context,productId: product.id);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            child: Icon(
                                                              Ionicons.trash_outline,
                                                              color: FlexoColorConstants.THEME_COLOR,
                                                              size: FlexoValues.iconSize20,
                                                            ),
                                                          ),

                                                          SizedBox(width: FlexoValues.widthSpace2Px),

                                                          Container(
                                                            alignment: Alignment.centerLeft,
                                                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("Common.Remove"),),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.deviceHeight * 0.2,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  right: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  left: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                )
                                            ),
                                          ),

                                          Container(
                                            child: Row(
                                              children: compareProductProvider.compareProductDetailsList.map((product)
                                              {
                                                return Container(
                                                  width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                  height: FlexoValues.deviceHeight * 0.2,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          ),
                                                          right: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          )
                                                      )
                                                  ),
                                                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                  alignment: Alignment.center,
                                                  child: GestureDetector(
                                                    onTap: ()
                                                    {
                                                      Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: product.id,updateId: 0,isCart: false))).then((value)
                                                      {
                                                          compareProductProvider.getHeaderData(context: context);
                                                      });
                                                    },
                                                    child: CachedNetworkImage(imageUrl: product.defaultPictureModel.imageUrl),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.deviceHeight * 0.1,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  right: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  left: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                )
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("Products.Compare.Name"),),
                                          ),

                                          Container(
                                            child: Row(
                                              children: compareProductProvider.compareProductDetailsList.map((product)
                                              {
                                                return Container(
                                                  width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                  height: FlexoValues.deviceHeight * 0.1,
                                                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          ),
                                                          right: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          )
                                                      )
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    onTap: ()
                                                    {
                                                      Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: product.id,updateId: 0,isCart: false))).then((value)
                                                      {
                                                          compareProductProvider.getHeaderData(context: context);
                                                      });
                                                    },
                                                    child: FlexoTextWidget().headingBoldText15(text: product.name,),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.deviceHeight * 0.1,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  right: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  left: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                )
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("Products.Compare.Price"),),
                                          ),

                                          Container(
                                            child: Row(
                                              children: compareProductProvider.compareProductDetailsList.map((product)
                                              {
                                                return Container(
                                                  width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                  height: FlexoValues.deviceHeight * 0.1,
                                                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          ),
                                                          right: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          )
                                                      )
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                  child: FlexoTextWidget().headingText16(text: product.productPrice.isRental ? product.productPrice.rentalPrice : product.productPrice.price == null ? "" : "${product.productPrice.price}",),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    localResourceProvider.getSettingByName("catalogSettings.includeShortDescriptionInCompareProducts") == "True" ?
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.deviceHeight * 0.2,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  right: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  left: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                )
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("Products.Compare.ShortDescription"),),
                                          ),

                                          Container(
                                            child: Row(
                                              children: compareProductProvider.compareProductDetailsList.map((product)
                                              {
                                                return Container(
                                                  width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                  height: FlexoValues.deviceHeight * 0.2,
                                                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          ),
                                                          right: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          )
                                                      )
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                  child: RichText(
                                                    textAlign: TextAlign.start,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                    text: HTML.toTextSpan(
                                                        context,
                                                        '${product.shortDescription}',
                                                        defaultTextStyle: TextStyle(
                                                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                          fontSize: 16,
                                                        ),
                                                        linksCallback: (url)
                                                        {
                                                          launch(url!);
                                                        }
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ) : Container(),

                                    localResourceProvider.getSettingByName("catalogSettings.includeFullDescriptionInCompareProducts") == "True" ?
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.deviceHeight * 0.2,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  right: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                  left: BorderSide(
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                  ),
                                                )
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("Products.Compare.FullDescription"),),
                                          ),

                                          Container(
                                            child: Row(
                                              children: compareProductProvider.compareProductDetailsList.map((product)
                                              {
                                                return Container(
                                                  width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                  height: FlexoValues.deviceHeight * 0.2,
                                                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          ),
                                                          right: BorderSide(
                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                          )
                                                      )
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                  child: RichText(
                                                    maxLines: 6,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    text: HTML.toTextSpan(
                                                        context,
                                                        '${product.fullDescription}',
                                                        defaultTextStyle: TextStyle(
                                                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                          fontSize: 16,
                                                        ),
                                                        linksCallback: (url)
                                                        {
                                                          launch(url!);
                                                        }
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ) : Container(),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: compareProductProvider.uniqueGroups.map((group)
                                        {
                                          compareProductProvider.uniqueGroupAttributes=[];
                                          if(group.attributes.length > 0 )
                                          {
                                            for(var productData in compareProductProvider.compareProductDetailsList)
                                            {
                                              for(var group in productData.productSpecificationModel.groups.where((g) => g.id == group.id))
                                              {
                                                for(var attribute in group.attributes)
                                                {
                                                  if (!compareProductProvider.uniqueGroupAttributes.any((sa) => sa.id == attribute.id)) {
                                                    compareProductProvider.uniqueGroupAttributes.add(attribute);
                                                  }
                                                }

                                              }
                                            }

                                            return Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  group.id > 0 ?
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: FlexoValues.deviceWidth * 0.3,
                                                          height: FlexoValues.deviceHeight * 0.1,
                                                          padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                bottom: BorderSide(
                                                                    color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                ),
                                                              )
                                                          ),
                                                          alignment: Alignment.centerLeft,
                                                          child: FlexoTextWidget().headingBoldText15(text: "${group.name}",),
                                                        ),

                                                        Container(
                                                          child: Row(
                                                            children: compareProductProvider.compareProductDetailsList.map((product)
                                                            {
                                                              return Container(
                                                                width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                                height: FlexoValues.deviceHeight * 0.1,
                                                                padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                                decoration: BoxDecoration(
                                                                    border: Border(
                                                                      bottom: BorderSide(
                                                                          color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                      ),
                                                                    )
                                                                ),
                                                                alignment: Alignment.centerLeft,
                                                              );
                                                            }).toList(),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ) :
                                                  Container(),

                                                  compareProductProvider.uniqueGroupAttributes.isEmpty ? Container(
                                                    width: FlexoValues.deviceWidth * 0.4,
                                                    height: FlexoValues.deviceHeight * 0.1,
                                                  ) :
                                                  Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: compareProductProvider.uniqueGroupAttributes.map((specificationAttribute)
                                                      {

                                                        return Row(
                                                          children: [

                                                            Container(
                                                              width: FlexoValues.deviceWidth * 0.3,
                                                              height: FlexoValues.deviceHeight * 0.1,
                                                              padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                              decoration: BoxDecoration(
                                                                  border: Border(
                                                                    bottom: BorderSide(
                                                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                    ),
                                                                    right: BorderSide(
                                                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                    ),
                                                                    left: BorderSide(
                                                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                    ),
                                                                  )
                                                              ),
                                                              alignment: Alignment.centerLeft,
                                                              child: FlexoTextWidget().contentText15(text: "${specificationAttribute.name}",),
                                                            ),

                                                            Container(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: compareProductProvider.compareProductDetailsList.map((pd)
                                                                {
                                                                  var isHasValue = pd.productSpecificationModel.groups.any((g) => g.id == group.id);
                                                                  if(isHasValue)
                                                                  {
                                                                    return Container(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: pd.productSpecificationModel.groups.where((g) => g.id == group.id).map((spec)
                                                                        {

                                                                          var isHasValue = spec.attributes.any((sa) => sa.id == specificationAttribute.id);
                                                                          if(isHasValue)
                                                                          {
                                                                            return Container(
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: spec.attributes.where((sa) => sa.id == specificationAttribute.id).map((att)
                                                                                {
                                                                                  return Container(
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [

                                                                                        Container(
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: att.values.map((value)
                                                                                            {
                                                                                              if(value.colorSquaresRgb == null || value.colorSquaresRgb == "")
                                                                                              {
                                                                                                return Container(
                                                                                                  child: StatefulBuilder(builder: (context, setState){
                                                                                                    return Container(
                                                                                                      width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                                                                      height: FlexoValues.deviceHeight * 0.1,
                                                                                                      padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                                                                      decoration: BoxDecoration(
                                                                                                          border: Border(
                                                                                                              bottom: BorderSide(
                                                                                                                  color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                                                              ),
                                                                                                              right: BorderSide(
                                                                                                                  color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                                                              )
                                                                                                          )
                                                                                                      ),
                                                                                                      alignment: Alignment.centerLeft,
                                                                                                      child: RichText(
                                                                                                        text: HTML.toTextSpan(
                                                                                                          context,
                                                                                                          value.valueRaw,
                                                                                                          defaultTextStyle: TextStyle(
                                                                                                            color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                                                            fontSize: 15,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),

                                                                                                    );
                                                                                                  }),
                                                                                                );
                                                                                              }
                                                                                              else
                                                                                              {
                                                                                                int selectedColor=0;
                                                                                                String color=value.colorSquaresRgb;
                                                                                                selectedColor=int.parse(color.replaceAll('#', '0xff'));
                                                                                                return Container(
                                                                                                    width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                                                                    height: FlexoValues.deviceHeight * 0.1,
                                                                                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                                                                    decoration: BoxDecoration(
                                                                                                        border: Border(
                                                                                                            bottom: BorderSide(
                                                                                                                color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                                                            ),
                                                                                                            right: BorderSide(
                                                                                                                color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                                                            )
                                                                                                        )
                                                                                                    ),
                                                                                                    alignment: Alignment.centerLeft,
                                                                                                    child: Container(
                                                                                                      height: FlexoValues.deviceWidth * 0.08,
                                                                                                      width: FlexoValues.deviceWidth * 0.08,
                                                                                                      color: Color(selectedColor),
                                                                                                    )
                                                                                                );
                                                                                              }
                                                                                            }).toList(),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            );
                                                                          }else{
                                                                            return Container(
                                                                              width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                                              height: FlexoValues.deviceHeight * 0.1,
                                                                              padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                                              decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                      bottom: BorderSide(
                                                                                          color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                                      ),
                                                                                      right: BorderSide(
                                                                                          color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                                      )
                                                                                  )
                                                                              ),
                                                                              alignment: Alignment.centerLeft,
                                                                            );
                                                                          }
                                                                        }).toList(),
                                                                      ),
                                                                    );
                                                                  }else{
                                                                    return Container(
                                                                      width: compareProductProvider.compareProductDetailsList.length == 1 ? FlexoValues.deviceWidth * 0.66 : FlexoValues.deviceWidth * 0.5,
                                                                      height: FlexoValues.deviceHeight * 0.1,
                                                                      padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                                      decoration: BoxDecoration(
                                                                          border: Border(
                                                                              bottom: BorderSide(
                                                                                  color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                              ),
                                                                              right: BorderSide(
                                                                                  color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                              )
                                                                          )
                                                                      ),
                                                                      alignment: Alignment.centerLeft,
                                                                    );
                                                                  }
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }).toList(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }else{
                                            return Container();
                                          }
                                        }).toList(),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.heightSpace1Px,)
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ),
        );
      },
    );
  }
}