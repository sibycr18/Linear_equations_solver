/* ToDo:
1. Function to find the transpose of the matrix
2. Function to multiply matrices
*********************

*Notes*:
Find transpose of the cofactor matrix of A and divide it by determinant of A we get adj A.
Multiply it with matrix B and we get the result.

*********************


***** Codes ******

// print Matrix A
for (int i = 0; i < row; i++) {
  for (int j = 0; j < row; j++) {
    print(A[i][j]);
  }
}

********************
  */

import 'dart:io';
import 'dart:math';

List<List<int>> A = []; //Matrix A

List<int> T = []; //Temporary array

List<int> B = []; //Matrix B

List<String> xyz = ["x", "y", "z"]; //Matrix for storing variables

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
  print("Determinant is ${determinant(A)}");
  num det = determinant(A);
  List<List<num>> transA = transpose(coFactor(A));
  List<List<num>> adjA = adjoint(transA, det);
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

  //Read matrix A and B
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < row; j++) {
      print("Enter value of ${constantslhs[i][j]}: ");
      T.add(int.parse(stdin.readLineSync()!));
    }
    A.add(T);
    T = [];
    print("Enter value of ${constantsrhs[k][i]}: ");
    B.add(int.parse(stdin.readLineSync()!));
  }

  print("");

  //printing linear equations
  print("Entered equations are:");
  if (row == 2) {
    for (int i = 0; i < row; i++) {
      print("${A[i][0]}${X[0]}+${A[i][1]}${X[1]}=${B[i]}");
    }
  } else {
    for (int i = 0; i < row; i++) {
      print("${A[i][0]}${X[0]}+${A[i][1]}${X[1]}+${A[i][2]}${X[2]}=${B[i]}");
    }
  }
}

List<List<int>> rcRemover(List<List<int>> F, int r, int c) {
  List<List<int>> E = [
    [0, 0],
    [0, 0]
  ];
  List<int> D = [];
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

num determinant(List<List<int>> A) {
  num result = 0;
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

List<List<num>> coFactor(List<List<int>> A) {
  List<num> C = [];
  List<List<num>> P = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];
  List<List<num>> Q = [
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

List<List<num>> adjoint(List<List<num>> coF, num det) {
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < row; j++) {
      coF[i][j] /= det;
    }
  }
  return coF;
}

List<List<num>> transpose(List<List<num>> C) {
  return [[]];
}
