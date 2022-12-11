/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FlexoDatePicker.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldAttributeWidgets.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/AddToCartType.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';


class FlexoProductAttribute extends StatelessWidget {
  GetProductDetailsModel getProductDetailsModel;
  FlexoProductAttribute({required this.getProductDetailsModel});

  @override
  Widget build(BuildContext context) {

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return StatefulBuilder(builder: (ctx, setState)
    {
      List<dynamic> disabledAttributeMappingIds = [];

      if(productDetailsProvider.associateProductDetailsAttributeChangeModel[getProductDetailsModel.id] != null)
      {
        disabledAttributeMappingIds = productDetailsProvider.associateProductDetailsAttributeChangeModel[getProductDetailsModel.id]!.disabledattributemappingids;
      }

      return Column(
        children: [

          Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,),

          Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            width: FlexoValues.deviceWidth,
            child: Column(
              children: getProductDetailsModel.productAttributes.map((e)
              {
                Widget widget = Container();

                List<dynamic> disabledAttributeIds = [];

                if(disabledAttributeMappingIds.isNotEmpty)
                {
                  disabledAttributeIds = disabledAttributeMappingIds.where((element) => element==e.id).toList();
                }

                if(disabledAttributeIds.isNotEmpty) {
                  return widget;
                }else{
                  switch(e.attributeControlType)
                  {
                    case AttributeControlType.DropdownList:

                      List<DropDownModel> dropDownList = [];

                      dropDownList.add(new DropDownModel(text: localResourceProvider.getResourseByKey("Products.ProductAttributes.DropdownList.DefaultItem"), value: "0"));
                      for(var item in e.values)
                      {
                        var attributeName = item.priceAdjustment == null ? item.name : localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment").toString().replaceAll("{0}", item.name).replaceAll("{1}", item.priceAdjustment).replaceAll("{2}", item.customerEntersQty ? localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.PerItem") : "");

                        dropDownList.add(new DropDownModel(text: attributeName, value: item.id.toString()));
                      }

                      if(e.defaultValue == null || e.defaultValue == ""){
                        for(var item in e.values.where((element) => element.isPreSelected))
                        {
                          e.defaultValue = item.id;
                        }
                      }

                      if(e.defaultValue == null || e.defaultValue == ""){
                        e.defaultValue = dropDownList[0].value.toString();
                      }

                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            FlexoDropDown(
                                width: FlexoValues.controlsWidth,
                                showRequiredIcon: false,
                                selectedValue: e.defaultValue.toString(),
                                items: dropDownList,
                                onChange: (val)
                                {
                                  setState(() {
                                    e.defaultValue = "$val";
                                    productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                  });
                                }
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px),

                            Column(
                              children: e.values.where((element) => element.customerEntersQty && element.id.toString() == e.defaultValue.toString()).map((item)
                              {
                                return Column(
                                  children: [
                                    Row(
                                      children: [

                                        FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.Quantity")),

                                        SizedBox(width: FlexoValues.widthSpace1Px),

                                        TextFieldAttributeWidgets(
                                            showRequiredIcon: false,
                                            width: FlexoValues.deviceWidth * 0.20,
                                            initialValue: item.quantity.toString(),
                                            textFieldType: TextFieldType.Numeric,
                                            keyBoardType: TextInputType.number,
                                            onChange: (val)
                                            {
                                              setState(() {
                                                item.quantity = int.parse(val);
                                                productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                              });
                                            }
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px)
                                  ],
                                );
                              }).toList(),
                            ),

                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.RadioList:
                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            radioListContainer(context: context,productAttribute: e,setState: setState),

                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.Checkboxes:
                    case AttributeControlType.ReadonlyCheckboxes:

                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            checkBoxContainer(context: context,productAttribute: e,setState: setState),
                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.TextBox:

                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            TextFieldWidget(
                                width: FlexoValues.controlsWidth,
                                showRequiredIcon: false,
                                onChange: (val)
                                {
                                  setState(() {
                                    e.defaultValue = val;
                                    productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                  });
                                }
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px)
                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.MultilineTextbox:


                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            TextFieldWidget(
                                width: FlexoValues.controlsWidth,
                                showRequiredIcon: false,
                                maxLine: 5,
                                onChange: (val)
                                {
                                  setState(() {
                                    e.defaultValue = val;
                                    productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                  });
                                }
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px)
                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.ImageSquares:
                      if(e.defaultValue==null){
                        for(var i in e.values){

                          if(i.isPreSelected==true){
                            e.defaultValue=i.id;
                          }
                        }
                        if(e.defaultValue==null){
                          e.defaultValue=0;
                        }
                      }
                      List<ImageSelection> imgUrl=[];
                      for(var i in e.values) {
                        imgUrl.add(ImageSelection(i.id, i.imageSquaresPictureModel.fullSizeImageUrl));
                      }
                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            Container(
                              width: FlexoValues.deviceWidth,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: imgUrl.map((p){
                                      return GestureDetector(
                                        child: Container(
                                          height: FlexoValues.deviceWidth * 0.15,
                                          width: FlexoValues.deviceWidth * 0.15,
                                          margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px),
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                                color: e.defaultValue==p.id ? Colors.black : Colors.grey,
                                                width: 2
                                            ),
                                          ),
                                          child: CachedNetworkImage(imageUrl: p.imgUrl),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            productDetailsProvider.selectId=p.id;
                                            e.defaultValue = productDetailsProvider.selectId;
                                            productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: FlexoValues.heightSpace1Px),

                            StatefulBuilder(builder: (context, setState)
                            {
                              for(var item in e.values.where((element) => element.customerEntersQty))
                              {
                                return Column(
                                  children: [
                                    Row(
                                      children: [

                                        FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.Quantity")),

                                        SizedBox(width: FlexoValues.widthSpace1Px),

                                        TextFieldAttributeWidgets(
                                            showRequiredIcon: false,
                                            width: FlexoValues.deviceWidth * 0.20,
                                            initialValue: item.quantity.toString(),
                                            textFieldType: TextFieldType.Numeric,
                                            keyBoardType: TextInputType.number,
                                            onChange: (val)
                                            {
                                              setState(() {
                                                item.quantity = int.parse(val);
                                                productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                              });
                                            }
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px)
                                  ],
                                );
                              }
                              return Container();

                            }),

                            SizedBox(width: FlexoValues.widthSpace1Px),
                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.FileUpload:

                      widget = Container(
                        width: FlexoValues.controlsWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            Container(
                              width: FlexoValues.controlsWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  GestureDetector(
                                    onTap: () async{
                                      if(await CheckConnectivity().checkInternet(context)){
                                        setState(()
                                        {
                                          _openFileExplorer(context: context, setState: setState, productAttribute: e,productDetailsProvider: productDetailsProvider);
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: FlexoColorConstants.BROWSE_BUTTON_COLOR,
                                          border: Border.all(
                                              color: FlexoColorConstants.BROWSE_BUTTON_BORDER_COLOR
                                          )
                                      ),
                                      child: Text(
                                        localResourceProvider.getResourseByKey("common.fileUploader.upload").toString().toUpperCase(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: FlexoColorConstants.BROWSE_BUTTON_TEXT_COLOR,
                                            fontSize: FlexoValues.fontSize16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                  e.defaultValue != null && e.defaultValue != "" ?
                                  Container(
                                    child: Text(
                                      e.defaultValue,
                                      style: TextStyle(
                                          fontSize: FlexoValues.fontSize15,
                                          color: Colors.green,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ) : Container()
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px)
                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.ColorSquares:

                      if(e.defaultValue == null)
                      {
                        e.defaultValue="";
                      }

                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            Container(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: e.values.map((value)
                                {
                                  int colorCode = int.parse(value.colorSquaresRgb.replaceAll("#", "0xff"));
                                  if(e.defaultValue == "")
                                  {
                                    if(value.isPreSelected)
                                    {
                                      e.defaultValue = value.id.toString();
                                    }
                                  }

                                  return GestureDetector(
                                    onTap: (){
                                      setState(()
                                      {
                                        e.defaultValue = value.id.toString();
                                        productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px,bottom: FlexoValues.widthSpace2Px),
                                      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                      height: e.defaultValue == value.id.toString() ? FlexoValues.deviceWidth * 0.09 : FlexoValues.deviceWidth * 0.08,
                                      width: e.defaultValue == value.id.toString() ? FlexoValues.deviceWidth * 0.09 : FlexoValues.deviceWidth * 0.08,
                                      decoration: BoxDecoration(
                                          color: Color(colorCode),
                                          borderRadius: BorderRadius.all(Radius.circular(FlexoValues.widthSpace1Px)),
                                          border: Border.all(
                                              color: e.defaultValue == value.id.toString() ? Colors.blue.shade500 : Color(colorCode),
                                              width: FlexoValues.deviceWidth * 0.005
                                          )
                                      ),
                                      child: e.defaultValue == value.id.toString() ? Icon(
                                        Icons.check,
                                        color: Colors.blue.shade500,
                                        size: FlexoValues.iconSize20,
                                      ) : Container(),
                                    ),
                                  );

                                }).toList(),
                              ),
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px),

                            StatefulBuilder(builder: (context, setState)
                            {
                              for(var item in e.values.where((element) => element.customerEntersQty))
                              {
                                return Column(
                                  children: [
                                    Row(
                                      children: [

                                        FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.Quantity")),

                                        SizedBox(width: FlexoValues.widthSpace1Px),

                                        TextFieldAttributeWidgets(
                                            showRequiredIcon: false,
                                            width: FlexoValues.deviceWidth * 0.20,
                                            initialValue: item.quantity.toString(),
                                            textFieldType: TextFieldType.Numeric,
                                            keyBoardType: TextInputType.number,
                                            onChange: (val)
                                            {
                                              setState(() {
                                                item.quantity = int.parse(val);
                                                productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                              });
                                            }
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px)
                                  ],
                                );
                              }
                              return Container();

                            }),
                          ],
                        ),
                      );
                      break;

                    case AttributeControlType.Datepicker:
                      var textEditingController = TextEditingController();

                      if(e.selectedDay == null)
                      {
                        e.selectedDay=0;
                      }

                      if(e.selectedMonth == null)
                      {
                        e.selectedMonth=0;
                      }

                      if(e.selectedYear == null)
                      {
                        e.selectedYear=0;
                      }

                      String selectedDatePicker = "";
                      if(e.selectedDay!=0 || e.selectedMonth != 0 || e.selectedYear != 0)
                      {
                        selectedDatePicker = "${e.selectedDay}-${e.selectedMonth}-${e.selectedYear}";
                      }

                      productDetailsProvider.datePickerMap[e.id] = textEditingController;
                      productDetailsProvider.datePickerMap[e.id]!.text = selectedDatePicker;

                      textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: textEditingController.text.length));

                      widget = Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired, description: e.description == null ? "" : e.description),

                            FlexoDatePickerPlugin(
                              context: context,
                              width: FlexoValues.controlsWidth,
                              controller: productDetailsProvider.datePickerMap[e.id]!,
                              onClick: (formattedDate)
                              {
                                setState(()
                                {

                                  DateTime datePicked = new DateFormat(StringConstants.DATE_FORMAT).parse(formattedDate);

                                  e.selectedDay = int.parse(DateFormat('dd').format(datePicked));
                                  e.selectedDay = int.parse(DateFormat('MM').format(datePicked));
                                  e.selectedDay = int.parse(DateFormat('yyyy').format(datePicked));
                                });
                              },
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px)
                          ],
                        ),
                      );
                      break;
                  }
                }

                return Container(
                  child: widget,
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }

  List<PlatformFile>? paths;
  String? extension;
  String fileName="";
  String filePath="";

  void _openFileExplorer({required BuildContext context,required StateSetter setState,required ProductAttribute productAttribute,required ProductDetailsProvider productDetailsProvider}) async {

    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      try {
        paths = (await FilePicker.platform.pickFiles(
            onFileLoading: (FilePickerStatus status) => print('f$status'),
            type: productAttribute.allowedFileExtensions.isEmpty ? FileType.any : FileType.custom,
            allowedExtensions: productAttribute.allowedFileExtensions
        ))?.files;
      } on PlatformException catch (e) {
        print(e);
      } catch (ex) {
        print(ex);
      }

      setState(() {

        if(paths != null && paths != "")
        {
          fileName = paths != null ? paths!.map((e) => e.name).toString() : '...';
          filePath = paths != null ? paths!.map((e) => e.path).toString() : '...';

          filePath = filePath.substring(1,filePath.length-1);
          fileName = fileName.substring(1,fileName.length-1);

          List<int> bytes = File(filePath).readAsBytesSync();
          String base64File = base64Encode(bytes);

          productDetailsProvider.attributeUploadFile(context: context,productAttribute: productAttribute,base64: base64File,fileName: fileName);
        }

      });
    }


  }


  radioListContainer({required BuildContext context, required ProductAttribute productAttribute,required StateSetter setState})
  {
    var productDetailsProvider = context.watch<ProductDetailsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();

    if(productAttribute.defaultValue==null){
      for(var i in productAttribute.values){
        if (i.isPreSelected) {
          productAttribute.defaultValue = i.id;
        }
      }
    }
    if(productAttribute.defaultValue!=null){
      for(var i in productAttribute.values){
        if(productAttribute.defaultValue.toString()==i.id.toString()){
          i.isPreSelected = true;
        }else{
          i.isPreSelected = false;
        }
      }
    }

    return Container(
      width: FlexoValues.controlsWidth,
      child: Column(
        children: productAttribute.values.map((item) {

          var attributeName = item.priceAdjustment == null ? item.name : localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment").toString().replaceAll("{0}", item.name).replaceAll("{1}", item.priceAdjustment).replaceAll("{2}", item.customerEntersQty ? localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.PerItem") : "");

          return GestureDetector(
            onTap: (){
              setState(() {
                productAttribute.defaultValue = item.id;
                for(var it in productAttribute.values)
                {
                  if(it.id == item.id)
                  {
                    it.isPreSelected = true;
                  }else{
                    it.isPreSelected = false;
                  }
                }
                productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px,bottom: FlexoValues.widthSpace2Px),
              padding: EdgeInsets.only(right: FlexoValues.widthSpace1Px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  ButtonWidget().getRatioButton(text: attributeName, isCheck: item.isPreSelected),

                  SizedBox(height: FlexoValues.heightSpace1Px),

                  StatefulBuilder(builder: (context, setState)
                  {
                    if(item.customerEntersQty && item.isPreSelected)
                    {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.Quantity")),

                              SizedBox(width: FlexoValues.widthSpace1Px),

                              TextFieldAttributeWidgets(
                                  showRequiredIcon: false,
                                  width: FlexoValues.deviceWidth * 0.20,
                                  initialValue: item.quantity.toString(),
                                  textFieldType: TextFieldType.Numeric,
                                  keyBoardType: TextInputType.number,
                                  onChange: (val)
                                  {
                                    setState(() {
                                      item.quantity = int.parse(val);
                                      productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                    });
                                  }
                              ),
                            ],
                          ),

                          Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,)
                        ],
                      );
                    }
                    return Container();

                  }),

                  SizedBox(width: FlexoValues.widthSpace1Px),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  checkBoxContainer({required BuildContext context, required ProductAttribute productAttribute,required StateSetter setState})
  {
    var productDetailsProvider = context.watch<ProductDetailsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return Container(
      width: FlexoValues.deviceWidth,
      child: Wrap(
        children: productAttribute.values.map((item) {

          var attributeName = item.priceAdjustment == null ? item.name : localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment").toString().replaceAll("{0}", item.name).replaceAll("{1}", item.priceAdjustment).replaceAll("{2}", item.customerEntersQty ? localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.PerItem") : "");

          return Container(
            margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px,top: FlexoValues.widthSpace2Px),
            child: Container(
              padding: EdgeInsets.only(right: FlexoValues.widthSpace3Px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        child: Transform.scale(
                          scale: FlexoValues.switchScale,
                          child: CupertinoSwitch(
                            onChanged: (val)
                            {
                              setState(()
                              {
                                item.isPreSelected = !item.isPreSelected;
                                productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                              });
                            },
                            value: item.isPreSelected,
                            activeColor: FlexoColorConstants.ACCENT_COLOR,
                          ),
                        ),
                      ),

                      SizedBox(width: FlexoValues.widthSpace1Px),

                      FlexoTextWidget().headingText16(text: attributeName),
                    ],
                  ),

                  SizedBox(height: FlexoValues.heightSpace1Px),

                  StatefulBuilder(builder: (context, setState)
                  {
                    if(item.customerEntersQty && item.isPreSelected)
                    {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("Products.ProductAttributes.PriceAdjustment.Quantity")),

                              SizedBox(width: FlexoValues.widthSpace1Px),

                              TextFieldAttributeWidgets(
                                  showRequiredIcon: false,
                                  width: FlexoValues.deviceWidth * 0.20,
                                  initialValue: item.quantity.toString(),
                                  textFieldType: TextFieldType.Numeric,
                                  keyBoardType: TextInputType.number,
                                  onChange: (val)
                                  {
                                    setState(() {
                                      item.quantity = int.parse(val);
                                      productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                    });
                                  }
                              ),
                            ],
                          ),

                          Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,)
                        ],
                      );
                    }
                    return Container();

                  }),

                  SizedBox(width: FlexoValues.widthSpace1Px),

                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  attributeHeading({required String heading, required bool isRequired, required String description})
  {
    return Container(
      child: Column(
        children: [
          Container(
            width: FlexoValues.controlsWidth,
            child: RichText(
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: new TextSpan(
                  text: heading,
                  style: TextStyleWidget.controlsHeadingTextStyle,
                  children: [
                    isRequired ?
                    TextSpan(
                      text:" *",
                      style: TextStyleWidget.controlsRequiredTextStyle,
                    ) : TextSpan(),
                  ]
              ),
            ),
          ),

          description == "" ? Container() :
          Container(
            width: FlexoValues.controlsWidth,
            child: Column(
              children: [

                SizedBox(height: FlexoValues.widthSpace1Px),

                Container(
                  width: FlexoValues.controlsWidth,
                  child: FlexoTextWidget().contentText15(text: description,),
                ),
              ],
            ),
          ),

          SizedBox(height: FlexoValues.widthSpace1Px,)
        ],
      ),
    );
  }
}
