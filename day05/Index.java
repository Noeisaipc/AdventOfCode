class GFG{
 
// getMissingNo function for 
// finding missing number
static int getMissingNo(int a[], int n)
{
    int n_elements_sum = n * (n + 1) / 2;
    int sum = 0;
 
    for(int i = 0; i < n - 1; i++)
        sum += a[i];
         
    return n_elements_sum - sum;
}
 
// Driver code
public static void main(String[] args)
{
    int a[] = { 2, 4, 5, 6 };
    int n = a.length + 1;
    int miss = getMissingNo(a, n);
     
    System.out.print(miss);
}
}