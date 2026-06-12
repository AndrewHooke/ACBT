#include <iostream>

using namespace std;

extern "C" void __cdecl CalcValues(int n, double startX, double step);

int main()
{
    setlocale(LC_ALL, "rus");
    int n;
    double startX;
    double step;

    cout << "¬ведите n: ";
    cin >> n;

    cout << "¬ведите начальный x: ";
    cin >> startX;

    cout << "¬ведите шаг: ";
    cin >> step;

    CalcValues(n, startX, step);

    return 0;
}