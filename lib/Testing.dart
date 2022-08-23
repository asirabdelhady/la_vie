/*
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 160.0,
                width: 160.0,
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.cubit.productModel!.data![widget.index].name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        '${widget.cubit.productModel!.data![widget.index].price.toString()} EGP',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      defaultButtom(
                        function: () {},
                        text: 'Add To Cart',
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -33,
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://lavie.orangedigitalcenteregypt.com${widget.cubit.productModel!.data![widget.index].imageUrl!}',
                        // في حالة التحميل
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(
                              value: progress.progress,
                            ),
                        // في حالة الخطا
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        if (count <= 1) return;
                        count--;
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: const Icon(
                          Icons.remove,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        count++;
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
