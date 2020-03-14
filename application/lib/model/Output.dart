class Output<T1> {
  Output(this._output);
  T1 _output;

  void setOutput(T1 input) {
    _output = input;
  }

  T1 getOutput() {
    return _output;
  }
}
