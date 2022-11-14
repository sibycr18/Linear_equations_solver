import 'dart:io';
import 'dart:math';

List<List<double>> A = []; //Matrix A

List<List<double>> B = []; //Matrix B

List<String> xyz = ["x", "y", "z"]; //List for storing variables

List<List<String>> constantslhs = [
  ["a1", "b1", "c1"],
  ["a2", "b2", "c2"],
  ["a3", "b3", "c3"]
];

List<List<String>> constantsrhs = [
  ["c1", "c2"],
  ["d1", "d2", "d3"]
];

int row = 0;

void main() {
  inputEquations(); //Read equations
  print("");
  double det = determinant(A);

  //handling exception when determinant is 0
  if (det == 0) {
    print("Math error... No solution\n");
  } else {
    List<List<double>> coF = coFactor(A);
    List<List<double>> transA = transpose(coF);
    List<List<double>> adjA = adjoint(transA, det);
    List<List<double>> X = multiply(adjA, B);

    print("Solution:");
    for (int i = 0; i < X.length; i++) {
      print("${xyz[i]} = ${X[i][0]}");
    }
  }
}

void inputEquations() {
  print("Enter number of variables (2 or 3): ");
  row = int.parse(
      stdin.readLineSync()!); //Reading row and column value of matrix A

  List<String> X = []; //Extracting required variables
  for (int i = 0; i < row; i++) {
    X.add(xyz[i]);
  }

  //to know whether to use c or d as variable for matrix B
  int k = 0;
  if (row == 2) {
    k = 0;
  } else {
    k = 1;
  }
  List<double> t1 = []; //Temporary array
  List<double> t2 = []; //Temporary array

  //Read matrix A and B
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < row; j++) {
      print("Enter value of ${constantslhs[i][j]}: ");
      t1.add(double.parse(stdin.readLineSync()!));
    }
    A.add(t1);
    t1 = [];
    print("Enter value of ${constantsrhs[k][i]}: ");
    t2.add(double.parse(stdin.readLineSync()!));
    B.add(t2);
    t2 = [];
  }

  print("");

  //printing linear equations
  print("Entered equations are:");
  if (row == 2) {
    for (int i = 0; i < row; i++) {
      print("${A[i][0]}${X[0]} + ${A[i][1]}${X[1]} = ${B[i][0]}");
    }
  } else {
    for (int i = 0; i < row; i++) {
      print(
          "${A[i][0]}${X[0]} + ${A[i][1]}${X[1]} + ${A[i][2]}${X[2]} = ${B[i][0]}");
    }
  }
}

List<List<double>> rcRemover(List<List<double>> F, int r, int c) {
  List<List<double>> E = [
    [0, 0],
    [0, 0]
  ];
  List<double> D = [];
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < row; j++) {
      if (i != r && j != c) {
        D.add(F[i][j]);
      }
    }
  }
  int m = 0;
  if (F.length == 3) {
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        E[i][j] = D[m];
        m++;
      }
    }
    return E;
  } else {
    E[0][0] = D[0];
    return E;
  }
}

double determinant(List<List<double>> A) {
  double result = 0;
  if (A.length == 3) {
    for (int i = 0; i < 3; i++) {
      result += (pow(-1, i) * A[0][i]) * determinant(rcRemover(A, 0, i));
    }
  } else {
    if (A.length == 2) {
      return ((A[0][0] * A[1][1]) - (A[0][1] * A[1][0]));
    } else {
      return A[0][0];
    }
  }
  return result;
}

List<List<double>> coFactor(List<List<double>> A) {
  List<double> C = [];
  List<List<double>> P = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];
  List<List<double>> Q = [
    [0, 0],
    [0, 0]
  ];
  if (A.length == 3) {
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row; j++) {
        C.add(pow(-1, (i + j)) * determinant(rcRemover(A, i, j)));
      }
    }
    int m = 0;
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row; j++) {
        P[i][j] = C[m];
        m++;
      }
    }
    return P;
  } else {
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row; j++) {
        // print(pow(-1, (i + j)) * rcRemover(A, i, j)[0][0]);
        C.add(pow(-1, (i + j)) * rcRemover(A, i, j)[0][0]);
      }
    }
    int m = 0;
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row; j++) {
        Q[i][j] = C[m];
        m++;
      }
    }
    return Q;
  }
}

List<List<double>> adjoint(List<List<double>> coF, double det) {
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < row; j++) {
      coF[i][j] /= det;
    }
  }
  return coF;
}

List<List<double>> transpose(List<List<double>> C) {
  List<List<double>> G = [];
  List<double> T = [];
  for (int i = 0; i < C.length; i++) {
    for (int j = 0; j < C.length; j++) {
      T.add(C[j][i]);
    }
    G.add(T);
    T = [];
  }
  return G;
}

List<List<double>> multiply(List<List<double>> matA, List<List<double>> matB) {
  int r1 = matA.length;
  int c1 = matA[0].length;
  int r2 = matB.length;
  int c2 = matB[0].length;
  List<List<double>> result = [];
  List<double> T = [];
  double temp = 0;

  if (r2 == c1) {
    //to check if matrix multiplication is possible or not
    for (int i = 0; i < r1; ++i) {
      for (int j = 0; j < c2; ++j) {
        for (int k = 0; k < c1; ++k) {
          temp += matA[i][k] * matB[k][j];
        }
        T.add(temp);
        temp = 0;
      }
      result.add(T);
      T = [];
    }
    return result;
  } else {
    print("Matrix multiplication not possible.");
    return [[]];
  }
}
