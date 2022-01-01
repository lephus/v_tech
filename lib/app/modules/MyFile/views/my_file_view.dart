import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/MyFile/RevenueModel.dart';
import 'package:v_tech/app/modules/home/components/file_info_card.dart';
import 'package:v_tech/responsive.dart';
import '../controllers/my_file_controller.dart';
class MyFileView extends GetView<MyFileController> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child:Obx(()=>
                controller.onChange.value ?
                ControlTypeDropDown(
                  menuList: controller.MenuDateTime,
                  initPosition: controller.selectDataTime,
                  onChange: (val)async{
                  },
                ) :
                ControlTypeDropDown(
                  menuList: controller.MenuDateTime,
                  initPosition: controller.selectDataTime,
                  onChange: (val)async{
                    controller.onChange.value = true;
                    controller.selectDataTime= val;
                    controller.chanDateTime();
                    await controller.getOverviewData();
                    await controller.GetRevenue();
                    controller.onChange.value = false;
                  },
                ),
                )
            ),
          ],
        ),
        SizedBox(height: SizeText.defaultPadding),
        Obx(()=>
            controller.isLoading == true ?
                CircularProgressIndicator() :
            Responsive(
              mobile: FileInfoCardGridView(
                data: controller.lstMyFiles,
                crossAxisCount: _size.width < 650 ? 2 : 4,
                childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
              ),
              tablet: FileInfoCardGridView(data: controller.lstMyFiles,),
              desktop: FileInfoCardGridView(
                data: controller.lstMyFiles,
                childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              ),
            ),
        ),
        SizedBox(height: SizeText.defaultPadding),
        if (Responsive.isMobile(context)) StarageDetails(context),
        if (!Responsive.isMobile(context))
          SizedBox(width: SizeText.defaultPadding),
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: StarageDetails(context),
          ),
      ],
    );
  }
  Widget StarageDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeText.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Obx(()=>
      controller.isLoadRevenue.value ?
          Center(
            child: CircularProgressIndicator(),
          ):
          Column(
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
          Chart(context),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.revenueList.length,
              itemBuilder: (context, index) {
                RevenueModel item = controller.revenueList[index];
                return ListTile(
                  leading: Icon(
                    Icons.album,
                    color: controller.paiChartSelectionDatas[index].color,
                  ),
                  title: Text('${item.tenCuaHang}'),
                  subtitle: Text('${convertMoney(item.doanhThu ?? 0.0)}'),
                );
              }
          )
        ],
      ),
      )
    );
  }
  Widget Chart(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: controller.paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeText.defaultPadding),
                Text(
                  "Tổng",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    height: 0.5,
                  ),
                ),
                Text("${convertMoney(controller.sum)}")
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.data,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List data;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: SizeText.defaultPadding,
        mainAxisSpacing: SizeText.defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: data[index]),
    );
  }
}
