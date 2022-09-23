/* ToDo:
3. Function to multiply matrices
*********************

*Notes*:
Multiply adjA with matrix B and we get the result.

*********************


****** Codes ******

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

List<List<double>> A = []; //Matrix A

List<List<double>> B = []; //Matrix B

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
  print(A);
  print("");
  double det = determinant(A);
  print("Determinant is $det");
  print("");
  List<List<double>> coF = coFactor(A);
  print(coF);
  print("");
  List<List<double>> transA = transpose(coF);
  print(transA);
  print("");
  List<List<double>> adjA = adjoint(transA, det);
  print(adjA);
  print("");
  print(B);
  print("");
  List<List<double>> xyz = multiply(adjA, B);
  print(xyz);

  // List<List<double>> K = [
  //   [2, 4, 6],
  //   [2, 3, 5],
  //   [4, 8, 9]
  // ];
  // List<List<double>> L = [
  //   [2, 3, 4],
  //   [5, 6, 1],
  //   [2, 3, 4]
  // ];
  // print(multiply(K, L));
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
  print(C.length);
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
  // print(matA);
  // print(matB);
  int r1 = matA.length;
  int c1 = matA[0].length;
  int r2 = matB.length;
  int c2 = matB[0].length;
  List<List<double>> result = [];
  List<double> T = [];
  print(r1);
  print(c1);
  print(r2);
  print(c2);
  double temp = 0;
  if (r2 == c1) {
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
