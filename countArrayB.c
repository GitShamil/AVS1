extern int A[];
extern double B[];
void countArrayB(int length) {
    int j;
    for (j = 0; j < length; ++j) {
        B[j] = 9.82 * A[j] * A[j] / 2.0;
    }
}
