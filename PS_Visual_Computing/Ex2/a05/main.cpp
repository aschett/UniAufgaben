#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/features2d.hpp>
#include <opencv2/xfeatures2d.hpp> // For SURF Operator
#include <iostream>

using namespace cv;
using namespace std;
using namespace cv::xfeatures2d;        //Only for easier SURF access

//https://docs.opencv.org/3.4/d8/d30/classcv_1_1AKAZE.html
//When you need descriptors use Feature2D::detectAndCompute, which provides better performance. 
//When using Feature2D::detect followed by Feature2D::compute scale space pyramid is computed twice
void getFeaturesAndMatch(const Mat& src, const Mat& transformed, Ptr<Feature2D> detector, int normType, const string& windowName, const string& transformationName) {
    vector<KeyPoint> keypoints_src, keypoints_transformed;
    Mat descriptors_src, descriptors_transformed;

    detector->detectAndCompute(src, noArray(), keypoints_src, descriptors_src);
    detector->detectAndCompute(transformed, noArray(), keypoints_transformed, descriptors_transformed);


    // Idea was tken from here https://docs.opencv.org/4.x/dc/dc3/tutorial_py_matcher.html
    BFMatcher matcher(normType);
    vector<vector<DMatch>> matches;
    matcher.knnMatch(descriptors_src, descriptors_transformed, matches, 2);

    vector<DMatch> good_matches;
    float ratio_thresh = 0.75f; 
    for (const auto& knn_match : matches) {
        if (knn_match[0].distance < ratio_thresh * knn_match[1].distance) {
            good_matches.push_back(knn_match[0]); 
        }
    }

    // All this stuff is so we dont get bloated with unecessary keypoints
    Mat img_matches;
    drawMatches(src, keypoints_src, transformed, keypoints_transformed, good_matches, img_matches, 
                Scalar::all(-1), Scalar::all(-1), vector<char>(), DrawMatchesFlags::NOT_DRAW_SINGLE_POINTS);
    imshow(windowName + " Matches | Good Matches = " + to_string(good_matches.size()) + "|" + transformationName, img_matches);
}

int main(int argc, char** argv) {

    Mat src;
    src = imread("./img2.jpg", IMREAD_GRAYSCALE);
    
    if(!src.data) {
        return -1;
    }

    Mat transformed;

    vector<Point2f> src_points;
    src_points.push_back(Point2f(448, 336));   // Top-left corner
    src_points.push_back(Point2f(src.cols - 100, 100)); // Top-right corner
    src_points.push_back(Point2f(src.cols - 100, src.rows - 100)); // Bottom-right corner
    src_points.push_back(Point2f(100, src.rows - 100)); // Bottom-left corner

    vector<Point2f> dst_points;
    dst_points.push_back(Point2f(0, 0));   // Top-left corner
    dst_points.push_back(Point2f(src.cols, 0)); // Top-right corner
    dst_points.push_back(Point2f(src.cols, src.rows)); // Bottom-right corner
    dst_points.push_back(Point2f(0, src.rows)); // Bottom-left corner

    Mat perspective_matrix = getPerspectiveTransform(src_points, dst_points);
    warpPerspective(src, transformed, perspective_matrix, src.size());

    Ptr<AKAZE> akaze = AKAZE::create();
    Ptr<BRISK> brisk = BRISK::create();
    Ptr<SURF> surf = SURF::create(400);

    getFeaturesAndMatch(src, transformed, akaze, NORM_HAMMING, "AKAZE", "Perspective Transformation");    //NORM_HAMMING gives the best reults according to this: https://vzat.github.io/comparing_images/week5.html#:~:text=All%20four%20algorithms%20for%20measuring,recommends%20using%20NORM_HAMMING%5B2%5D.
    getFeaturesAndMatch(src, transformed, brisk, NORM_HAMMING, "BRISK", "Perspective Transformation");    //Same for brisk according to this https://docs.opencv.org/4.x/dc/dc3/tutorial_py_matcher.html
    getFeaturesAndMatch(src, transformed, surf, NORM_L2, "SURF", "Perspective Transformation");           //NORM_L2 Was chosen on the slides
    waitKey(0);

    GaussianBlur(src, transformed, Size(9, 9), 2, 2);
    getFeaturesAndMatch(src, transformed, akaze, NORM_HAMMING, "AKAZE", "Gaussian Blur"); 
    getFeaturesAndMatch(src, transformed, brisk, NORM_HAMMING, "BRISK", "Gaussian Blur");    
    getFeaturesAndMatch(src, transformed, surf, NORM_L2, "SURF", "Gaussian Blur");           
    waitKey(0);

    resize(src, transformed, Size(), 0.5, 0.5);
    getFeaturesAndMatch(src, transformed, akaze, NORM_HAMMING, "AKAZE", "resize"); 
    getFeaturesAndMatch(src, transformed, brisk, NORM_HAMMING, "BRISK", "resize");    
    getFeaturesAndMatch(src, transformed, surf, NORM_L2, "SURF", "resize"); 
    waitKey(0);
    
    return 0;
}
