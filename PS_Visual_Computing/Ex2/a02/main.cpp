#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <vector>

using namespace cv;
using namespace std;

Mat gaussianBlur(const Mat& src) {
    Mat kernel = (Mat_<float>(1, 5) << 1, 4, 6, 4, 1) / 16.0;
    Mat blurred;

    sepFilter2D(src, blurred, -1, kernel, kernel);
    return blurred;
}

vector<Mat> buildGaussianPyramid(const Mat& src, int levels) {
    vector<Mat> pyramid;
    pyramid.push_back(src);

    Mat current = src;

    for(int i = 0; i < levels; i++) {
        Mat blurred = gaussianBlur(current);

        Mat downsampled;
        pyrDown(blurred, downsampled, Size(blurred.cols / 2, blurred.rows / 2), BORDER_DEFAULT);

        pyramid.push_back(downsampled);
        current = downsampled;
    }
    return pyramid;
}

vector<Mat> buildLaplacianPyramid(const Mat& src, int levels) {
    vector<Mat> gaussianPyramid = buildGaussianPyramid(src, levels);

    vector<Mat> laplacianPyramid; 
    
    for(int i = 0; i < gaussianPyramid.size()-1; i++) {
        Mat upsampled;
        pyrUp(gaussianPyramid[i+1], upsampled, gaussianPyramid[i].size());

        Mat laplacian = gaussianPyramid[i] - upsampled;
        laplacianPyramid.push_back(laplacian);
    }

    laplacianPyramid.push_back(gaussianPyramid.back());
    return laplacianPyramid;
}

Mat displayPyramid(const vector<Mat>& pyramid) {
    int targetHeight = pyramid[0].rows;

    vector<Mat> resizedPyramid;

    for(const Mat& level : pyramid) {
        Mat resizedLevel;
        int newWidth = (int)((double)targetHeight / level.rows * level.cols);
        resize(level, resizedLevel, Size(newWidth, targetHeight));
        resizedPyramid.push_back(resizedLevel);
    }
    Mat result;
    hconcat(resizedPyramid, result);
    return result;
}

int main(int argc, char** argv) {

    Mat src;
    src = imread("./img2.jpg");

    int levels = 4;

    if(!src.data) {
        return -1;
    }

    vector<Mat> gaussianPyramid = buildGaussianPyramid(src, levels);
    vector<Mat> laplacianPyramid = buildLaplacianPyramid(src, levels);

    Mat gaussianPyramidDisplay = displayPyramid(gaussianPyramid);
    Mat laplacianPyramidDisplay = displayPyramid(laplacianPyramid);

    imshow("Gaussian pyramid", gaussianPyramidDisplay);
    imshow("Laplacian pyramid", laplacianPyramidDisplay);
    
    waitKey(0);
    return 0;
}
