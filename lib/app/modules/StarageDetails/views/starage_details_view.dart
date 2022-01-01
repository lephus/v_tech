import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/home/components/chart.dart';
import 'package:v_tech/app/modules/home/components/storage_info_card.dart';

import '../controllers/starage_details_controller.dart';

class StarageDetailsView extends GetView<StarageDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeText.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Doanh thu cửa hàng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: SizeText.defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "26 Thái hà",
            amountOfFiles: "1.3GB",
            numOfFiles: 1328,
          ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/media.svg",
          //   title: "Media Files",
          //   amountOfFiles: "15.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/folder.svg",
          //   title: "Other Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/unknown.svg",
          //   title: "Unknown",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 140,
          // ),
        ],
      ),
    );
  }
}
