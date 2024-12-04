// AOC Day 4 part 2

#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

// The worms.
const int directions[8][2] =
{
    {0, 1},    // Right
    {1, 0},    // Bottom
    {1, 1},    // Bottom Right
    {1, -1},   // Bottom Left
    {0, -1},   // Left
    {-1, 0},   // Top
    {-1, -1},  // Top Left
    {-1, 1}    // TopRight
};

// Can we find the XMAS? Maybe.
bool check_word(const vector<string>& grid, int start_row, int start_col, int dir_row, int dir_col, const string& target)
{
    int target_length = target.length();
    int max_row = grid.size();
    int max_col = grid[0].size();

    // Calculate the final position of the word in this direction
    int end_row = start_row + (target_length - 1) * dir_row;
    int end_col = start_col + (target_length - 1) * dir_col;

    // Check boundary conditions early
    if (end_row < 0 || end_row >= max_row || end_col < 0 || end_col >= max_col)
    {
        return false;
    }

    // Check each character in the target
    for (int i = 0; i < target_length; i++)
    {
        int new_row = start_row + i * dir_row;
        int new_col = start_col + i * dir_col;

        if (grid[new_row][new_col] != target[i])
        {
            return false;
        }
    }
    return true;
}

int count_target_in_grid(const vector<string>& grid, const string& target)
{
    int count = 0;
    int num_rows = grid.size();
    int num_cols = grid[0].size();

    // For loops time.
    for (int row = 0; row < num_rows; row++)
    {
        for (int col = 0; col < num_cols; col++)
        {
            // check all 8 happy little directions
            for (int direction = 0; direction < 8; direction++)
            {
                if (check_word(grid, row, col, directions[direction][0], directions[direction][1], target))
                {
                    count++;
                }
            }
        }
    }
    return count;
}

int main()
{
    // From the file we shall read
    ifstream file("jizzmas.txt");
    if (!file.is_open())
    {
        cerr << "Error: Could not open the file." << endl;
        return 1;
    }

    vector<string> grid;
    string line;

    while (getline(file, line))
    {
        grid.push_back(line);
    }

    file.close();

    string target = "XMAS";  // It's XMAS time
    int result = count_target_in_grid(grid, target);
    cout << "She X on my MAS " << result << " times." << endl;

    return 0;
}
