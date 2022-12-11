/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Customer/RewardPoint/RewardPoint.dart';
import 'package:nopcommerce/Utils/Enum/ThemeAttributes.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/RewardPoint/RewardPointProvider.dart';
import 'package:provider/provider.dart';

class RewardPoints extends StatefulWidget {

  @override
  _RewardPointsState createState() => _RewardPointsState();
}

class _RewardPointsState extends State<RewardPoints> {

  @override
  void initState()
  {
    loadData();
    super.initState();
  }

  loadData()async
  {
    context.read<LocalResourceProvider>().loadLocalResources();
    context.read<RewardPointProvider>().loadCacheData(context: context);
    if(await CheckConnectivity().checkInternet(context)){
      context.read<RewardPointProvider>().pageLoadData(context: context,pageNumbers: 1);
    }
  }
  @override
  Widget build(BuildContext context) {

    if(selectedTheme == ThemeAttributes.Flexo)
    {
      return FlexoRewardPoint();
    }else{
      return FlexoRewardPoint();
    }
  }
}
