import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// A button for the Giraf application.
class Button extends StatefulWidget {
  /// A button for the Giraf application.
  /// The button can contain some text and an icon both of which are optional.
  /// isEnabled determines whether the button is enabled or disabled by default.
  /// isEnabledStream is a stream which is listened to, to update the
  /// enabled/disabled state of the button.
  const Button({
    Key key,
    this.text,
    this.icon,
    this.width,
    this.height = 40.0,
    @required this.onPressed,
    this.isEnabled = true,
    this.isEnabledStream,
  }) : super(key: key);

  /// The text placed at the center of the button.
  final String text;

  /// The icon placed next to the text on the button.
  final ImageIcon icon;

  /// The width of the button.
  final double width;

  /// The height of the button.
  final double height;

  /// The function to be called when the button is pressed.
  /// The function must be a void funtion with no input parameters.
  /// If this is set to null, the button will be disabled.
  final VoidCallback onPressed;

  /// Determines whether the button is enabled or disabled by default. If
  /// isEnabledStream is also supplied, the latest emitted item from the stream
  /// will determine whether the button is enabled. If the stream emits a null
  /// value, isEnabled will be used instead.
  final bool isEnabled;

  /// A stream which tells whether the button should be enabled or disabled.
  /// If the stream emits a null value, the value of isEnabled will be used
  /// instead.
  final Observable<bool> isEnabledStream;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  void initState() {
    // If onPressed callback is null, the button should be disabled.
    _isEnabled = widget.isEnabled && widget.onPressed != null;
    _isPressed = false;
    if (widget.isEnabledStream != null) {
      _isEnabledSubscription =
          widget.isEnabledStream.listen(_handleIsEnabledStreamEvent);
    }
    super.initState();
  }

  static const Gradient _gradientDefault = LinearGradient(
      colors: <Color>[Color(0xFFFFCD59), Color(0xFFFF9D00)],
      begin: Alignment(0.0, -1.0),
      end: Alignment(0.0, 1.0));

  static const Gradient _gradientPressed = LinearGradient(
      colors: <Color>[Color(0xFFD4AD2F), Color(0xFFFF9D00)],
      begin: Alignment(0.0, -1.0),
      end: Alignment(0.0, 1.0));

  static const Gradient _gradientDisabled = LinearGradient(
      colors: <Color>[Color(0x46FFCD59), Color(0xA6FF9D00)],
      begin: Alignment(0.0, -1.0),
      end: Alignment(0.0, 1.0));

  static const Color _borderDefault = Color(0xFF8A6E00);
  static const Color _borderPressed = Color(0xFF493700);
  static const Color _borderDisabled = Color(0xA68A6E00);

  bool _isPressed;
  bool _isEnabled;
  StreamSubscription<bool> _isEnabledSubscription;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: _isEnabled
              ? (_isPressed ? _gradientPressed : _gradientDefault)
              : _gradientDisabled,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: _isEnabled
                  ? (_isPressed ? _borderPressed : _borderDefault)
                  : _borderDisabled,
              width: 1.2),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: _buildWidgetsOnButton()),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (_isEnabled) {
      setState(() => _isPressed = true);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_isEnabled) {
      widget.onPressed();
      // On a quick tap the pressed state is not shown, because the state
      // changes too fast, hence we introduce a delay.
      _timer = Timer(const Duration(milliseconds: 100),
          () => setState(() => _isPressed = false));
    }
  }

  void _onTapCancel() {
    if (_isEnabled) {
      setState(() => _isPressed = false);
    }
  }

  void _handleIsEnabledStreamEvent(bool value) {
    // If a null value is emitted reset enabled state to default.
    value ??= widget.isEnabled;

    // If onPressed callback is null, the button should be disabled.
    if (widget.onPressed == null) {
      value = false;
    }

    // Only update state if the new value is different from the previous.
    if (value != _isEnabled) {
      setState(() {
        _isEnabled = value;
      });
    }
  }

  Widget _buildWidgetsOnButton() {
    const TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 20);

    if (widget.text != null && widget.icon != null)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.icon,
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.text,
            style: textStyle,
          ),
        ],
      );
    else if (widget.text != null)
      return Center(
          child: Text(
        widget.text,
        style: textStyle,
      ));
    else if (widget.icon != null) {
      return Center(
        child: widget.icon,
      );
    }

    return null;
  }

  @override
  void dispose() {
    _isEnabledSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
