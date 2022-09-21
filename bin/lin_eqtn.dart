/* ToDo:
1. Function to find the cofactor of the matrix
2. Function to find the transpose of the matrix
3. Function to multiply matrices
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
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 2; j++) {
      E[i][j] = D[m];
      m++;
    }
  }

  return E;
}

num determinant(List<List<int>> A) {
//print Matriz A
//   for (int i = 0; i < row; i++) {
//     for (int j = 0; j < row; j++) {
//       print(A[i][j]);
//     }
//   }

  num result = 0;
  if (row == 3) {
    for (int i = 0; i < row; i++) {
      result += (pow(-1, i) * A[0][i]) * determinant(rcRemover(A, 0, i));
    }
  } else {
    return ((A[0][0] * A[1][1]) - (A[0][1] * A[1][0]));
  }
  return result;
}

void coFactor(List<List<int>> A) {
  List<List<num>> C = [];
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < row; j++) {
      C[i][j] = pow(-1, (i + j)) * determinant(rcRemover(A, i, j));
    }
  }
}
