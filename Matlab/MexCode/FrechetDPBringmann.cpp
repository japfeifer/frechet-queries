/*
* Call the Bringmann et al. Continuous Frechet Distance c++ function 
* Input: curves P & Q
* Output: distance
*
 ** compile with:
 * mex -v COMPFLAGS='$COMPFLAGS -std=c++11' -DNVIS -DNCERTIFY FrechetDPBringmann.cpp curve.cpp filter.cpp frechet_light.cpp frechet_naive.cpp geometry_basics.cpp 
*/

#include "mex.hpp"
#include "mexAdapter.hpp"

using matlab::mex::ArgumentList;
using namespace matlab::data;

// #include "ct_point.h"
// #define NDEBUG
#include <assert.h>
#include <math.h>
#include <string.h>
#include <iostream>
// #include "defs.h"
// #include "query.h"
#include "frechet_light.h"
#include "curves.h"

class MexFunction : public matlab::mex::Function {
    // Pointer to MATLAB engine to call fprintf
    std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

    // Factory to create MATLAB data arrays
    ArrayFactory factory;

    // Create an output stream
    std::ostringstream stream;

public:
//     void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
     void operator()(ArgumentList outputs, ArgumentList inputs) {
        std::ostringstream stream;
        checkArguments(outputs, inputs);
        matlab::data::TypedArray<double> curve1 = std::move(inputs[0]);
        matlab::data::TypedArray<double> curve2 = std::move(inputs[1]);
        double leash_dist = inputs[2][0];
        bool resFlg = FrechetDPBringmann(curve1, curve2,leash_dist);
        outputs[0] = factory.createScalar(resFlg);
    }

    double FrechetDPBringmann(matlab::data::TypedArray<double>& inCurve1, matlab::data::TypedArray<double>& inCurve2, double leash_dist) {
        
        FrechetLight* frechet =  new FrechetLight();
        Curve bringCurve1;
        Curve bringCurve2;      
        
        int size1 = inCurve1.getDimensions()[0];
        int size2 = inCurve2.getDimensions()[0];
        for( int i=0; i<size1; ++i){
            bringCurve1.push_back({ inCurve1[i][0], inCurve1[i][1] });
        }
        for( int i=0; i<size2; ++i){
            bringCurve2.push_back({ inCurve2[i][0], inCurve2[i][1] });
        }

        bool dp_flg = frechet->lessThanWithFilters(leash_dist, bringCurve1, bringCurve2);
        
//         stream << "box count: " << frechet->getNumberOfBoxes() << std::endl;
//         displayOnMATLAB(stream);

//         stream << "frechet dist: " << resDist << std::endl;
//         displayOnMATLAB(stream);
        delete frechet;
        return dp_flg;
    }

    void checkArguments(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
        std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();
        matlab::data::ArrayFactory factory;

        if (inputs.size() != 3) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Three inputs required") }));
        }

        if (inputs[0].getType() != matlab::data::ArrayType::DOUBLE ||
            inputs[0].getType() == matlab::data::ArrayType::COMPLEX_DOUBLE) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("First Input matrix must be type double") }));
        }

        if (inputs[0].getDimensions().size() != 2) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("First Input must be m-by-n dimension") }));
        }

        if (inputs[1].getType() != matlab::data::ArrayType::DOUBLE ||
            inputs[1].getType() == matlab::data::ArrayType::COMPLEX_DOUBLE) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Second Input matrix must be type double") }));
        }

        if (inputs[1].getDimensions().size() != 2) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Second Input must be m-by-n dimension") }));
        }
        
        if (inputs[2].getNumberOfElements() != 1) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Third Input leash-length must be a scalar") }));
        }
        
        if (inputs[2].getType() != matlab::data::ArrayType::DOUBLE ||
            inputs[2].getType() == matlab::data::ArrayType::COMPLEX_DOUBLE) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Third Input multiplier must be a noncomplex scalar double") }));
        }
    }
    
    void displayOnMATLAB(std::ostringstream& stream) {
        // Pass stream content to MATLAB fprintf function
        matlabPtr->feval(u"fprintf", 0,
            std::vector<Array>({ factory.createScalar(stream.str()) }));
        // Clear stream buffer
        stream.str("");
    }
};