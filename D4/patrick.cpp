// AOC Day 4 part 2

#include <iostream>
#include <fstream>
#include <vector>
#include <string>

// I could be hung for this
using namespace std;

// do we live mas? We mas find out.
bool live_mas(const vector<string>& grid, int row, int col)
{
    // All those sexy sexy diagonals around A
    char top_left = grid[row - 1][col - 1];
    char top_right = grid[row - 1][col + 1];
    char bottom_left = grid[row + 1][col - 1];
    char bottom_right = grid[row + 1][col + 1];

    string diagonal1 = string(1, top_left) + grid[row][col] + bottom_right;
    string diagonal2 = string(1, top_right) + grid[row][col] + bottom_left;

    // These diagonals are only gonna be 'MAS' or 'SAM'.
    return (diagonal1 == "MAS" || diagonal1 == "SAM") && (diagonal2 == "MAS" || diagonal2 == "SAM");
}

int main()
{
    // do we find the x mas in the jizz mas?
    string file_path = "jizzmas.txt";
    ifstream input_file(file_path);

    vector<string> grid;
    string line;

    while (getline(input_file, line))
    {
        grid.push_back(line);
    }

    int num_rows = grid.size();
    int num_cols = grid[0].size();
    int pattern_count = 0;

    // scan accross tha whole grid (that can have a valid center)
    for (int row = 1; row < num_rows - 1; ++row)
    {
        for (int col = 1; col < num_cols - 1; ++col)
        {
            // 'A' denotes the center of our X. The cream to our pie.
            if (grid[row][col] == 'A')
            {
                pattern_count += live_mas(grid, row, col);
            }
        }
    }

    cout << "I got da uhhhhhhhhhh " << pattern_count << " mas" << endl;

    return 0;
}
