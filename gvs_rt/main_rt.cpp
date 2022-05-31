#include "lib/gvs_utils.hpp"
#include "lib/gvs_fd.hpp"
#include "lib/gvs_hog.hpp"
#include "lib/gvs_lap.hpp"
#include "lib/gvs_fft.hpp"
#include "math.h"
#include <iomanip>
#include <chrono>

#define FAKE_ANGLE 0
#define SPEED_TH 40

using namespace cv;
using namespace std;

int main(int argc, char const *argv[])
{
    cout << std::setprecision(3) << std::fixed;
    vector<float> thetas_fd;
    vector<float> thetas;
    vector<int> time;
    vector<float> thetas_hog;
    vector<float> thetas_fft;
    vector<float> speeds_lap;
    float theta_main;
    float speed_main;
    int dir_mode = GVS_FFT_MODE;

    ofstream file_csv;
    file_csv.open("../gvs/data_csv/data_csv_45_new.csv");
    for (int frame_id = 95; frame_id < END_FRAME; frame_id++)
    {
        /// FIND DIRECTION ///

        /// Case low speed use GVS_FD ///
        if (frame_id <= 115)
        {
            /// Import 2 frames ///
            String path_a = "../../test_60fps_1cd/frame_" + to_string(frame_id) + ".png";
            String path_b = "../../test_60fps_1cd/frame_" + to_string(frame_id - 1) + ".png";

            Mat frame_a = imread(path_a, IMREAD_COLOR);
            Mat frame_b = imread(path_b, IMREAD_COLOR);

            /// Check for not corrupted data ///
            if (!frame_a.data || !frame_b.data)
            {
                cout << "Incorrect data frame" << endl;
                return -1;
            }

            /// Testing rotation ///
            rot_img(frame_a, FAKE_ANGLE, true, FD_X_CROP, FD_Y_CROP);
            rot_img(frame_b, FAKE_ANGLE, true, FD_X_CROP, FD_Y_CROP);

            /// Get ang_mat ///
            float theta_fd = gvs_fd(frame_a, frame_b);
            theta_fd = -theta_fd - 90;
            theta_main = theta_fd;
            /*thetas.push_back(theta_fd);    // TAKE DIST AND THETA FROM HERE for first 10 frames
            thetas_fd.push_back(theta_fd); // TAKE DIST AND THETA FROM HERE for first 10 frames
            theta_main = 0;
            for (int i = 0; i < 1; i++)
            {
                theta_main += thetas[thetas.size() - 1 - i];
            }
            theta_main /= 1;*/
        }
        /// Case high speed use GVS_HOG ///
        else
        {
            /// Import frame ///
            String path = "../../test_60fps_1cd/frame_" + to_string(frame_id) + ".png";
            Mat frame = imread(path, IMREAD_COLOR);

            /// Check for not corrupted data ///
            if (!frame.data)
            {
                cout << "Incorrect data frame" << endl;
                return -1;
            }

            /// Testing rotation ///
            rot_img(frame, FAKE_ANGLE, true, HOG_X_CROP, HOG_Y_CROP);
            imshow("Frame original", frame);

            if (dir_mode == GVS_HOG_MODE)
            {
                float theta_hog = gvs_hog(frame);
                theta_main = theta_hog;
                /*thetas_hog.push_back(theta_hog); // Store img gradient direction
                thetas.push_back(theta_hog);     // TAKE DIST AND THETA FROM HERE for first 10 frame
                theta_main = 0;
                for (int i = 0; i < 1; i++)
                {
                    theta_main += thetas[thetas.size() - 1 - i];
                }
                theta_main /= 1;*/
            }
            else
            {
                float theta_fft = gvs_fft(frame);
                theta_main = theta_fft;
                /*thetas_fft.push_back(theta_fft); // Store img gradient direction
                thetas.push_back(theta_fft);     // TAKE DIST AND THETA FROM HERE for first 10 frame
                theta_main = 0;
                for (int i = 0; i < 1; i++)
                {
                    theta_main += thetas[thetas.size() - 1 - i];
                }
                theta_main /= 1;*/
            }
        }

        /// FIND SPEED with GVS_LAP ///
        String path = "../../test_60fps_1cd/frame_" + to_string(frame_id) + ".png";
        Mat img = imread(path, IMREAD_COLOR);

        rot_img(img, FAKE_ANGLE, true, HOG_X_CROP, HOG_Y_CROP);

        /// Check for not corrupted data ///
        if (!img.data)
        {
            cout << "Incorrect data frame\n";
            return -1;
        }

        speed_main = gvs_lap(img, theta_main);
        /*speeds_lap.push_back(speed_main);

        speed_main = 0;
        for (int i = 0; i < 1; i++)
        {
            speed_main += speeds_lap[speeds_lap.size() - 1 - i];
        }
        speed_main /= 1;*/
        if (speed_main > 0 && speed_main < 100 && frame_id > 5)
        {
            cout << "Frame: " << frame_id << " --- Theta: " << theta_main << " --- Std_dev: " << speed_main << endl;
            file_csv << theta_main << "," << speed_main << endl;
        }
    }
    file_csv.close();
    return 0;
}

// std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
// std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
// time.push_back((std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count()) / 1000);