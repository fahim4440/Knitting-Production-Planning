import 'package:flutter/material.dart';

IntrinsicWidth HeadCellContainer(String text) {
  return IntrinsicWidth(
    child: Text(text, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold),),
  );
}