/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/GetCatalogRootModel.dart';
import 'package:nopcommerce/Models/GetPopularProductTagsModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/ProductBoxModel.dart';
import 'package:nopcommerce/Models/ProductCatalogModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductByCategoryService.dart';
import 'package:nopcommerce/Services/ProductServices.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Catalog/ProductByCategory/Component/ProductByCategoryDrawerComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Catalog/ProductByCategory/ProductByCategory.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/Enum/ThemeAttributes.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:provider/provider.dart';
import 'Model/GetCategoryResponseModel.dart';
import 'Model/ProductsByCategoryRequestModel.dart';

class ProductByCategory extends StatefulWidget {
  final int categoryId;
  ProductByCategory({required this.categoryId});

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {

  final GlobalKey<ScaffoldState> scaffold=new GlobalKey<ScaffoldState>();
  bool isApiLoader = false;
  bool isPageLoader = true;
  bool isLoadProduct = false;
  String orderBy = "0";
  int selectedAttribute=0;
  int selectedSortRadioGroup = 1;
  int pageNumber=1;
  int pageSize = 4;
  int defaultMinPrice = 0;
  int defaultMaxPrice = 10000000;
  late GetCategoryResponseModel getCategoryResponseModel;
  late GetPopularProductTagsModel getPopularProductTagsModel;
  late ProductsByCategoryRequestModel productsByCategoryRequestModel;
  List<GetCatalogRootModel> getCatalogRootModel=[];
  List<ProductBoxModel> products=[];
  RangeValues currentRangeValues =  RangeValues(0, 1000);
  ScrollController scrollController = ScrollController();

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

  @override
  void initState() {
    super.initState();

    loadCacheData();
    loadData();
  }

  loadData()async
  {
    context.read<LocalResourceProvider>().loadLocalResources();
    setState(() {
      productsByCategoryRequestModel = new ProductsByCategoryRequestModel(categoryId: widget.categoryId, price: "$defaultMinPrice-$defaultMaxPrice", specs: "", ms: "", orderBy: orderBy, pageNumber: pageNumber, pageSize: pageSize, isFilterData: false,isLazyLoad: false);
    });
    categoryProductMethod(productsByCategoryRequestModel: productsByCategoryRequestModel);
  }

  prepareData()
  {
    setState(() {
      isApiLoader=true;
    });
    scaffold.currentState!.openEndDrawer();
    setState(() {
      orderBy = getCategoryResponseModel.catalogProductsModel.orderBy.toString();
      String priceRange = "${getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.from}-${getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.to}";
      List<int> specsList = [];
      for(var item in getCategoryResponseModel.catalogProductsModel.specificationFilter.attributes)
      {
        for(var it in item.values.where((element) => element.selected))
        {
          specsList.add(it.id);
        }
      }

      productsByCategoryRequestModel = new ProductsByCategoryRequestModel(categoryId: widget.categoryId, price: priceRange, specs: specsList.join(","), ms: "", orderBy: orderBy, pageNumber: pageNumber, pageSize: pageSize, isFilterData: false,isLazyLoad: false);
    });
    categoryProductMethod(productsByCategoryRequestModel: productsByCategoryRequestModel);
  }

  categoryProductMethod({required ProductsByCategoryRequestModel productsByCategoryRequestModel})async
  {
    if(!productsByCategoryRequestModel.isLazyLoad)
    {
      setState(() {
        //isApiLoader=true;
      });
    }
    Response response=await ProductByCategoryService().categoryProduct(context: context, param:'/${productsByCategoryRequestModel.categoryId}?Price=${productsByCategoryRequestModel.price}&OrderBy=${productsByCategoryRequestModel.orderBy}&PageSize=${productsByCategoryRequestModel.pageSize}&PageNumber=${productsByCategoryRequestModel.pageNumber}&specs=${productsByCategoryRequestModel.specs}');
    if(response.statusCode == 200) {
      setState(() {
        storage.setItem(StringConstants.CACHE_PRODUCTS_BY_CATEGORY, response.body);
        getCategoryResponseModel = getCategoryResponseModelFromJson(response.body);
        if(productsByCategoryRequestModel.isLazyLoad)
        {
          products.addAll(getCategoryResponseModel.catalogProductsModel.products);
          isLoadProduct = false;
        }else{
          products.clear();
          products.addAll(getCategoryResponseModel.catalogProductsModel.products);
          if(getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled)
          {
            currentRangeValues =  RangeValues(getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.from.toDouble(), getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.to.toDouble());
          }
          if( getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled)
          {
            selectedAttribute = 0;
          }else if( getCategoryResponseModel.catalogProductsModel.specificationFilter.enabled){
            selectedAttribute = 1;
          }else{
            selectedAttribute = 2;
          }
          List<AvailableOption> options = getCategoryResponseModel.catalogProductsModel.availableSortOptions.where((element) => element.selected).toList();
          if(options.isNotEmpty)
          {
            orderBy = options[0].value;
          }else{
            orderBy = getCategoryResponseModel.catalogProductsModel.availableSortOptions[0].value;
          }
        }
        isApiLoader=false;
      });
    }
    else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
    }
    if(productsByCategoryRequestModel.isFilterData)
    {
      getHeaderData(context: context);
    }else{
      productTagMethod(context: context);
    }
  }

  productTagMethod({required BuildContext context})async
  {
    Response response=await ProductService().popularProductTags(context: context);
    storage.setItem(StringConstants.CACHE_POPULAR_TAGS, response.body);
    if(response.statusCode == 200) {
      setState(() {
        getPopularProductTagsModel = getPopularProductTagsModelFromJson(response.body) ;
      });
    }
    catalogRootMethod(context: context);
  }

  catalogRootMethod({required BuildContext context})async
  {
    Response response=await ProductByCategoryService().catalogRoot(context: context);
    storage.setItem(StringConstants.CACHE_CATALOG_ROOT, response.body);
    if(response.statusCode == 200) {
      setState(() {
        getCatalogRootModel =getCatalogRootModelFromJson(response.body) ;
      });
    }
    getHeaderData(context: context );
  }

  getHeaderData({required BuildContext context}) async
  {
    Response response = await CommonService().getHeaderData(context: context);
    storage.setItem(StringConstants.CACHE_HEADER, response.body);
    if(response.statusCode == 200)
    {
     setState(() {
       headerModel = headerInfoResponseModelFromJson(response.body);
       isPageLoader = false;
       if(headerModel.alertMessage != "")
       {
         DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
       }
     });
    }
    setState(() {
      isPageLoader=false;
      isApiLoader=false;
    });
  }

  loadMoreProducts({required BuildContext context}) async
  {
    if(getCategoryResponseModel.catalogProductsModel.pageNumber!=getCategoryResponseModel.catalogProductsModel.totalPages){
      setState(() {
        isLoadProduct = true;
        productsByCategoryRequestModel = new ProductsByCategoryRequestModel(categoryId: widget.categoryId, price: "${getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.from}-${getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.to}", specs: "", ms: "", orderBy: orderBy, pageNumber: getCategoryResponseModel.catalogProductsModel.pageNumber + 1, pageSize: pageSize, isFilterData: false,isLazyLoad: true);
      });
      categoryProductMethod(productsByCategoryRequestModel: productsByCategoryRequestModel);
    }
  }

  clearAttributes({required BuildContext context})
  {
    setState(() {
      isApiLoader= true;
      if(getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled)
      {
        currentRangeValues =  RangeValues(getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from, getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to);
      }
      String priceRange = "$defaultMinPrice-$defaultMaxPrice";
      if(getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled)
      {
        priceRange = "${getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from}-${getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to}";
      }
      for(var item in getCategoryResponseModel.catalogProductsModel.specificationFilter.attributes)
      {
        for(var it in item.values.where((element) => element.selected))
        {
          it.selected = false;
        }
      }
      productsByCategoryRequestModel = new ProductsByCategoryRequestModel(categoryId: widget.categoryId, price: priceRange, specs: "", ms: "", orderBy: orderBy, pageNumber: pageNumber, pageSize: pageSize, isFilterData: false,isLazyLoad: true);
    });
    categoryProductMethod(productsByCategoryRequestModel: productsByCategoryRequestModel);
  }

  loadCacheData()async
  {
    isApiLoader = false;
    isPageLoader = true;
    orderBy = "0";
    pageSize=4;
    selectedAttribute=0;
    selectedSortRadioGroup = 1;
    pageNumber=1;

    await cacheProductsByCategoryMethod(context: context);
  }

  cacheProductsByCategoryMethod({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_PRODUCTS_BY_CATEGORY);
    if(res != null)
    {
      setState(() {
        getCategoryResponseModel = getCategoryResponseModelFromJson(res);
        products.addAll(getCategoryResponseModel.catalogProductsModel.products);
        if(getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled)
        {
          currentRangeValues =  RangeValues(getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.from.toDouble(), getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.to.toDouble());
        }
        if( getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled)
        {
          selectedAttribute = 0;
        }else if( getCategoryResponseModel.catalogProductsModel.specificationFilter.enabled){
          selectedAttribute = 1;
        }else{
          selectedAttribute = 2;
        }
        List<AvailableOption> options = getCategoryResponseModel.catalogProductsModel.availableSortOptions.where((element) => element.selected).toList();
        if(options.isNotEmpty)
        {
          orderBy = options[0].value;
        }else{
          orderBy = getCategoryResponseModel.catalogProductsModel.availableSortOptions[0].value;
        }
        getCategoryResponseModel=getCategoryResponseModel;
      });
      if(getCategoryResponseModel.id == widget.categoryId) {
        await cachePopularTagsMethod(context: context);
        await cacheCatalogRootMethod(context: context);
        await cacheHeaderMethod(context: context);

        setState(() {
          isPageLoader = false;
        });
      }
      return getCategoryResponseModel;
    }else{
      return null;
    }
  }

  cachePopularTagsMethod({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_POPULAR_TAGS);
    if(res != null)
    {
      setState(() {
        getPopularProductTagsModel = getPopularProductTagsModelFromJson(res);
      });
      return getPopularProductTagsModel;
    }else{
      return null;
    }
  }

  cacheCatalogRootMethod({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_CATALOG_ROOT);
    if(res != null)
    {
      setState(() {
        getCatalogRootModel = getCatalogRootModelFromJson(res);
      });
      return getCatalogRootModel;
    }else{
      return null;
    }
  }

  cacheHeaderMethod({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_HEADER);
    if(res != null)
    {
     setState(() {
       headerModel = headerInfoResponseModelFromJson(res);
       if(headerModel.alertMessage != "")
       {
         DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
       }
     });
      return headerModel;
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(selectedTheme == ThemeAttributes.Flexo)
    {
      return Scaffold(
        key:  scaffold,
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        appBar: FlexoAppBarWidget().searchableAppbar(context: context,backButton: true),
        drawer: isPageLoader ? null : ProductByCategoryDrawerComponent().getProductByCategoryDrawerComponent(
          setState: setState,
          isApiLoader: isApiLoader,
          getCategoryResponseModel: getCategoryResponseModel,
          context: context,
          categoryProductMethod: categoryProductMethod,
          currentRangeValues: currentRangeValues,
          getCatalogRootModel: getCatalogRootModel,
          getPopularProductTagsModel: getPopularProductTagsModel,
          pageNumber: pageNumber,
          selectedAttribute: selectedAttribute,
          prepareData: prepareData,
          clearAttributes: clearAttributes,
          scaffold: scaffold
        ) ,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: headerModel,headerLoader: isPageLoader),
        body: isPageLoader ? Loaders.pageLoader() :  Column(
          children: [

            isApiLoader ? Loaders.apiLoader() : Container(),

            Expanded(
              child: Container(
                child: LazyLoadScrollView(
                  isLoading: isLoadProduct,
                  onEndOfPage: () => loadMoreProducts(context: context),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [

                        FlexoProductByCategory().getView(
                          context: context,
                          scrollController: scrollController,
                          getCategoryResponseModel: getCategoryResponseModel,
                          getHeaderData: getHeaderData,
                          headerModel: headerModel,
                          isApiLoader: isApiLoader,
                          isLoadProduct: isLoadProduct,
                          isPageLoader: isPageLoader,
                          products: products,
                          selectedSortRadioGroup: selectedSortRadioGroup,
                          scaffold: scaffold,
                          prepareData: prepareData,
                        ),

                        isLoadProduct ? Loaders.lazyLoader():Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }else{
      return Container();
    }
  }
}




