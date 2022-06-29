//#include "/opt/ros/foxy/ros.h"
#include "rclcpp/rclcpp.hpp"
#include "sensor_msgs/msg/imu.hpp"
void chatterCallbacl(const sensor_msgs::Imu/*::ConstPtr*/& msg);

void chatterCallback(const sensor_msgs::Imu/*::ConstPtr*/& msg){
    ROS_INFO("\nlinear acceleration\
                \nx: [%f]\ny:[%f]\nz:[%f]", msg->linear_acceleration.x,
                msg->linear_acceleration.y, msg->linear_acceleration.z);
}

int main(int argc, char **argv){
    rclcpp::init(argc, argv);
    //    rclcpp::NodeHandle n;
    auto node = rclcpp::Node:make_shared("imu_data");
    //    rclcpp::Subscriber sub = n.subscribe("/mavros/imu/data", 1000, chatterCallback);
    auto sub = node->create_subscription("/mavros/imu/data", &chatterCallback);
    //    rclcpp::spin();
    rclcpp::spin_some(node);
    return 0;
}
