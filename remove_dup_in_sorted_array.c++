class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        int i=0;
        if( nums.size() == 0)
            return i;
        for(int n : nums){
            if(n > nums[i]){
                nums[i+1]=n;
                i++;
            }
        }
        return i+1;
    }
};

/* this is a very cool idea, fully leveraging the monotonically increasing attribute, 
 * a similar technique in quicksort/quickselect, where you have a pivot marking the smallest value 
 * seen sofar.
 */
