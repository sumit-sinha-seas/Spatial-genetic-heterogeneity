#include <iostream>
//#include <unordered_set>
#include <fstream>
#include <vector>
#include <algorithm>
#include <math.h>
#include <cmath>
#include "sys/time.h"
//#include "omp.h"

using namespace std;
template <typename T>
class count_back_inserter {
    size_t &count;
    public:
    typedef void value_type;
    typedef void difference_type;
    typedef void pointer;
    typedef void reference;
    typedef std::output_iterator_tag iterator_category;
    count_back_inserter(size_t &count) : count(count) {};
    void operator=(const T &){ ++count; }
    count_back_inserter &operator *(){ return *this; }
    count_back_inserter &operator++(){ return *this; }
};


bool big_vectors (const std::vector<int> &v1, const std::vector<int> &v2) {
    return v1.size() > v2.size();
}

///////////////////////////////////////
double get_wall_time (void) {

  struct timeval tm;
  struct timezone tz;

  gettimeofday(&tm, &tz);
  return((double)(tm.tv_sec) + 1e-6*(double)(tm.tv_usec));
//#endif
}

//////////////////////////////////
size_t union_intersection_size(const std::vector<int> &v1, const std::vector<int> &v2){
    //std::vector<int> tmpVecUnion;

    size_t size_union = 0;
    std::set_union(v1.begin()+3, v1.end(),
                   v2.begin()+3, v2.end(),                  
                   count_back_inserter<int>(size_union));

    int size_intersection = v1.size() + v2.size() - size_union-6;

    //return tmpVecUnion.size()- tmpVecIntersection.size();
    return size_union - size_intersection;
}

int main()
{
	long int  m,n,max_l;

	int number_of_lines = 0;
    	std::string line;
    	std::ifstream myfile("processed_data.txt");

    	while (std::getline(myfile, line))
       		 ++number_of_lines;

    	std::cout << "Number of lines in text file: " << number_of_lines;

	m=number_of_lines;
	n=303;
	max_l=2000;
  double result[max_l][2];

	for(int i=0;i<max_l;i++)
	{
		result[i][0]=0;
		result[i][1]=0;
	}
	double intpart;
  std::vector< std::vector<int> > vec (m, std::vector<int>(n, 0));
	
	ifstream infile;
	ofstream outfile;
	infile.open("processed_data.txt");
	outfile.open("output_p001_run1.txt");

 double t0 = get_wall_time();
	for(int i=0;i<m;i++)
	{
		for(int j=0;j<n;j++)
		{
			infile >> vec[i][j];
		}
        //sort each vector
        std::sort(vec[i].begin()+3, vec[i].end());
        // Remove duplicate
        vec[i].erase( unique( vec[i].begin()+3, vec[i].end() ), vec[i].end() );
	}

    // Sort vectors based on their sizes
    //std::sort(vec.begin(), vec.end(), big_vectors);

    //for (int i=0;i<m;i++)
    //{
   //    for (std::vector<int>::iterator it=vec[i].begin(); it!=vec[i].end(); ++it)
    //    {        

      //        cout << *it << " ";

       // }
       // cout << endl;
    //}

       


          // cout << endl;
//    outfile.open("output.txt");

		
   // }

    double t1 = get_wall_time();
    cout << "Processing time " << t1 - t0 << endl;
	infile.close();

    int Nthreads = 1;

#ifdef _OPENMP
    Nthreads = omp_get_max_threads();
    omp_set_num_threads(Nthreads);
#endif

   // std::cout << "Nthread = " << Nthreads << std::endl;

    
     double no_of_pairs=0;
        double ith=0;
    #pragma omp parallel
    {
        int ithread = 0;
#ifdef _OPENMP
        ithread = omp_get_thread_num();
#endif
        
       
        for (long p = ithread; p < m; p++) 
	{
		if ( p %1000 == 0)
	{
			cout << p << endl;
		}

            for(long q = p+1; q < m; q++)
            {
                no_of_pairs= no_of_pairs+1;
                int size_ans= union_intersection_size(vec[p], vec[q]);
                
              //  cout<<"p= "<<p<<"q= "<<q<<"ith(p,q) "<<size_ans<<endl;
                ith=ith+size_ans;
                

               // cout<< p << " " << q << " " << size_ans << endl;

		            double radius=pow((pow((vec[p][0]-vec[q][0]),2)+ pow((vec[p][1]-vec[q][1]),2)+ pow((vec[p][2]-vec[q][2]),2)),0.5);
	             	int rounded_r = round(radius);
            		result[rounded_r][0]=result[rounded_r][0]+1;
		            result[rounded_r][1]=result[rounded_r][1]+(size_ans);
		
		
		
			
		// outfile << p << " "<< q << " "<< size_ans<< endl;
            }
          }

        //for (long p = 2*Nthreads - ithread - 1; p < m; p += 2*Nthreads)
          //  for(long q = p+1; q < m; q++)
           // {
             //   int size_ans= union_intersection_size(vec[p], vec[q]) ;
		//outfile << p<< " "<< q <<" "<<size_ans << endl ;
	//	double radius=pow((pow((vec[p][0]-vec[q][0]),2)+ pow((vec[p][1]-vec[q][1]),2)+ pow((vec[p][2]-vec[q][2]),2)),2);
	//	int rounded_r = radius - modf(radius, &intpart);
	//	result[rounded_r][0]=result[rounded_r][0]+1;
	//	result[rounded_r][1]=result[rounded_r][1]+size_ans;
          //  }
    }

    double t2 = get_wall_time();

    cout << "Calculating time " << t2 - t1 << endl;
	
	for(int i=0;i<max_l;i++)
	{

		outfile << result[i][0]<< " "<< result[i][1]<<endl;
		



	}    

	//cout <<"I am here"<< endl;
    cout << "no of pairs = " << no_of_pairs<<endl;
    cout<< "ITH =  "<< ith/(no_of_pairs)<<endl;






	outfile.close();
	

	return 0;
}
