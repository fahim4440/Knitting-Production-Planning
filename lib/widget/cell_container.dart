import 'package:flutter/material.dart';

IntrinsicWidth CellContainer(String text) {
  return IntrinsicWidth(
    child: Text(text, overflow: TextOverflow.ellipsis,),
  );
}
