#include "stack.h"
#include<stdio.h>
#include<stdlib.h>
#include"curve.h"

//typedef float* point;
typedef Curve* point;



float complete_distance(point v1, point v2);
float distance(point v1, point v2, float upper_bound);

int getNofDistanceCalls();
//v_array<point > parse_points(FILE *input);

v_array<point > parse_points( Curves& curves );

void print(point &p);
