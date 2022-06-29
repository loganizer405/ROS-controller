rosdep install -i --from-path src --rosdistro foxy -y
colcon build --packages-select manual_pubsub
. install/setup.bash
