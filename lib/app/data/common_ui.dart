import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';

class VerticalTextCell extends StatelessWidget {
  final String? title;
  final String? content;
  final bool? displayDivider;
  final bool? isUpperCase;
  final Widget? view;
  final IconData? trailingIcon;
  VerticalTextCell(
      {this.title,
        this.trailingIcon,
        this.content,
        this.displayDivider = true,
        this.view,
        this.isUpperCase = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: this.displayDivider! ? const EdgeInsets.all(0.5) : EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.isUpperCase! ? this.title!.toUpperCase() : this.title!,
                    style: TextStyle(color: Colors.black54, fontSize: 12.0)),
                SizedBox(
                  height: 4.0,
                ),
                Text(this.content!),
                SizedBox(
                  height: 4.0,
                ),
                view ??
                    Container(
                      width: 0.0,
                      height: 0.0,
                    )
              ],
            ),
          ),
          Visibility(
              visible: trailingIcon != null,
              child: Icon(
                trailingIcon,
                size: 16,
              ))
        ],
      ),
    );
  }
}
class HorizontalTextCell extends StatelessWidget {
  final String? title;
  final String? content;
  final bool? isUpperFirst;
  final bool? switchColor;
  HorizontalTextCell(
      {this.title,
        this.content,
        this.isUpperFirst = false,
        this.switchColor = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 40.0),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.all(0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(this.title![0].toUpperCase() + this.title!.substring(1),
              style: TextStyle(
                  fontSize: 12.0,
                  color: this.switchColor! ? Colors.black54 : Colors.black)),
          Spacer(),
          Text(this.content!,
              style: TextStyle(
                  color: this.switchColor! ? Colors.black : Colors.black54,
                  fontSize: 12.0))
        ],
      ),
    );
  }
}
class VerticalTextCellUnit extends StatelessWidget {
  final String? title;
  final String? content;
  final String? unit;
  final bool? isUpperCase;

  VerticalTextCellUnit(
      {this.title, this.content, this.unit, this.isUpperCase = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      margin: const EdgeInsets.all(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.title!,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              )),
          SizedBox(
            height: 4.0,
          ),
          Row(
            children: [
              Text(
                this.content!,
              ),
              Spacer(),
              Text(this.unit!,
                  style: TextStyle(
                    color: Colors.black54,
                  ))
            ],
          ),
          SizedBox(
            height: 4.0,
          )
        ],
      ),
    );
  }
}
class ControlTypeDropDown extends StatefulWidget {
  final Function? onChange;
  final int? initPosition;
  final bool isSpecial;
  final List<String>? menuList;
  ControlTypeDropDown(
      {this.initPosition,
        this.onChange,
        this.isSpecial = true,
        @required this.menuList});

  @override
  _ControlTypeDropDownState createState() => _ControlTypeDropDownState();
}

class _ControlTypeDropDownState extends State<ControlTypeDropDown> {
  @override
  Widget build(BuildContext context) {
    final widgets = widget.menuList!
        .map((x) => DropdownMenuItem(
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        child: Text(x, style: CommonStyle.normalTextBlack(context), overflow: TextOverflow.ellipsis,),
      ),
      value: widget.menuList!.indexOf(x),
    ))
        .toList();
    return Container(
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Color(0xffEEF3FF))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: widget.initPosition,
            focusColor: Color(0xffDBF4FF),
            iconEnabledColor: Theme.of(context).iconTheme.color,
            items: widgets,
            onChanged: (value) => this.widget.onChange!(value)),
      ),
    );
  }
}




class RefreshingView extends StatefulWidget {
  final Widget? child;
  final RefreshController? controller;
  var onLoadmore;
  var onRefresh;
  RefreshingView(
      {this.child, this.controller, required this.onLoadmore, required this.onRefresh});
  @override
  _RefreshingViewState createState() => _RefreshingViewState();
}

class _RefreshingViewState extends State<RefreshingView> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.controller!,
      enablePullUp: true,
      enablePullDown: true,
      onLoading: widget.onLoadmore,
      onRefresh: widget.onRefresh,
      header: ClassicHeader(
        failedText: 'Cập nhật thất bại',
        completeText: 'Cập nhật thành công',
        refreshingText: 'Đang cập nhật',
        releaseText: 'Cập nhật',
        idleText: 'Kéo để cập nhật danh sách',
      ),
      footer: CustomFooter(
        builder: (BuildContext? context, LoadStatus? mode) => FooterLayout(
          mode: mode,
        ),
      ),
      child: widget.child,
    );
  }
}

class FooterLayout extends StatelessWidget {
  LoadStatus? mode;
  FooterLayout({this.mode});
  @override
  Widget build(BuildContext context) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = Text("Kéo lên để xem tiếp");
    } else if (mode == LoadStatus.loading) {
      body = CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = Text("Cập nhật lỗi, xin thử lại");
    } else if (mode == LoadStatus.canLoading) {
      body = CircularProgressIndicator();
    } else {
      body = Text("Không còn dữ liệu");
    }
    return Container(
      height: 55.0,
      child: Center(child: body),
    );
  }
}
