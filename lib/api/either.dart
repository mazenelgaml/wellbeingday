abstract class Either<L, R> {
  const Either();

  T fold<T>(T Function(L left) leftFunc, T Function(R right) rightFunc);

  bool get isLeft;

  bool get isRight;

  static Left<L, R> left<L, R>(L value) => Left(value);

  static Right<L, R> right<L, R>(R value) => Right(value);
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  T fold<T>(T Function(L left) leftFunc, T Function(R right) rightFunc) {
    return leftFunc(value);
  }

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  T fold<T>(T Function(L left) leftFunc, T Function(R right) rightFunc) {
    return rightFunc(value);
  }

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;
}
