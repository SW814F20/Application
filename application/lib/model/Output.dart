class Output<T> {
  Output(this._output);
  T _output;

  void setOutput(T input) {
    _output = input;
  }

  T getOutput() {
    return _output;
  }
}
