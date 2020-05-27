class Helpers{
  static bool toBool(data){
    if(data is int){
      return data > 0;
    }else if(data is String){
      return data.toLowerCase() == 'true';
    }else if(data is bool){
      return data;
    }else {
      throw ArgumentError('The provided data cannot be casted to bool');
    }
  }
}