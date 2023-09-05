import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/utils/common_widgets/widget_size_offset_wrapper.dart';

class GetSizeWidget extends StatefulWidget {
  const GetSizeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GetSizeWidget> createState() => _GetSizeWidgetState();
}

class _GetSizeWidgetState extends State<GetSizeWidget> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    return WidgetSizeOffsetWrapper(
        onSizeChange: (Size size) {
          setState(() {
            this.size = size;
            // print('Size: ${size.width}, ${size.height}');
          });
        },
        child: Transform.translate(
          offset: Offset(0, -(size?.height ?? 0)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.10),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Efficiency Index",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(.75)),
                )
              ],
            ),
          ),
        ));
  }
}
