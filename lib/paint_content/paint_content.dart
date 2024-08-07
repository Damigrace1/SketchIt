import 'dart:ui';

class PaintContent {
  // Define properties of PaintContent
  final Offset offset;
  final Paint paint;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final Color color;
  final StrokeCap strokeCap;
  final List<Offset> points;

  // Constructor
  PaintContent({
    required this.offset,
    required this.paint,
    required this.paintingStyle,
    required this.strokeWidth,
    required this.color,
    required this.strokeCap,
    required this.points,
  });

  // Static method to create PaintContent from JSON
  static PaintContent fromJson(Map<String, dynamic> json) {
    // Implement the logic to create PaintContent from JSON
    return PaintContent(
      // Assign values from JSON to properties
      offset: Offset(json['offsetX'] ?? 0.0, json['offsetY'] ?? 0.0),
      paint: Paint()
        ..style = PaintingStyle.values[json['paintingStyle'] ?? 0]
        ..strokeWidth = json['strokeWidth']?.toDouble() ?? 1.0
        ..color = Color(json['color'] ?? 0xFF000000)
        ..strokeCap = StrokeCap.values[json['strokeCap'] ?? 0],
      paintingStyle: PaintingStyle.values[json['paintingStyle'] ?? 0],
      strokeWidth: json['strokeWidth']?.toDouble() ?? 1.0,
      color: Color(json['color'] ?? 0xFF000000),
      strokeCap: StrokeCap.values[json['strokeCap'] ?? 0],
      points: (json['points'] as List<dynamic>?)
              ?.map((point) => Offset(
                  point['x']?.toDouble() ?? 0.0, point['y']?.toDouble() ?? 0.0))
              .toList() ??
          [],
    );
  }

  // Method to convert PaintContent to JSON
  Map<String, dynamic> toJson() {
    return {
      'offsetX': offset.dx,
      'offsetY': offset.dy,
      'paintingStyle': paintingStyle.index,
      'strokeWidth': strokeWidth,
      'color': color.value,
      'strokeCap': strokeCap.index,
      'points': points.map((point) => {'x': point.dx, 'y': point.dy}).toList(),
    };
  }
}
