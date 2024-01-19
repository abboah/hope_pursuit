import 'package:flutter/material.dart';
import 'package:hope_pursuit/utils/app_colors.dart';

class ToggleTextBtnsFb1 extends StatefulWidget {
  final List<Text> texts;
  final Function(int) selected;
  final Color selectedColor;
  final bool multipleSelectionsAllowed;
  final bool stateContained;
  final bool canUnToggle;
  const ToggleTextBtnsFb1({
    super.key,
    required this.texts,
    required this.selected,
    this.selectedColor = AppColors.primaryLight,
    this.stateContained = true,
    this.canUnToggle = false,
    this.multipleSelectionsAllowed = false,
  });

  @override
  _ToggleTextBtnsFb1State createState() => _ToggleTextBtnsFb1State();
}

class _ToggleTextBtnsFb1State extends State<ToggleTextBtnsFb1> {
  late List<bool> isSelected = [];
  @override
  void initState() {
    for (var e in widget.texts) {
      isSelected.add(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          color: Colors.black.withOpacity(0.60),
          selectedColor: widget.selectedColor,
          selectedBorderColor: widget.selectedColor,
          fillColor: widget.selectedColor.withOpacity(0.08),
          splashColor: widget.selectedColor.withOpacity(0.12),
          hoverColor: widget.selectedColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(4.0),
          isSelected: isSelected,
          highlightColor: Colors.transparent,
          onPressed: (index) {
            // send callback
            widget.selected(index);
            // if you wish to have state:
            if (widget.stateContained) {
              if (!widget.multipleSelectionsAllowed) {
                final selectedIndex = isSelected[index];
                isSelected = isSelected.map((e) => e = false).toList();
                if (widget.canUnToggle) {
                  isSelected[index] = selectedIndex;
                }
              }
              setState(() {
                isSelected[index] = !isSelected[index];
              });
            }
          },
          children: widget.texts
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: e,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// ToggleTextBtnsFb1(texts: [Text("Trending"), Text("Featured"), Text("Top 10")],selected: (i)=>print(i),)