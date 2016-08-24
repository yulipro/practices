class Solution {
public:
    int search(vector<int>& nums, int target) {
        if(!nums.size())
            return -1;
        int low = 0;
        int high = nums.size()-1 ;
        while(low < high){
            int mid= low + ( (high-low )>>1 );
            if( nums[mid] == target)
                return mid;
            if( nums[low] == target)
                return low;
        
            if( nums[high] == target)
                return high;
            
            if(nums[mid]< nums[high]){
                if(target>nums[mid] && target < nums[high])
                    low=mid+1;
                else
                    high=mid-1;
            }else{
                if( target <nums[mid] && target > nums[low])
                    high=mid-1;
                else
                    low =mid+1;
            }    
        }
        return nums[low] == target ? low : -1;
    }
};
