k
#arm vehicle
ros2 run mavros mav safety arm
#set to stabilize mode
ros2 run mavros mav sys mode -b 15
#print status
ros2 topic echo /mavros/state