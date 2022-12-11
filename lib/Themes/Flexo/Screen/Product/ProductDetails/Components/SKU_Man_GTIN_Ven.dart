/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/ProductType.dart';
import 'package:provider/provider.dart';

class SKUManGTINVen {
  getView({required BuildContext context,required GetProductDetailsModel getProductDetailsModel,required bool isSimple})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return Column(
      children: [

        isSimple ? Container() : getProductDetailsModel.showSku && getProductDetailsModel.sku != null ?
        Container(
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Row(
            children: [
              Container(
                child: FlexoTextWidget().headingBoldText15(text: '${localResourceProvider.getResourseByKey("products.sku")}: ',),
              ),
              Container(
                child: FlexoTextWidget().contentText15(text: getProductDetailsModel.sku,),
              ),

              SizedBox(height: FlexoValues.heightSpace1Px,)
            ],
          ),
        ):Container(),

        getProductDetailsModel.showManufacturerPartNumber?
        Container(
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: FlexoTextWidget().headingBoldText15(text: '${localResourceProvider.getResourseByKey("products.manufacturer")}: ',),
                    ),
                    Flexible(
                      child: Container(
                        child: FlexoTextWidget().contentText15(text: '${getProductDetailsModel.manufacturerPartNumber}',),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: FlexoValues.heightSpace1Px),
            ],
          ),
        ):Container(),

        getProductDetailsModel.showGtin?
        Container(
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: FlexoTextWidget().headingText15(text: '${localResourceProvider.getResourseByKey("products.gtin")}: ',),
                    ),
                    Flexible(
                      child: Container(
                        child: FlexoTextWidget().contentText15(text: '${getProductDetailsModel.gtin}',),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: FlexoValues.heightSpace1Px),
            ],
          ),
        ):Container(),

        getProductDetailsModel.showVendor?
        Container(
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: FlexoTextWidget().headingBoldText15(text: '${localResourceProvider.getResourseByKey("products.vendor")}: ',),
                    ),
                    Container(
                      child: FlexoTextWidget().contentText15(text: '${getProductDetailsModel.vendorModel.name}',),
                    ),
                  ],
                ),
              ),
              SizedBox(height: FlexoValues.heightSpace1Px),
            ],
          ),
        ):Container(),
      ],
    );
  }
}