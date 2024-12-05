#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <algorithm>

// hang me for my crimes
using namespace std;

unordered_map<int, unordered_set<int>> nums;

// returns tru if rhs is in the set of numbers related to the lhs. Nums based on rules.
bool lessThanHelper(int lhs, int rhs)
{
    // true if rhs is in the set of numbers that should come after lhs
    return nums[lhs].count(rhs);
}

int freak_it(ifstream &in, bool checkOrder)
{
    nums.clear();
    string line;

    // populate map w/ rules.
    while (getline(in, line) && !line.empty())
    {
        nums[stoi(line.substr(0, 2))].insert(stoi(line.substr(3, 2)));
    }

    // read in orders
    int sum = 0;
    while (getline(in, line))
    {
        vector<int> order;

        // taking full advantage of the fact that we only have 2 digits (conver comma separated sequence into an integer :P )
        for (size_t i = 0; i < line.size(); i += 3)
        {
            order.push_back(stoi(line.substr(i, 2)));
        }

        // sort using custom comparison
        vector<int> preSort = order;
        sort(order.begin(), order.end(), lessThanHelper);

        // if order changed and we care, add median of order to sum. Sex.
        if ((preSort != order) == checkOrder)
        {
            sum += order[order.size() / 2];
        }
    }
    return sum;
}

int main()
{
    ifstream file("freakput.txt");
    if (!file.is_open())
    {
        return 1;
    }

    cout << "Haha part 1: " << freak_it(file, false) << endl;

    file.clear();
    file.seekg(0, ios::beg);

    cout << "Part 2? Yeah, part 2: " << freak_it(file, true) << endl;
}
