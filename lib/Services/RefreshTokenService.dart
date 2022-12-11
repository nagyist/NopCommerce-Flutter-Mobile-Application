/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



// import 'package:nopcommerce/DataProvider/apiConstants.dart';
// import 'package:nopcommerce/DataProvider/apiService.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class RefreshTokenService {
//   late APIService _apiService;
//
//   RefreshTokenService(APIService apiService) {
//     _apiService = apiService;
//   }
//
//   refreshToken() async {
//     SharedPreferences preferences=await SharedPreferences.getInstance();
//     String? oldTime=preferences.getString('refreshTokenExpiration');
//     DateTime refreshTime=DateTime.parse(oldTime!);
//     DateTime current=DateTime.now();
//     if(current.isAfter(refreshTime)){
//       final json1='{ '
//           '"refreshToken": "${preferences.getString("refreshtoken")}",'
//           '}';
//       var response = await _apiService.httpGet(APIConstants.REFRESH_TOKEN_API, false);
//       var response=await http.post(Uri.parse(url),headers: header,body: json1);
//       if(response.statusCode == 200) {
//         RefreshTokenResponseModel refreshTokenResponseModel = refreshTokenResponseModelFromJson(response.body);
//         preferences.setString('token', refreshTokenResponseModel.accessToken);
//         preferences.setString('refreshtoken', refreshTokenResponseModel.refreshToken);
//         preferences.setString('refreshTokenExpiration', refreshTokenResponseModel.refreshTokenExpiration.toString());
//         preferences.setBool('ispersonate', refreshTokenResponseModel.isCustomerImpersonated);
//         preferences.setString('ispersonatename', refreshTokenResponseModel.impersonatedCustomerName == null ? "" : refreshTokenResponseModel.impersonatedCustomerName);
//
//       }else{
//         preferences.setBool('login', false);
//         preferences.setBool('without', false);
//
//         Navigator.pushReplacement(context,PageTransition(type: selectedTransition, child: Login(LoginTypeAttribute.Login,-1)));
//       }
//     }else{
//       preferences.setBool('login', false);
//       preferences.setBool('without', false);
//       //Navigator.pushReplacement(context,PageTransition(type: selectedTransition, child: Login(LoginTypeAttribute.Login)));
//     }
//   }
// }