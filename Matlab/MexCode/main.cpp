#include "defs.h"
#include "query.h"
#include "frechet_light.h"

#include <string>

#include "cover_tree.h"

void printUsage()
{
	std::cout <<
		"Usage: ./frechet <curve_directory> <curve_data_file> <query_curves_file> [<results_file>]\n"
		"\n"
		"The fourth argument is optional. If only three arguments are passed, then\n"
		"the results are written to results.txt. More information regarding the\n"
		"format of the curve and query files can be found in README.\n"
		"\n";
}

int main(int argc, char* argv[])
{
    
//	if (argc <= 3 || argc >= 6) {
//		printUsage();
//		ERROR("Wrong number of arguments passed.");
//	}

	std::string curve_directory(    /*argv[1]*/ "/tmp/hurdat2/Hurdat2Export/" );
	std::string curve_data_file(    /*argv[2]*/ "/tmp/hurdat2/Hurdat2Export/dataset.txt" );
	std::string query_curves_file(  /*argv[3]*/ "/tmp/hurdat2/query-10.txt");
	std::string results_file = (    /*argc == 5 ? argv[4] : */ "results.txt");

	// make everything ready for query
	Query query(curve_directory);
	query.readCurveData(curve_data_file);
	query.readQueryCurves(query_curves_file);
	query.setAlgorithm("light");
	query.getReady();

        Curves curves = query.getCurves();
//        FrechetLight* frechet =  new FrechetLight();
//        std::cout << "dist[0,1]="<< frechet->calcDistance( curves[0], curves[10] );
        
        v_array<point> set_of_points = parse_points( curves );
        node top = batch_create(set_of_points);
        
        std::cout << "CoverTree batch-construction took nofDistCalls="<<getNofDistanceCalls() << std::endl;
        
//        set_cluster_radii( top );
//        print(0, top);


        
//        v_array<int> test_stats_depth, test_stats_breadth;
//        depth_dist(top.scale, top , test_stats_depth);
//        breadth_dist(top, test_stats_breadth);
//        for( int i=0; i< test_stats_depth.index; ++i)
//            std::cout << test_stats_depth.elements[i] << "\t";
//        std::cout << std::endl<< std::endl<< std::endl;
//        for( int i=0; i< test_stats_breadth.index; ++i)
//            std::cout << test_stats_breadth.elements[i] << "\t";
//        std::cout << std::endl<< std::endl<< std::endl;
        

        
        
        double   accumul = 0.0;
        int    nofLeafs = 0;
        int    maxLeafDepth = -1;
        stats_leaf_depth(top, accumul, nofLeafs, 0, maxLeafDepth );
        std::cout << "Average leaf-depth=" << accumul/nofLeafs << "\tmaxLeafDepth="<< maxLeafDepth << "\n";
        
        accumul = 0.0;
        int nofNonLeafs=0, maxArity=0;
        stats_node_arity( top, accumul, nofNonLeafs, maxArity );
        std::cout << "Average node-arity=" << accumul/nofNonLeafs << "\tmaxArity="<< maxArity << "\n";
        
        accumul = 0.0;
        int nofEdges = 0;
        stats_compactness( top, accumul, nofEdges );
        std::cout << "Average compactness=" << accumul / nofEdges << "\n";
        
        

        
        std::cout << "NOW DOING kNN QUERIES on the CoverTree\n";
        
        Curves curvesInQueries;
        curvesInQueries.reserve(query.getQueries().size());
        for( int i=0; i< query.getQueries().size(); ++i  ){
            Curve elm = query.getQueries()[i].curve;
            curvesInQueries.push_back( elm );
            break;
        }
        std::cout << "nofQueries=" << curvesInQueries.size() << "\n";
        
        v_array<point> set_of_queries =parse_points( curvesInQueries );
        node top_query = batch_create(set_of_queries);
  
        v_array<v_array<point> > res;
        
        int pre = getNofDistanceCalls();
        k_nearest_neighbor(top,top_query,res, 0+1 );
//        float range = query.getQueries().at(0).distance;
//        epsilon_nearest_neighbor(top,top_query,res, range );
        
        std::cout << "CoverTree kNN queries took nofDistanceCalls=" << (getNofDistanceCalls()-pre) <<"\n";
        std::cout << "Dataset size=" << curves.size() <<"\n";
        
          printf("Printing results\n");
  for (int i = 0; i < res.index; i++)
    {
//      printf("10 closest of curve=");
//      printf(curvesInQueries[i].filename.c_str());
//      printf("\n");
      
      for (int j = 0; j<res[i].index; j++)
	print(res[i][j]);
      printf("\n");
    }
  printf("results printed\n");
        
  

  
  v_array<node*> leafs;
  v_array<int> depths;
  get_leafs_n_depths(top, leafs, depths, 0);
  
          check_tree( top ); // needs to run after get_leafs_n_depths()
  
//  std::cout << leafs.index;
  
//  std::cout << "\nnofContainingClustersOfTraj[0]=" << count_clusters_containing(top, set_of_points[0]);
  
  double overlap = 0.0;
  for(int i=0; i<leafs.index; ++i ){
      double clusters_on_path_to_root = depths[i];
      int    clusters_containing_leaf = 0;
      point p = leafs[i]->p;
      count_clusters_containing( top, p , clusters_containing_leaf);
      
      
      if( !( clusters_on_path_to_root <= clusters_containing_leaf ))
          std::cout << "MISSCOUNT\n";
    overlap += clusters_on_path_to_root / clusters_containing_leaf;
  }
  overlap = overlap/leafs.index;
  
  std::cout << "Average Overlap=" << overlap;
  
	// run and save result
//	query.run();
//	query.saveResults(results_file);
}
