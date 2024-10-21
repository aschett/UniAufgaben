#include <iostream>
#include <string>
#include <opencv2/opencv.hpp>
using namespace cv;
using namespace std;

//Needs an image in the same folder with the name ./image.jpg

void show_and_resize_img(int width, int length, string image_path);

//first the program opens an image with its original sizes, afterwards it opens it with modified sizes
int main(int argc, char** argv)
{
    string image_path = "./image.jpg";
    show_and_resize_img(0, 0, image_path);
    // apparently this is needed to wait until there is a key press. otherwise my image wouldnt even show
    // yeah ok makes sense otherwise the program just goes to returning i am stupid
    waitKey(0);
    show_and_resize_img(448, 336, image_path);
    waitKey(0);
    return 0;
}

//input 0 into width and length if you only want to show image
void show_and_resize_img(int width, int length, string image_path)
{
    Mat image = imread(image_path);
    if (image.empty()) {
        cout << "Have to put file with name 'image.jpg' in this folder to work!" << endl;
        return;
    }
    if(width && length != 0){
        Mat resized_image;
        resize(image, resized_image, Size(width, length), 1);
        imshow("Window", resized_image);
    }

    else
    {
        imshow("Window", image);
    }

}