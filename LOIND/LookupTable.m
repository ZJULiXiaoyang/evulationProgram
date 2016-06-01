
%%%This function is mainly to save time
%%%mask---represent  a circle whose radius is 20
%%%angs---represent the angles of each pixel which helps to decide the spatial block
function [ mask,angs ] = LookupTable(  )
angs=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7.854,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,8.1599,8.1113,8.0615,8.0106,7.9589,7.9066,7.854,7.8014,7.7491,7.6974,7.6465,7.5967,7.5481,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,8.2722,8.2249,8.1757,8.1249,8.0727,8.0191,7.9646,7.9095,7.854,7.7985,7.7433,7.6888,7.6353,7.583,7.5322,7.4831,7.4358,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,8.3857,8.3409,8.2938,8.2446,8.1933,8.14,8.0851,8.0287,7.9711,7.9127,7.854,7.7952,7.7369,7.6793,7.6229,7.5679,7.5147,7.4634,7.4141,7.3671,7.3223,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,8.4975,8.4563,8.4126,8.3664,8.3176,8.2664,8.2128,8.1569,8.099,8.0393,7.9783,7.9164,7.854,7.7916,7.7296,7.6686,7.609,7.5511,7.4952,7.4416,7.3903,7.3416,7.2954,7.2517,7.2105,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,8.5681,8.5287,8.4867,8.442,8.3944,8.3439,8.2906,8.2345,8.1757,8.1146,8.0514,7.9865,7.9205,7.854,7.7874,7.7214,7.6566,7.5934,7.5322,7.4735,7.4174,7.364,7.3136,7.266,7.2212,7.1792,7.1399,0,0,0,0,0,0,0;
0,0,0,0,0,0,8.6394,8.6024,8.5626,8.52,8.4742,8.4253,8.3731,8.3176,8.2589,8.197,8.1323,8.0651,7.9959,7.9253,7.854,7.7827,7.7121,7.6429,7.5757,7.511,7.4491,7.3903,7.3348,7.2826,7.2337,7.188,7.1454,7.1056,7.0686,0,0,0,0,0,0;
0,0,0,0,0,8.7107,8.6764,8.6394,8.5994,8.5562,8.5097,8.4595,8.4056,8.3479,8.2864,8.2212,8.1525,8.0808,8.0066,7.9308,7.854,7.7772,7.7013,7.6272,7.5555,7.4868,7.4216,7.36,7.3023,7.2484,7.1983,7.1517,7.1086,7.0686,7.0316,6.9973,0,0,0,0,0;
0,0,0,0,8.7813,8.75,8.7162,8.6794,8.6394,8.5959,8.5487,8.4975,8.442,8.3821,8.3176,8.2488,8.1757,8.099,8.0191,7.9371,7.854,7.7708,7.6888,7.609,7.5322,7.4592,7.3903,7.3259,7.266,7.2105,7.1592,7.112,7.0686,7.0286,6.9918,6.9579,6.9267,0,0,0,0;
0,0,0,0,8.8225,8.792,8.7588,8.7225,8.6828,8.6394,8.5918,8.5397,8.4828,8.4207,8.3533,8.2806,8.2028,8.1202,8.0338,7.9446,7.854,7.7633,7.6741,7.5877,7.5052,7.4274,7.3546,7.2873,7.2252,7.1683,7.1162,7.0686,7.0251,6.9854,6.9492,6.9159,6.8855,0,0,0,0;
0,0,0,8.8931,8.8662,8.8368,8.8045,8.7691,8.73,8.687,8.6394,8.5868,8.5287,8.4647,8.3944,8.3176,8.2345,8.1454,8.0514,7.9537,7.854,7.7543,7.6566,7.5625,7.4735,7.3903,7.3136,7.2433,7.1792,7.1212,7.0686,7.021,6.9779,6.9389,6.9034,6.8712,6.8418,6.8149,0,0,0;
0,0,0,8.9379,8.9124,8.8844,8.8534,8.8192,8.7813,8.739,8.692,8.6394,8.5806,8.515,8.442,8.3611,8.2722,8.1757,8.0727,7.9646,7.854,7.7433,7.6353,7.5322,7.4358,7.3469,7.266,7.1929,7.1273,7.0686,7.016,6.9689,6.9267,6.8887,6.8545,6.8236,6.7956,6.7701,0,0,0;
0,0,9.0066,8.9849,8.9611,8.9348,8.9056,8.8731,8.8368,8.796,8.75,8.6981,8.6394,8.5728,8.4975,8.4126,8.3176,8.2128,8.099,7.9783,7.854,7.7296,7.609,7.4952,7.3903,7.2954,7.2105,7.1352,7.0686,7.0098,6.9579,6.912,6.8712,6.8348,6.8023,6.7731,6.7468,6.723,6.7014,0,0;
0,0,9.0539,9.0342,9.0124,8.9882,8.9611,8.9308,8.8967,8.858,8.8141,8.7637,8.7059,8.6394,8.5626,8.4742,8.3731,8.2589,8.1323,7.9959,7.854,7.7121,7.5757,7.4491,7.3348,7.2337,7.1454,7.0686,7.002,6.9442,6.8939,6.8499,6.8113,6.7771,6.7468,6.7198,6.6956,6.6738,6.6541,0,0;
0,9.1189,9.103,9.0855,9.066,9.0443,9.0199,8.9924,8.9611,8.9254,8.8844,8.8368,8.7813,8.7162,8.6394,8.5487,8.442,8.3176,8.1757,8.0191,7.854,7.6888,7.5322,7.3903,7.266,7.1592,7.0686,6.9918,6.9267,6.8712,6.8236,6.7825,6.7468,6.7156,6.6881,6.6637,6.642,6.6225,6.6049,6.5891,0;
0,9.1675,9.1538,9.1387,9.1219,9.103,9.0818,9.0576,9.03,8.9982,8.9611,8.9177,8.8662,8.8045,8.73,8.6394,8.5287,8.3944,8.2345,8.0514,7.854,7.6566,7.4735,7.3136,7.1792,7.0686,6.9779,6.9034,6.8418,6.7903,6.7468,6.7098,6.678,6.6504,6.6262,6.6049,6.5861,6.5692,6.5541,6.5405,0;
0,9.2173,9.2061,9.1937,9.1798,9.1642,9.1465,9.1263,9.103,9.076,9.0443,9.0066,8.9611,8.9056,8.8368,8.75,8.6394,8.4975,8.3176,8.099,7.854,7.609,7.3903,7.2105,7.0686,6.9579,6.8712,6.8023,6.7468,6.7014,6.6637,6.632,6.6049,6.5817,6.5615,6.5438,6.5282,6.5143,6.5019,6.4907,0;
0,9.2682,9.2596,9.2501,9.2394,9.2274,9.2137,9.198,9.1798,9.1585,9.1333,9.103,9.066,9.0199,8.9611,8.8844,8.7813,8.6394,8.442,8.1757,7.854,7.5322,7.266,7.0686,6.9267,6.8236,6.7468,6.6881,6.642,6.6049,6.5746,6.5494,6.5282,6.51,6.4943,6.4806,6.4685,6.4579,6.4483,6.4398,0;
0,9.3199,9.3141,9.3077,9.3004,9.2922,9.2829,9.2721,9.2596,9.2449,9.2274,9.2061,9.1798,9.1465,9.103,9.0443,8.9611,8.8368,8.6394,8.3176,7.854,7.3903,7.0686,6.8712,6.7468,6.6637,6.6049,6.5615,6.5282,6.5019,6.4806,6.463,6.4483,6.4358,6.4251,6.4157,6.4075,6.4003,6.3938,6.3881,0;
0,9.3722,9.3693,9.366,9.3624,9.3582,9.3535,9.348,9.3416,9.3341,9.3251,9.3141,9.3004,9.2829,9.2596,9.2274,9.1798,9.103,8.9611,8.6394,7.854,7.0686,6.7468,6.6049,6.5282,6.4806,6.4483,6.4251,6.4075,6.3938,6.3829,6.3738,6.3663,6.36,6.3545,6.3498,6.3456,6.3419,6.3387,6.3358,0;
9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,9.4248,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566,12.566;
0,9.4774,9.4803,9.4835,9.4872,9.4913,9.4961,9.5015,9.5079,9.5154,9.5244,9.5354,9.5491,9.5667,9.5899,9.6222,9.6698,9.7465,9.8884,10.21,10.996,11.781,12.103,12.245,12.321,12.369,12.401,12.424,12.442,12.456,12.467,12.476,12.483,12.49,12.495,12.5,12.504,12.508,12.511,12.514,0;
0,9.5297,9.5354,9.5419,9.5491,9.5573,9.5667,9.5774,9.5899,9.6046,9.6222,9.6434,9.6698,9.7031,9.7465,9.8053,9.8884,10.013,10.21,10.532,10.996,11.459,11.781,11.978,12.103,12.186,12.245,12.288,12.321,12.348,12.369,12.387,12.401,12.414,12.424,12.434,12.442,12.449,12.456,12.461,0;
0,9.5814,9.5899,9.5995,9.6101,9.6222,9.6359,9.6516,9.6698,9.691,9.7162,9.7465,9.7835,9.8297,9.8884,9.9652,10.068,10.21,10.408,10.674,10.996,11.317,11.584,11.781,11.923,12.026,12.103,12.161,12.208,12.245,12.275,12.3,12.321,12.34,12.355,12.369,12.381,12.392,12.401,12.41,0;
0,9.6323,9.6434,9.6559,9.6698,9.6854,9.7031,9.7233,9.7465,9.7735,9.8053,9.843,9.8884,9.9439,10.013,10.1,10.21,10.352,10.532,10.751,10.996,11.241,11.459,11.639,11.781,11.892,11.978,12.047,12.103,12.148,12.186,12.218,12.245,12.268,12.288,12.306,12.321,12.335,12.348,12.359,0;
0,9.6821,9.6957,9.7108,9.7277,9.7465,9.7678,9.792,9.8196,9.8514,9.8884,9.9319,9.9834,10.045,10.12,10.21,10.321,10.455,10.615,10.798,10.996,11.193,11.376,11.536,11.67,11.781,11.872,11.946,12.008,12.059,12.103,12.14,12.172,12.199,12.223,12.245,12.263,12.28,12.295,12.309,0;
0,9.7307,9.7465,9.7641,9.7835,9.8053,9.8297,9.8572,9.8884,9.9241,9.9652,10.013,10.068,10.133,10.21,10.301,10.408,10.532,10.674,10.83,10.996,11.161,11.317,11.459,11.584,11.69,11.781,11.858,11.923,11.978,12.026,12.067,12.103,12.134,12.161,12.186,12.208,12.227,12.245,12.26,0;
0,0,9.7957,9.8154,9.8372,9.8614,9.8884,9.9187,9.9529,9.9915,10.036,10.086,10.144,10.21,10.287,10.375,10.476,10.591,10.717,10.854,10.996,11.137,11.274,11.4,11.515,11.616,11.704,11.781,11.848,11.905,11.956,12,12.038,12.072,12.103,12.13,12.154,12.176,12.195,0,0;
0,0,9.843,9.8646,9.8884,9.9147,9.9439,9.9764,10.013,10.054,10.1,10.151,10.21,10.277,10.352,10.437,10.532,10.637,10.751,10.871,10.996,11.12,11.241,11.354,11.459,11.554,11.639,11.714,11.781,11.84,11.892,11.938,11.978,12.015,12.047,12.076,12.103,12.127,12.148,0,0;
0,0,0,9.9117,9.9372,9.9652,9.9961,10.03,10.068,10.111,10.158,10.21,10.269,10.335,10.408,10.488,10.577,10.674,10.777,10.885,10.996,11.106,11.214,11.317,11.414,11.503,11.584,11.657,11.722,11.781,11.834,11.881,11.923,11.961,11.995,12.026,12.054,12.079,0,0,0;
0,0,0,9.9565,9.9834,10.013,10.045,10.08,10.12,10.163,10.21,10.263,10.321,10.385,10.455,10.532,10.615,10.704,10.798,10.896,10.996,11.095,11.193,11.287,11.376,11.459,11.536,11.606,11.67,11.728,11.781,11.829,11.872,11.911,11.946,11.978,12.008,12.035,0,0,0;
0,0,0,0,10.027,10.058,10.091,10.127,10.167,10.21,10.258,10.31,10.367,10.429,10.496,10.569,10.647,10.729,10.816,10.905,10.996,11.086,11.175,11.262,11.344,11.422,11.495,11.562,11.624,11.681,11.733,11.781,11.824,11.864,11.9,11.934,11.964,0,0,0,0;
0,0,0,0,10.068,10.1,10.133,10.17,10.21,10.254,10.301,10.352,10.408,10.467,10.532,10.601,10.674,10.751,10.83,10.912,10.996,11.079,11.161,11.241,11.317,11.39,11.459,11.524,11.584,11.639,11.69,11.738,11.781,11.821,11.858,11.892,11.923,0,0,0,0;
0,0,0,0,0,10.139,10.173,10.21,10.25,10.293,10.34,10.39,10.444,10.502,10.563,10.628,10.697,10.769,10.843,10.919,10.996,11.072,11.148,11.222,11.294,11.363,11.428,11.49,11.547,11.601,11.651,11.698,11.741,11.781,11.818,11.852,0,0,0,0,0;
0,0,0,0,0,0,10.21,10.247,10.287,10.33,10.375,10.424,10.476,10.532,10.591,10.653,10.717,10.784,10.854,10.924,10.996,11.067,11.137,11.207,11.274,11.339,11.4,11.459,11.515,11.567,11.616,11.662,11.704,11.744,11.781,0,0,0,0,0,0;
0,0,0,0,0,0,0,10.281,10.321,10.363,10.408,10.455,10.506,10.559,10.615,10.674,10.735,10.798,10.863,10.929,10.996,11.062,11.128,11.193,11.256,11.317,11.376,11.432,11.486,11.536,11.584,11.628,11.67,11.71,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,10.352,10.393,10.437,10.483,10.532,10.583,10.637,10.693,10.751,10.81,10.871,10.933,10.996,11.058,11.12,11.181,11.241,11.298,11.354,11.408,11.459,11.508,11.554,11.598,11.639,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,10.464,10.509,10.556,10.605,10.656,10.71,10.764,10.821,10.878,10.937,10.996,11.054,11.113,11.17,11.227,11.282,11.335,11.386,11.435,11.482,11.527,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,10.577,10.625,10.674,10.725,10.777,10.83,10.885,10.94,10.996,11.051,11.106,11.161,11.214,11.267,11.317,11.366,11.414,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,10.69,10.738,10.788,10.839,10.891,10.943,10.996,11.048,11.1,11.152,11.203,11.253,11.301,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10.996,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

mask=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0;
0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0;
0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0;
0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0;
0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0;
0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0;
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0;
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0;
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0;
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0;
0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0;
0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0;
0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0;
0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0;
0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0;
0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
];

end
