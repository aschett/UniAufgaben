#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>

using namespace cv;

int main(int argc, char** argv) {

    Mat src, dst;
    src = imread("./img2.jpg");
    
    if(!src.data) {
        return -1;
    }

    std::vector<Point2f> src_points;
    src_points.push_back(Point2f(448, 336));   // Top-left corner
    src_points.push_back(Point2f(src.cols - 100, 100)); // Top-right corner
    src_points.push_back(Point2f(src.cols - 100, src.rows - 100)); // Bottom-right corner
    src_points.push_back(Point2f(100, src.rows - 100)); // Bottom-left corner

    std::vector<Point2f> dst_points;
    dst_points.push_back(Point2f(0, 0));   // Top-left corner
    dst_points.push_back(Point2f(src.cols, 0)); // Top-right corner
    dst_points.push_back(Point2f(src.cols, src.rows)); // Bottom-right corner
    dst_points.push_back(Point2f(0, src.rows)); // Bottom-left corner


    Mat perspective_matrix = getPerspectiveTransform(src_points, dst_points);
    warpPerspective(src, dst, perspective_matrix, src.size());

    namedWindow("Original", WINDOW_AUTOSIZE);
    imshow("Original", src);
    imshow("Projective Trasform", dst);

    waitKey(0);
    return 0;
}
