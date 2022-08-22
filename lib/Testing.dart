import 'package:flutter/material.dart';

class FreshProductsShow extends StatefulWidget {
  const FreshProductsShow(
      {Key? key, required this.pageHeight, required this.pageWidth})
      : super(key: key);
  final double? pageHeight;
  final double? pageWidth;
  @override
  _FreshProductsShowState createState() => _FreshProductsShowState();
}

class _FreshProductsShowState extends State<FreshProductsShow> {
  ScrollController _childScrollController = ScrollController();
  ScrollController _parentScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _parentScrollController,
      child: Column(
        children: [
          Container(
            color: Colors.red,
            height: 300,
          ),
          Container(
            height: widget.pageHeight! / 1.3,
            width: widget.pageWidth,
            child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    debugPrint('Reached the bottom');
                    _parentScrollController.animateTo(
                        _parentScrollController.position.maxScrollExtent,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn);
                  } else if (notification.metrics.pixels ==
                      notification.metrics.minScrollExtent) {
                    debugPrint('Reached the top');
                    _parentScrollController.animateTo(
                        _parentScrollController.position.minScrollExtent,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn);
                  }
                }
                return true;
              },
              child: ListView.builder(
                controller: _childScrollController,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      width: widget.pageWidth,
                      // height: pageHeight / 7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.rtl,
                        children: [
                          Image.asset(
                            "images/peper.png",
                            width: widget.pageWidth! / 4,
                            height: widget.pageHeight! / 8,
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: widget.pageWidth! / 6.3),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.pageWidth! / 10,
                                      top: widget.pageHeight! / 45),
                                  child: Text(
                                    "peper",
                                    style: TextStyle(
                                        fontSize: widget.pageHeight! / 48,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff54595F)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    elevation: 5,
                  );
                },
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
          Container(
            color: Colors.red,
            height: 300,
          ),
        ],
      ),
    );
  }
}