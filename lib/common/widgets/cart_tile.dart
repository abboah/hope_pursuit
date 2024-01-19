import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:hope_pursuit/utils/font_styles.dart';

class CartTile extends StatefulWidget {
  final int defaultValue;
  final Function(int) onChangeValue;
  const CartTile({required this.onChangeValue, this.defaultValue = 1, Key? key})
      : assert(defaultValue >= 0),
        super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  late int _count;
  @override
  void initState() {
    super.initState();
    _count = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Container();
      } else {
        return Container(
          height: 120.h,
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteLight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100.h,
                width: 80.w,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/product/pic1.png')),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              Expanded(
                child: Container(
                  height: 90.h,
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Astylish Women Open Front Long Sleeve Chunky Knit Cardigan',
                        style: FontStyles.montserratRegular14(),
                      ),
                      // SizedBox(height: 20.0),
                      Text(
                        '\$89.99',
                        style: FontStyles.montserratBold14(),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(const Size(6, 6)),
                              ),
                              onPressed: () {
                                setState(() {
                                  _count += 1;
                                });
                                widget.onChangeValue(_count);
                              },
                              child: const Text(
                                "+",
                                style: TextStyle(fontSize: 22),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _count.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          OutlinedButton(
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(const Size(6, 6)),
                              ),
                              onPressed: () {
                                if (_count > 0) {
                                  setState(() {
                                    _count -= 1;
                                  });
                                  widget.onChangeValue(_count);
                                }
                              },
                              child: const Text(
                                "-",
                                style: TextStyle(fontSize: 22),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
/* RowPicker(
        title: "How many bathrooms?",
        defaultValue: 2,
        onChangeValue: (v) {
           setState(() {
              _bathRooms = v;
          });
      },
) -
class RowPicker extends StatefulWidget {
  final String title;
  final int defaultValue;
  final Function(int) onChangeValue;

  const RowPicker(
      {required this.title,
      required this.onChangeValue,
      this.defaultValue = 2,
      Key? key})
      : assert(defaultValue >= 0),
        super(key: key);

  @override
  State<RowPicker> createState() => _RowPickerState();
}

class _RowPickerState extends State<RowPicker> {
  late int _count;
  @override
  void initState() {
    super.initState();
    _count = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.title),
        const Spacer(),
        Text(_count.toString()),
        const SizedBox(
          width: 15,
        ),
        Row(
          children: [
            OutlinedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(10, 10)),
                ),
                onPressed: () {
                  setState(() {
                    _count += 1;
                  });
                  widget.onChangeValue(_count);
                },
                child: const Text(
                  "+",
                  style: TextStyle(fontSize: 22),
                )),
            OutlinedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(10, 10)),
                ),
                onPressed: () {
                  if (_count > 0) {
                    setState(() {
                      _count -= 1;
                    });
                    widget.onChangeValue(_count);
                  }
                },
                child: const Text(
                  "-",
                  style: TextStyle(fontSize: 22),
                ))
          ],
        )
      ],
    );
  }
}
*/

