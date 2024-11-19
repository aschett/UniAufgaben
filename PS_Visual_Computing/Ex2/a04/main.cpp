#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>

using namespace cv;
using namespace std;

int main(int argc, char** argv) {

    Mat src1, src2, dst1, dst2;
    src1 = imread("./img1.jpg", IMREAD_GRAYSCALE);
    src2 = imread("./img2.jpg", IMREAD_GRAYSCALE);

    if(!src1.data || !src2.data) {
        return -1;
    }

    GaussianBlur(src1, src1, Size(3,3), 0, 0, BORDER_DEFAULT );
    GaussianBlur(src2, src2, Size(3,3), 0, 0, BORDER_DEFAULT );

    double thres1 = threshold(src1, dst1, 0, 255, THRESH_OTSU);
    double thres2 = threshold(src2, dst2, 0, 255, THRESH_OTSU);
    

    Mat otsu1, otsu2;
    Canny(src1, otsu1, thres1/2, thres1);
    Canny(src2, otsu2, thres2/2, thres2);

    // Laplace and Sobel taken from the slides
    Mat laplace1_dst, laplace2_dst;
    Mat laplace1, laplace2;
    Laplacian(src1, laplace1_dst, CV_16S, 3, 1, 0, BORDER_DEFAULT);
    Laplacian(src2, laplace2_dst, CV_16S, 3, 1, 0, BORDER_DEFAULT);
    convertScaleAbs(laplace1_dst, laplace1);
    convertScaleAbs(laplace2_dst, laplace2);

    Mat grad_x1, grad_y1, abs_grad_x1, abs_grad_y1, sobel1;
    Sobel(src1, grad_x1, CV_16S, 1, 0, 3, 1, 0, BORDER_DEFAULT);  
    Sobel(src1, grad_y1, CV_16S, 0, 1, 3, 1, 0, BORDER_DEFAULT);  
    convertScaleAbs(grad_x1, abs_grad_x1);  
    convertScaleAbs(grad_y1, abs_grad_y1);
    addWeighted(abs_grad_x1, 0.5, abs_grad_y1, 0.5, 0, sobel1);

    Mat grad_x2, grad_y2, abs_grad_x2, abs_grad_y2, sobel2;
    Sobel(src2, grad_x2, CV_16S, 1, 0, 3, 1, 0, BORDER_DEFAULT);
    Sobel(src2, grad_y2, CV_16S, 0, 1, 3, 1, 0, BORDER_DEFAULT);
    convertScaleAbs(grad_x2, abs_grad_x2);
    convertScaleAbs(grad_y2, abs_grad_y2);
    addWeighted(abs_grad_x2, 0.5, abs_grad_y2, 0.5, 0, sobel2);

    imshow("Canny1", otsu1);
    imshow("Laplacian1", laplace1);
    imshow("Sobel1", sobel1);
    waitKey(0);

    imshow("Canny2", otsu2);
    imshow("Laplacian2", laplace2);
    imshow("Sobel2", sobel2);
    waitKey(0);

    return 0;
}
