### Elijah Ren - 116253293

# Test Cases

## Part A - Drawing with MIPS:

Test 1:\
Triangle(0) or Square(1) or Pyramid (2)?	0\
Required size?	3

Output:
```
*
**
***
```


Test 2:\
Triangle(0) or Square(1) or Pyramid (2)?	1\
Required size?	6

Output:
```
******
******
******
******
******
******
```


Test 3:\
Triangle(0) or Square(1) or Pyramid (2)?	0\
Required size?	6

Output:
```
*
**
***
****
*****
******
```


Test 4:\
Triangle(0) or Square(1) or Pyramid (2)?	2\
Required size?	4

Output:
```
   *
  * *
 * * *
* * * *
```


Test 5:\
Triangle(0) or Square(1) or Pyramid (2)?	2\
Required size?	7

Output:
```
      *
     * *
    * * *
   * * * *
  * * * * *
 * * * * * *
* * * * * * *
```


## Part B - Swapping data between arrays
Test 1:\
A = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19}\
B = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20}

Output:\
2 1|4 3|6 5|8 7|10 9|12 11|14 13|16 15|18 17|20 19|


Test 2:\
A = {1, 5, 9, 13, 17, 2, 6, 10, 14, 18}\
B = {3, 7, 11, 15, 19, 4, 8, 12, 16, 20}

Output:\
3 1|7 5|11 9|15 13|19 17|4 2|8 6|12 10|16 14|20 18|


Test 3:\
A = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}\
B = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2}

Output:\
2 1|2 1|2 1|2 1|2 1|2 1|2 1|2 1|2 1|2 1|


Test 4:\
A = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}\
B = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

Output:\
0 0|0 0|0 0|0 0|0 0|0 0|0 0|0 0|0 0|0 0|


Test 5:\
A = {5, 8, 2, 4, 8, 4, 1, 6, 3, 2}\
B = {3, 7, 2, 6, 7, 2, 5, 3, 9, 1}

Output:\
3 5|7 8|2 2|6 4|7 8|2 4|5 1|3 6|9 3|1 2|


## Part C - Sorting in MIPS Assembly Language
Test 1:\
myArray = {100, 95, 35, 30, 1450, 450, 20, 8, 765, 720}

Output:\
Before sorting: 100 95 35 30 1450 450 20 8 765 720\
After sorting: 8 20 30 35 95 100 450 720 765 1450

Test 2:\
myArray = {5, 4, 3, 2, 1}

Output:\
Before sorting: 5 4 3 2 1\
After sorting: 1 2 3 4 5

Test 3:\
myArray = {2, 5, 8, 11, 14, 17, 20}

Output:\
Before sorting: 2 5 8 11 14 17 20\
After sorting: 2 5 8 11 14 17 20

Test 4:\
myArray = {5, 20, 2, 11, 17, 8, 14}

Output:\
Before sorting: 5 20 2 11 17 8 14\
After sorting: 2 5 8 11 14 17 20

Test 5:\
myArray = {2}

Output:\
Before sorting: 2\
After sorting: 2


## Part D - Matrix Multiplication in MIPS Assembly Language
