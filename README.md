# Autonomous Extraction of Gleason Patterns for Grading Prostate Cancer using Multi-Gigapixel Whole Slide Images

## Introduction
<p align="justify">
This repository contains the implementation of our paper titled "Autonomous Extraction of Gleason Patterns for Grading Prostate Cancer using Multi-Gigapixel Whole Slide Images" currently under review in IEEE International Conference on Image Processing (ICIP) 2021</p>

![RAG-Netv2](/images/Fig2.png) 
<p align="center"> Block Diagram of the Proposed Framework</p>

The proposed framework is developed using <b>TensorFlow 2.3.1</b> and <b>Keras APIs</b> with <b>Python 3.7.8</b>. Moreover, some preprocessing steps and result compilation is performed through <b>MATLAB R2020a</b> as well. The detailed steps for installing and running the code are presented below:

## Installation
To run the codebase, following libraries are required. Although, the framework is developed using Anaconda. But it should be compatable with other platforms.

1) TensorFlow 2.3.1 
2) Keras 2.3.1 
3) OpenCV 4.4.0
4) imgaug 0.2.9 or above
5) tqdm
6) Matplotlib

Alternatively, we also provide a yml file that contains all of these packages.

## Dataset
Please download the desired dataset and follow the below-mentioned hierarchy to train and test the proposed framework:
```
├── trainingDataset
│   ├── train_images
│   │   └── tr_image_1.png
│   │   └── tr_image_2.png
│   │   ...
│   │   └── tr_image_n.png
│   ├── train_annotations
│   │   └── tr_image_1.png
│   │   └── tr_image_2.png
│   │   ...
│   │   └── tr_image_n.png
│   ├── val_images
│   │   └── va_image_1.png
│   │   └── va_image_2.png
│   │   ...
│   │   └── va_image_m.png
│   ├── val_annotations
│   │   └── va_image_1.png
│   │   └── va_image_2.png
│   │   ...
│   │   └── va_image_m.png
├── testingDataset
│   ├── test_images
│   │   └── te_image_1.png
│   │   └── te_image_2.png
│   │   ...
│   │   └── te_image_k.png
│   ├── test_annotations
│   │   └── te_image_1.png
│   │   └── te_image_2.png
│   │   ...
│   │   └── te_image_k.png
│   ├── segmentation_results
│   │   └── te_image_1.png
│   │   └── te_image_2.png
│   │   ...
│   │   └── te_image_k.png
```

If you are using whole slide image dataset, then the following training and testing folders should contain WSI patches only. These patches can be obtained using 'patchGenerator.m'. 
## Steps 
<p align="justify">

1) Download the desired dataset
2) Generate WSI patches using 'patchGenerator.m'
3) Resize patches (to make them compatible with the proposed framework) using the script 'resizer.m' within 'training_utils' folder 
4) Put the resized training patches in '…\trainingDataset\train_images' folder
5) Put the resized training annotations (ground truth patches) in '…\trainingDataset\train_annotations' folder
6) Put resized validation patches in '…\trainingDataset\val_images' folder
7) Put resized validation ground truth patches in '…\trainingDataset\val_annotations' folder. Note: the patches and their annotations should have same name and extension (preferably .png).
8) Put resized test patches in '…\testingDataset\test_images' folder and their annotations in '…\testingDataset\test_annotations' folder
9) Use 'trainer.py' file to train the proposed framework and then evaluate it on the test scans. The results on the test scans are saved in ‘…\testingDataset\segmentation_results’ folder. This script also saves the trained model in 'model.h5' file
10) The trained models can also be ported to MATLAB using ‘kerasConverter.m’ (this step is optional and only designed to facilitate MATLAB users if they want to avoid Python analysis)
</p>

## Citation
If you use the proposed framework (or any part of this code in your research), please cite the following paper:

```
@article{Hassan2021Cancer,
  title   = {Autonomous Extraction of Gleason Patterns for Grading Prostate Cancer using Multi-Gigapixel Whole Slide Images},
  author  = {Taimur Hassan and Ayman El-Baz and Naoufel Werghi},
  note = {arXiv:2011.00527, 2021}
}
```

## Contact
If you have any query, please feel free to contact us at: taimur.hassan@ku.ac.ae.
