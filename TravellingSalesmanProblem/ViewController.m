//
//  ViewController.m
//  TravellingSalesmanProblem
//
//  Created by ROB on 11/9/21.
//  Copyright © 2021 OrbitusRobotics. All rights reserved.
//

#import "ViewController.h"


//==============================================================================
// Functions to work with sets
//==============================================================================

/// Type that represents set of vertices
typedef int vertex_set;

/// Checks whether given element is in the set.
/// \return non-zero if element is in the set and zero otherwise.
int contains(vertex_set set, int elem);

/// Creates a set out of a single element
/// \return Set {elem}
vertex_set set_of(int elem);

/// Adds given element to the set
/// \return New set with given element added to set
vertex_set include(vertex_set set, int elem);

/// Removes given element from the set
/// \return New set with given element removed from set (if it was there)
vertex_set exclude(vertex_set set, int elem);

/// Computes intersection of two sets
/// \return New set that is result of intersection of argument sets
vertex_set intersection(vertex_set set1, vertex_set set2);

/// Computes union of two sets
/// \return New set that is result of union of argument sets
vertex_set merge(vertex_set set1, vertex_set set2);

/// Computes difference of two sets
/// \return New set that is set1 - set2
vertex_set difference(vertex_set set1, vertex_set set2);



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


//
//  Controller.m
//  TSP
//
//  Created by Rodolfo Aramayo on 8/21/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

- (int) sizeOfSet:(int)mySet
{
    int aSize = 0;
    int i;
    for (i = 0; i < 10; i++ )
        if ((mySet >> i) % 2 == 1)
            aSize++;
    return aSize;
}

- (void) awakeFromNib
{
    int temp=0;
    int n = 5;
    int i,j;
    int s,S,MAX_INT = 99999;
    int d[n][n];
    int C[1<<n][n];
    
    for (i = 0;i < n;i++)
        for (j = 0; j < n; j++)
            d[i][j] = 1;
    
    
    for (i = 0;i < (1<<n);i++)
        for (j = 0; j < n; j++)
            C[i][j] = MAX_INT;
    
    
    NSLog(@"test %i", d[4][4]);
    
    for( s = 1; s <= n; s++) {
        for( S = 0; S < (1<<n); S++) {
            if ([self sizeOfSet:S] == s && contains(S,0)) {
                C[S][0] = MAX_INT;
                //NSLog(@"S = %i J = %i size = %i",S,j,C[S][j]);
                for(j = 1; j < n; j++) {
                    if (contains(S,j)) {
                        if (s == 2) {
                            C[S][j] = d[0][j];
                        } else {
                            int min = MAX_INT;
                            for( i = 1; i < n; i++) {
                                if (i != j) {
                                    if (C[exclude(S,j)][i]+d[i][j] < min)
                                    {
                                        min = C[exclude(S,j)][i]+d[i][j];
                                    }
                                    //NSLog(@"S=%i J=%i exclude=%i",S,j,exclude(S,j));
                                    //NSLog(@"S = %i J = %i I = %i size = %i",S,j,i,C[S][j]);
                                }
                            }
                            C[S][j] = min;
                            //NSLog(@"S = %i J = %i size = %i",S,j,C[S][j]);
                        }
                        NSLog(@"S = %i J = %i size = %i",S,j,C[S][j]);
                    }
                }
            }
        }
    }
    //NSLog(@"The shortest path is:");
    
    i = 0;
    j = 0;
    int shortestPath[n];
    int fromTheTop = n-1;
    int myCValue = (1<<n)-1;
    int removeThisBit;
    NSLog(@"myCValue = %i",myCValue); //Check that it starts at 31
    
    for (j = 0; j < n; j++)
    {
        s = MAX_INT;
        for (i = 0; i < n; i++)
        {
            if (C[myCValue][i] + d[i][0] < s)
            {
                s = C[myCValue][i] + d[i][0];
                shortestPath[fromTheTop] = n;
                removeThisBit = i;
            }
            fromTheTop--;
        }
        myCValue = exclude(myCValue, removeThisBit);
        
    }
    //NSLog(@"The shortest path is: %i, %i", i,n);
    //Compute minimum when S = 31;
}


//------------------------------------------------------------------------------

int contains(vertex_set set, int elem)
{
    assert(elem >= 0 && elem < sizeof(vertex_set)*8); // elem is out of universe
    return (set & (1 << elem)) != 0;
}

//------------------------------------------------------------------------------

vertex_set set_of(int elem)
{
    assert(elem >= 0 && elem < sizeof(vertex_set)*8); // elem is out of universe
    return 1 << elem;
}

//------------------------------------------------------------------------------

vertex_set include(vertex_set set, int elem)
{
    assert(elem >= 0 && elem < sizeof(vertex_set)*8); // elem is out of universe
    return set | (1 << elem);
}

//------------------------------------------------------------------------------

vertex_set exclude(vertex_set set, int elem)
{
    assert(elem >= 0 && elem < sizeof(vertex_set)*8); // elem is out of universe
    return set & ~(1 << elem);
}

//------------------------------------------------------------------------------

vertex_set intersection(vertex_set set1, vertex_set set2)
{
    return set1 & set2;
}

//------------------------------------------------------------------------------

vertex_set merge(vertex_set set1, vertex_set set2)
{
    return set1 | set2;
}

//------------------------------------------------------------------------------

vertex_set difference(vertex_set set1, vertex_set set2)
{
    return set1 & ~set2;
}

//------------------------------------------------------------------------------


@end

