cmake_minimum_required(VERSION 3.5)
project(publisher_subscriber)
# Default to C99
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 99)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
include_directories(include)

#find_package(angles REQUIRED)
#find_package(angles)
#find_package(control_toolbox)
#find_package(eigen_conversions)
#find_package(geometry_msgs)
#find_package(mavros)
#find_package(mavros_extras)
#find_package(roscpp)
#find_package(std_msgs)
#find_package(tf2_ros)

# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)

add_executable(publisher src/publisher.cpp)
add_executable(imu_data src/imu_data.cpp)

ament_target_dependencies(imu_data
  rclcpp
  std_msgs
  sensor_msgs)
#target_include_directories(publisher PUBLIC
#  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
#  $<INSTALL_INTERFACE:include>)
#


#target_include_directories(imu_data PUBLIC
#  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
#  $<INSTALL_INTERFACE:include>)
#
install(TARGETS publisher
  DESTINATION lib/${PROJECT_NAME})
install(TARGETS imu_data
  DESTINATION lib/${PROJECT_NAME})
install(DIRECTORY include/
  DESTINATION include)

ament_export_include_directories(include)
ament_export_dependencies(std_msgs)
ament_export_dependencies(sensor_msgs)
if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # uncomment the line when a copyright and license is not present in all source files
  #set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # uncomment the line when this package is not in a git repo
  #set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()
