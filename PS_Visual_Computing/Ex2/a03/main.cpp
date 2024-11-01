#include <opencv2/opencv.hpp>
#include <iostream>
#include <vector>

using namespace cv;
using namespace std;


Mat applyAndCombineGaborFilters(const Mat& img, int ksize, double sigma, double lambd, double gamma) {
    //Calculates 0°, 45°, 90°, and 135° this way
    vector<double> orientations = {0, CV_PI / 4, CV_PI / 2, 3 * CV_PI / 4};
    Mat img_1, img_2, img_3, img_4;

    //taken from:https://docs.opencv.org/3.4/d4/d86/group__imgproc__filter.html#gae84c92d248183bd92fa713ce51cc3599
    Mat kernel_1 = getGaborKernel(Size(ksize, ksize), sigma, orientations[0], lambd, gamma, CV_PI*0.5, CV_32F);
    Mat kernel_2 = getGaborKernel(Size(ksize, ksize), sigma, orientations[1], lambd, gamma, CV_PI*0.5, CV_32F);
    Mat kernel_3 = getGaborKernel(Size(ksize, ksize), sigma, orientations[2], lambd, gamma, CV_PI*0.5, CV_32F);
    Mat kernel_4 = getGaborKernel(Size(ksize, ksize), sigma, orientations[3], lambd, gamma, CV_PI*0.5, CV_32F);

    filter2D(img, img_1, CV_32F, kernel_1);
    filter2D(img, img_2, CV_32F, kernel_2);
    filter2D(img, img_3, CV_32F, kernel_3);
    filter2D(img, img_4, CV_32F, kernel_4);

    //Takes the per element maximum taken from:https://docs.opencv.org/3.4/d2/de8/group__core__array.html#gacc40fa15eac0fb83f8ca70b7cc0b588d
    Mat combined_img = Mat::zeros(img.size(), CV_32F); 
    max(img_1, img_2, combined_img);
    max(combined_img, img_3, combined_img);
    max(combined_img, img_4, combined_img);

    //Without this the code was basically only white so i read online that this could be an issue if the values are out of 255 range for display and normalized would fix this.
    //Idea was taken from here https://stackoverflow.com/questions/42266742/how-to-normalize-image-in-opencv
    normalize(combined_img, combined_img, 0, 1, NORM_MINMAX);
    return combined_img;
}


int main() {
    Mat src;
    Mat result;
    src = imread("./img2.jpg", IMREAD_GRAYSCALE);
    
    if(!src.data) {
        return -1;
    }

    //Info also taken from the Documentation of getGaborKernel() under:https://docs.opencv.org/3.4/d4/d86/group__imgproc__filter.html#gae84c92d248183bd92fa713ce51cc3599
    int ksize;       // Size of the filter returned.
    double sigma;   // Standard deviation of the gaussian envelope.
    double lambda;  // Orientation of the normal to the parallel stripes of a Gabor function.
    double gamma;   // Wavelength of the sinusoidal factor.

    ksize = 21;
    sigma = 5.0;
    lambda = 10.0;
    gamma = 0.5;

    result = applyAndCombineGaborFilters(src, ksize, sigma, lambda, gamma);

    imshow("Original Image", src);
    imshow("Combined Gabor Filtered Image Set 1", result);
    waitKey(0);

    ksize = 505;
    sigma = 3.0;
    lambda = 5.0;
    gamma = 0.8;

    result = applyAndCombineGaborFilters(src, ksize, sigma, lambda, gamma);

    imshow("Original Image", src);
    imshow("Combined Gabor Filtered Image Set 2", result);
    waitKey(0);

    ksize = 31;
    sigma = 8.0;
    lambda = 20.0;
    gamma = 0.4;

    result = applyAndCombineGaborFilters(src, ksize, sigma, lambda, gamma);

    imshow("Original Image", src);
    imshow("Combined Gabor Filtered Image Set 3", result);
    waitKey(0);

    return 0;
}
